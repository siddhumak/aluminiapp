import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest Updates'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Updates').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var updateDoc = snapshot.data!.docs[index];
              var updateData = updateDoc.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          'Headlines: ${updateData['headline'] ?? 'N/A'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Description: ${updateData['description'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            if (updateData['fileUrl'] != null)
                              updateData['fileUrl']
                                      .toString()
                                      .toLowerCase()
                                      .endsWith('.pdf')
                                  ? ElevatedButton(
                                      onPressed: () {
                                        // Handle PDF file opening
                                      },
                                      child: const Text('Open PDF'),
                                    )
                                  : Image.network(
                                      updateData['fileUrl'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                            else
                              const Text(
                                'Document: N/A',
                                style: TextStyle(fontSize: 16),
                              ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
