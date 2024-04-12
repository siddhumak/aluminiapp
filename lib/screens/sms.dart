import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendMail extends StatefulWidget {
  final String data;
  final String data2;

  SendMail({required this.data, required this.data2});
=======
import 'package:permission_handler/permission_handler.dart'; // Added for permission handling
import 'package:url_launcher/url_launcher.dart';
>>>>>>> Stashed changes

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final TextEditingController _recipientEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TextEditingController _mailMessageController;

  @override
  void initState() {
    super.initState();
    _mailMessageController = TextEditingController(
      text: '''Hello ${widget.data2},

We are pleased to inform you that your application for alumni access has been approved by the Deccan Education Society office team. Your username for the app is "${widget.data}" and your password is "${_passwordController.text}". Thank you for becoming a member of the DES Connect app alumni community.

Best regards,
[Your Name/DES Team]''',
    );
  }

  // Send Mail function
  void sendMail({
    required String recipientEmail,
    required String mailMessage,
    required String password,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: recipientEmail,
        password: password,
      );

      // If user creation is successful, proceed to send email
      if (userCredential.user != null) {
        String username = 'bandbeyash2001@gmail.com';
        final smtpServer = gmail(username, password);
        final message = Message()
          ..from = Address(username, 'Mail Service')
          ..recipients.add(recipientEmail)
          ..subject = 'Mail '
          ..text = 'Message: $mailMessage';

        await send(message, smtpServer);
        showSnackbar('Email sent successfully');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Mailer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Recipient Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              controller: _recipientEmailController..text = widget.data,
            ),
            const SizedBox(height: 30),
            TextFormField(
              maxLines: 5,
              controller: _mailMessageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),

            const SizedBox(height: 30),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  // Update the message text whenever the password changes
                  _updateMessageText(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  sendMail(
                    recipientEmail:
                        _recipientEmailController.text.toString(),
                    mailMessage: _mailMessageController.text.toString(),
                    password: _passwordController.text.toString(),
                  );
                },
                child: const Text('Send Mail'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateMessageText(String password) {
    setState(() {
      _mailMessageController.text = '''Hello ${widget.data2},

We are pleased to inform you that your application for alumni access has been approved by the Deccan Education Society office team. Your username for the app is "${widget.data}" and your password is "$password". Thank you for becoming a member of the DES Connect app alumni community.

Best regards,
[Your Name/DES Team]''';
    });
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FittedBox(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
