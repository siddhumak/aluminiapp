import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobPostingForm extends StatefulWidget {
  @override
  _JobPostingFormState createState() => _JobPostingFormState();
}

class _JobPostingFormState extends State<JobPostingForm> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  // Function to submit the form and store data in Firestore
  void _submitForm() {
    FirebaseFirestore.instance.collection('job').add({
      'contact': _contactController.text,
      'deadline': _deadlineController.text,
      'job_description': _jobDescriptionController.text,
      'job_title': _jobTitleController.text,
      'location': _locationController.text,
      'qualification': _qualificationController.text,
      'salary': _salaryController.text,
    }).then((value) {
      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Job posting submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      // Clear all input fields after submission
      _contactController.clear();
      _deadlineController.clear();
      _jobDescriptionController.clear();
      _jobTitleController.clear();
      _locationController.clear();
      _qualificationController.clear();
      _salaryController.clear();
    }).catchError((error) {
      // Handle error if data submission fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting job posting: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Posting Form'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            TextFormField(
              controller: _jobTitleController,
              decoration: InputDecoration(
                

                labelText: 'Job Title',
                border: OutlineInputBorder(),
                
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _jobDescriptionController,
              decoration: InputDecoration(
                labelText: 'Job Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _qualificationController,
              decoration: InputDecoration(
                labelText: 'Qualification',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: 'Salary',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _deadlineController,
              decoration: InputDecoration(
                labelText: 'Deadline',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Job Posting Form',
    home: JobPostingForm(),
  ));
}
