import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Postings'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('job').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var jobData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                Color titleColor = index % 2 == 0 ? Colors.blue : Colors.green; // Example: alternate colors

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Container(
                      color: titleColor,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        jobData['job_title'],
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text('Description: ${jobData['job_description']}'),
                        SizedBox(height: 4),
                        Text('Location: ${jobData['location']}'),
                        SizedBox(height: 4),
                        Text('Qualification: ${jobData['qualification']}'),
                        SizedBox(height: 4),
                        Text('Salary: ${jobData['salary']}'),
                        SizedBox(height: 8),
                        Text('Deadline:${jobData['deadline']}'),
                        SizedBox(height: 8),
                        Text('Contact:${jobData['contact']}')
                      ],
                    ),
                    onTap: () {
                      // You can add navigation logic here if needed
                    },
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('No job postings found.'),
          );
        },
      ),
    );
  }
}
