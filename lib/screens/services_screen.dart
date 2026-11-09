import 'package:flutter/material.dart';
import 'service_request_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {'title': 'Business Setup', 'icon': Icons.business_center, 'color': Colors.green},
      {'title': 'Trade Mark', 'icon': Icons.copyright, 'color': Colors.blue},
      {'title': 'Equivalency', 'icon': Icons.compare_arrows, 'color': Colors.teal},
      {'title': 'Family Visa', 'icon': Icons.family_restroom, 'color': Colors.purple},
      {'title': 'Tasheel Services', 'icon': Icons.assignment, 'color': Colors.orange},
      {'title': 'Court Services - Legal', 'icon': Icons.gavel, 'color': Colors.brown},
      {'title': 'Traffic Services', 'icon': Icons.directions_car, 'color': Colors.redAccent},
      {'title': 'Tax and Audit Services', 'icon': Icons.calculate, 'color': Colors.indigo},
      {'title': 'Corporate Visa Services', 'icon': Icons.badge, 'color': Colors.blueGrey},
      {'title': 'Certificate Attestation', 'icon': Icons.verified, 'color': Colors.cyan},
      {'title': 'Health Insurance', 'icon': Icons.health_and_safety, 'color': Colors.red},
      {'title': 'Travels and Ticketing', 'icon': Icons.flight, 'color': Colors.lightBlue},
      {'title': 'Tenancy Registration', 'icon': Icons.home_work, 'color': Colors.deepOrange},
      {'title': 'Emirates ID Services', 'icon': Icons.perm_identity, 'color': Colors.teal},
      {'title': 'Permits and Approval', 'icon': Icons.approval, 'color': Colors.amber},
      {'title': 'Renew License', 'icon': Icons.autorenew, 'color': Colors.green},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Our Services',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
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
                backgroundColor: service['color'].withOpacity(0.1),
                child: Icon(service['icon'], color: service['color']),
              ),
              title: Text(
                service['title'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceRequestScreen(
                      serviceName: service['title'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}