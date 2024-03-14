import 'package:demoapp/components/drawer_screen.dart';
import 'package:demoapp/screens/Profile_Screen.dart';
import 'package:demoapp/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 27, 69),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
    );
  }
}
