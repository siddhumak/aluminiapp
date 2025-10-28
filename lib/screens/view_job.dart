import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Postings'),
        backgroundColor: const Color.fromARGB(255, 59, 196, 126),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Job').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var validJobPostings = snapshot.data!.docs.where((job) {
              var deadlineTimestamp =
                  (job.data() as Map<String, dynamic>)['deadline'] as Timestamp;
              var deadline = deadlineTimestamp.toDate();
              return deadline.isAfter(DateTime.now());
            }).toList();

            if (validJobPostings.isEmpty) {
              return const Center(
                child: Text('No job postings found.'),
              );
            }

            return ListView.builder(
              itemCount: validJobPostings.length,
              itemBuilder: (context, index) {
                var jobData =
                    validJobPostings[index].data() as Map<String, dynamic>;

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          "assets/job.jpg",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${jobData['job_title']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  'Posted by: ${jobData['username']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Description:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text('${jobData['job_description']}'),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('${jobData['location']}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.school, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('${jobData['qualification']}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.money, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('${jobData['salary']}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.phone, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('${jobData['contact']}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.redAccent),
                                const SizedBox(width: 8),
                                Text(
                                  'Deadline: ${DateFormat('yyyy-MM-dd').format(jobData['deadline'].toDate())}',
                                  style: const TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('No job postings found.'),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Job Listings',
    home: JobListPage(),
  ));
}
