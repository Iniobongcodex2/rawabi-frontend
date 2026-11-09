import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'add_document_screen.dart';
import '../localization.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  List<dynamic> _documents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    final url = Uri.parse('http://10.39.1.94:8000/documents');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _documents = jsonDecode(response.body);
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
        title: Text(loc.translate('docVault'), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF1E3A8A)),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddDocumentScreen()),
              );
              if (result == true) fetchDocuments();
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _documents.isEmpty
              ? Center(child: Text(loc.translate('noDocs')))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _documents.length,
                  itemBuilder: (context, index) {
                    final doc = _documents[index];
                    Color statusColor = Colors.green;
                    if (doc['status'] == 'Expiring Soon') statusColor = Colors.orange;
                    if (doc['status'] == 'Expired') statusColor = Colors.red;

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: statusColor.withOpacity(0.1),
                          child: Icon(Icons.description, color: statusColor),
                        ),
                        title: Text(doc['doc_type'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${loc.translate('owner')}: ${doc['owner_name']}\n${loc.translate('expires')}: ${doc['expiry_date']}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            doc['status'], 
                            style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}