import 'package:demoapp/model/user_model.dart';
import 'package:demoapp/screens/Profile_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data()!);
      setState(() {});
    });
  }

  final TextEditingController _textController = TextEditingController();

  void _addMessage(String message) async {
    await FirebaseFirestore.instance.collection('messages').add({
      'text': message,
      'username': "${loggedInUser.firstName} ${loggedInUser.secondName}",
      'timestamp': DateTime.now(),
    });
    _textController.clear(); // Clear the text field after sending message
  }

  Stream<List<DocumentSnapshot>> _getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
  children: [
    Expanded(
      child: StreamBuilder<List<DocumentSnapshot>>(
        stream: _getMessages(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final messageData =
                  snapshot.data![index].data() as Map<String, dynamic>;
              final messageText = messageData['text'];
              final messageUsername = messageData['username'];
              Color titleColor =
                  index % 3 == 0 ? Color.fromARGB(255, 184, 246, 165) : Color.fromARGB(255, 214, 244, 249);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 40,
                  height: 80,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 154, 148, 148)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color.fromARGB(255, 235, 230, 230),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        16.0, 16.0, 16.0, 8.0), // Add left padding
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (messageUsername != null &&
                              messageUsername.isNotEmpty)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: titleColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  messageUsername,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          SizedBox(height: 4.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              messageText,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
    Divider(height: 1.0),
    _buildTextComposer(),
  ],
),

    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a Message',
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _addMessage(text);
  }
}
