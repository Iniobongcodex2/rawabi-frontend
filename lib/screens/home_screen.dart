import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeServices = 0;
  int pendingRequests = 0;
  int expiringDocs = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    final url = Uri.parse('http://10.39.1.94:8000/dashboard-stats');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          activeServices = data['active_services'];
          pendingRequests = data['pending_requests'];
          expiringDocs = data['expiring_documents'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.business, color: Color(0xFF1E3A8A)),
            SizedBox(width: 8),
            Text(
              'Rawabi',
              style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFF1E3A8A),
              child: Text('I', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: fetchStats,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('welcomeBack'),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Text(
                    'Iniobong Okon!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusCard(loc.translate('activeServices'), activeServices.toString(), Colors.blue),
                      _buildStatusCard(loc.translate('pending'), pendingRequests.toString(), Colors.orange),
                      _buildStatusCard(loc.translate('expiringDocs'), expiringDocs.toString(), Colors.red),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Text(
                    loc.translate('quickActions'),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuickAction(
                        icon: Icons.add_circle_outline,
                        title: loc.translate('requestService'),
                        color: Colors.orange,
                      ),
                      _buildQuickAction(
                        icon: Icons.upload_file,
                        title: loc.translate('uploadDoc'),
                        color: Colors.green,
                      ),
                      _buildQuickAction(
                        icon: Icons.video_call,
                        title: loc.translate('bookVideo'),
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Text(
                    loc.translate('mainServices'),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  // UPDATED GRID WITH ARABIC TRANSLATIONS
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                    children: [
                      _buildServiceCard(loc.locale.languageCode == 'ar' ? 'تأسيس الأعمال' : 'Business Setup', Icons.business_center, Colors.green),
                      _buildServiceCard(loc.locale.languageCode == 'ar' ? 'العلامة التجارية' : 'Trade Mark', Icons.copyright, Colors.blue),
                      _buildServiceCard(loc.locale.languageCode == 'ar' ? 'تأشيرة العائلة' : 'Family Visa', Icons.family_restroom, Colors.purple),
                      _buildServiceCard(loc.locale.languageCode == 'ar' ? 'خدمات تسهيل' : 'Tasheel Services', Icons.assignment, Colors.orange),
                      _buildServiceCard(loc.locale.languageCode == 'ar' ? 'الهوية الإماراتية' : 'Emirates ID', Icons.badge, Colors.teal),
                      _buildServiceCard(loc.locale.languageCode == 'ar' ? 'التأمين الصحي' : 'Health Insurance', Icons.health_and_safety, Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildStatusCard(String title, String count, Color color) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(count, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildQuickAction({required IconData icon, required String title, required Color color}) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color.withOpacity(0.9)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 18,
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}