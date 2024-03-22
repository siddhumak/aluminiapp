import 'dart:io';
<<<<<<< HEAD
import 'package:demoapp/components/drawer_screen.dart';
import 'package:demoapp/screens/admregister_screen.dart';
import 'package:demoapp/screens/chat_screen.dart';
import 'package:demoapp/screens/job_form.dart';
=======
import 'package:demoapp/screens/add_post_screen.dart';
import 'package:demoapp/screens/admregister_screen.dart';
import 'package:demoapp/screens/homescreen.dart';
>>>>>>> 030ce7e4671bac2a0cd5b8caf973a4f915502365
import 'package:demoapp/screens/login_screen.dart';
import 'package:demoapp/onboarding_screen/onboarding_screen.dart';
import 'package:demoapp/screens/office_auth.dart';
import 'package:demoapp/screens/sms.dart';
import 'package:demoapp/screens/splash_screen.dart';
import 'package:demoapp/screens/view_job.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 1, 27, 69)),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: SendSMSPage(),
=======
      home: HomeScreen(),
>>>>>>> 030ce7e4671bac2a0cd5b8caf973a4f915502365
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Text('hello world'),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
