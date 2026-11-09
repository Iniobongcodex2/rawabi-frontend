import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'family_staff_screen.dart';
import 'login_screen.dart';
import 'my_services_screen.dart';
import '../localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _balance = 0.0;
  List<dynamic> _transactions = [];
  bool _isLoading = true;
  final String userEmail = "admin@rawabi.ae"; // Hardcoded for now

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final balanceUrl = Uri.parse('http://10.39.1.94:8000/wallet/balance/$userEmail');
    final transactionsUrl = Uri.parse('http://10.39.1.94:8000/wallet/transactions/$userEmail');
    
    try {
      // Fetch both at the same time for speed
      final results = await Future.wait([
        http.get(balanceUrl),
        http.get(transactionsUrl),
      ]);

      if (results[0].statusCode == 200 && results[1].statusCode == 200) {
        final balanceData = jsonDecode(results[0].body);
        final transactionsData = jsonDecode(results[1].body);
        
        setState(() {
          _balance = balanceData['balance'].toDouble();
          _transactions = transactionsData;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> addFunds() async {
    final url = Uri.parse('http://10.39.1.94:8000/wallet/add-funds');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": userEmail, "amount": 100.0}),
      );
      if (response.statusCode == 200) {
        fetchData(); // Refresh the balance AND history
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('100 AED Added!'), backgroundColor: Colors.green),
          );
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          loc.translate('profile'),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black54),
            onPressed: () {},
          )
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF1E3A8A)))
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF1E3A8A),
                  child: Text('I', style: TextStyle(fontSize: 32, color: Colors.white)),
                ),
                const SizedBox(height: 12),
                const Text('Iniobong Okon', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Eyibio Business Center LLC', style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 25),

                // Wallet Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Wallet Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_balance.toStringAsFixed(2)} AED',
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF1E3A8A),
                          ),
                          onPressed: addFunds,
                          child: const Text('Add 100 AED', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                
                // Transaction History Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                
                _transactions.isEmpty 
                  ? const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('No transactions yet.', style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) {
                        final txn = _transactions[index];
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green.withOpacity(0.1),
                              child: const Icon(Icons.arrow_downward, color: Colors.green),
                            ),
                            title: Text(txn['description'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            subtitle: Text('${txn['date']} • ${txn['reference_id']}', style: const TextStyle(fontSize: 11)),
                            trailing: Text(
                              '+${txn['amount']} AED',
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),

                const SizedBox(height: 25),

                // Menu Options
                _buildMenuItem(
                  Icons.people, 
                  'Family & Staff', 
                  'Manage dependents and employees',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FamilyStaffScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  Icons.list_alt, 
                  'My Services & Agents', 
                  'Track your active requests',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyServicesScreen()),
                    );
                  },
                ),
                _buildMenuItem(Icons.security, 'Security', 'Passwords and biometrics'),
                _buildMenuItem(
                  Icons.logout, 
                  'Sign Out', 
                  'Log out of your account', 
                  isRed: true,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, {bool isRed = false, VoidCallback? onTap}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: isRed ? Colors.red : const Color(0xFF1E3A8A)),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: isRed ? Colors.red : Colors.black87),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: onTap, 
      ),
    );
  }
}