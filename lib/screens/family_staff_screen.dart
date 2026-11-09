import 'package:flutter/material.dart';
import 'add_member_screen.dart';

class FamilyStaffScreen extends StatelessWidget {
  const FamilyStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data based on the web portal's Family & Staff list
    final List<Map<String, dynamic>> members = [
      {
        'name': 'Iniobong Okon',
        'role': 'Business Owner',
        'contact': '+971 50 255 7843',
        'activeServices': 1,
        'initial': 'I',
        'color': const Color(0xFF1E3A8A)
      },
      {
        'name': 'John Doe',
        'role': 'Staff Member',
        'contact': '+971 55 123 4567',
        'activeServices': 0,
        'initial': 'J',
        'color': Colors.orange
      },
      {
        'name': 'Jane Doe',
        'role': 'Family Member',
        'contact': '+971 52 987 6543',
        'activeServices': 2,
        'initial': 'J',
        'color': Colors.purple
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Family & Staff',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: member['color'],
                child: Text(
                  member['initial'],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                member['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(member['role'], style: const TextStyle(fontSize: 12)),
                  Text(member['contact'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${member['activeServices']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const Text('Services', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
      // Floating Action Button to add a new member
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        onPressed: () {
          // This is the updated navigation code!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMemberScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}