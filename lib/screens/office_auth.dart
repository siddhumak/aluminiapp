import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfficeAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Details'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Alumni').snapshots(),
          builder:(context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: snapshot.data?.docs.map((doc) {
                    var alumniData = doc.data() as Map<String, dynamic>; // Explicit cast to Map<String, dynamic>
                    var emailField = alumniData['emailField'];
                    var passout = alumniData['passout'];
                    var phoneno = alumniData['phoneno'];
                    var imageUrl = alumniData['imageUrl']; // Assuming imageUrl is the field where the image URL is stored

                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text('Full Name: ${alumniData['Fullname'] ?? 'N/A'}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${emailField ?? 'N/A'}'),
                                Text('Passout: ${passout ?? 'N/A'}'),
                                Text('Phone No: ${phoneno ?? 'N/A'}'),
                                imageUrl != null
                                    ? Image.network(
                                        imageUrl,
                                        width: 500,
                                        height: 300,
                                      )
                                    : Text('Document: N/A'),
                              ],
                            ),
                          ),
                          // Add more widgets to display other alumni details
                        ],
                      ),
                    );
                  }).toList() ?? [],
                );
            }
          },
        ),
      ),
    );
  }
}