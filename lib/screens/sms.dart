import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart'; // Added for permission handling

class SendSMSPage extends StatefulWidget {
  @override
  _SendSMSPageState createState() => _SendSMSPageState();
}

class _SendSMSPageState extends State<SendSMSPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _sendSMS(String phoneNumber, String message) async {
    // Request permission for sending SMS (optional)
    final status = await Permission.sms.request();
    if (status.isGranted) {
      final uri = 'sms:$phoneNumber?body=${Uri.encodeFull(message)}';
      if (await canLaunchUrl(Uri.parse(uri))) {
        try {
          await launchUrl(Uri.parse(uri));
        } catch (e) {
          // Handle exception (e.g., show an error message)
          print("Error launching SMS: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send SMS: $e'),
            ),
          );
        }
      } else {
        throw 'Could not launch $uri';
      }
    } else {
      // Handle permission denied scenario (e.g., show a message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SMS permission denied'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send SMS'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String phoneNumber = _phoneNumberController.text.trim();
                String message = _messageController.text.trim();
                _sendSMS(phoneNumber, message);
              },
              child: Text('Send SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
