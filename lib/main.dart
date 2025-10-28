import 'dart:io';
import 'package:demoapp/components/colors.dart';
import 'package:demoapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyB5ocmM6k9zVb2vMSgX4Ak0SjQ2ZkURJGk',
        appId: '1:1047257889188:android:830dd53a288ac9d9e86931',
        messagingSenderId: '1047257889188',
        projectId: 'demoapp-4f587',
        storageBucket: 'demoapp-4f587.appspot.com',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primarycolor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
