import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManagement {
  Future<void> storeNewUser(User user, BuildContext context) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('AlumniData')
          .doc(firebaseUser.uid)
          .set({'email': user.email, 'uid': user.uid}).then((_) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }).catchError((e) {
        // Handle error storing user data
      });
    } else {
      // Firebase user is null
    }
  }
}
