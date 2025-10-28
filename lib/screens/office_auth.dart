import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/components/colors.dart';
import 'package:demoapp/screens/material_screen.dart';
import 'package:demoapp/screens/sms.dart';
import 'package:flutter/material.dart';

class OfficeAuth extends StatefulWidget {
  const OfficeAuth({super.key});

  @override
  State<OfficeAuth> createState() => _OfficeAuthState();
}

class _OfficeAuthState extends State<OfficeAuth> {
  late List<DocumentSnapshot> alumniDocs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to another page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MaterialScreen(), // Replace with your desired page
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('AlumniData').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                alumniDocs = snapshot.data!.docs.toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(alumniDocs.length, (index) {
                    var doc = alumniDocs[index];

                    var alumniData = doc.data() as Map<String, dynamic>;
                    var emailField = alumniData['email'];
                    var passout = alumniData['date'];
                    var phoneno = alumniData['phoneno'];
                    var imageUrl = alumniData['imageUrl'];

                    return Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                                'Full Name: ${alumniData['secondName']} ${alumniData['firstName'] ?? 'N/A'}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${emailField ?? 'N/A'}'),
                                Text('Passout: ${passout ?? 'N/A'}'),
                                Text('Phone No: ${phoneno ?? 'N/A'}'),
                                imageUrl != null
                                    ? Image.network(
                                        imageUrl,
                                        width: 800,
                                        height: 300,
                                        fit: BoxFit.fill,
                                      )
                                    : const Text('Document: N/A'),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 116, 243, 120)),
                                ),
                                onPressed: () {
                                  String email = alumniData["email"];
                                  String username2 = alumniData["secondName"];

                                  // Navigate to SendMail page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SendMail(
                                        email: email,
                                        username: username2,
                                        alumniData:
                                            alumniData, // Pass all alumni data to the SendMail page
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Verify"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 244, 43, 43)),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                onPressed: () {
                                  _rejectCard(
                                      doc); // Call function to reject card
                                },
                                child: const Text("Reject"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                );
            }
          },
        ),
      ),
    );
  }

  // Function to reject the card and delete data from Firestore
  void _rejectCard(DocumentSnapshot doc) {
    // Remove card from UI
    setState(() {
      alumniDocs.remove(doc);
    });

    // Delete corresponding document from Firestore
    FirebaseFirestore.instance
        .collection('AlumniData')
        .doc(doc.id)
        .delete()
        .then((value) {
      // Document successfully deleted
    }).catchError((error) {
      // Failed to delete document
      // Re-add the card to the UI if deletion fails
      setState(() {
        alumniDocs.add(doc);
      });
    });
  }
}
