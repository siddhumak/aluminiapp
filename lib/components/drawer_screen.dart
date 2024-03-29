import 'package:demoapp/components/llist_tiles.dart';
import 'package:demoapp/screens/Profile_Screen.dart';
import 'package:demoapp/screens/chat_screen.dart';
import 'package:demoapp/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Drawer(
      backgroundColor: Color.fromARGB(255, 1, 27, 69),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                  child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              )),
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),
              ),
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen())),
              ),
              MyListTile(
                icon: Icons.settings,
                text: 'S E T T I N G S',
                onTap: () => Navigator.pop(context),
              ),
              MyListTile(
                icon: Icons.chat,
                text: 'D I S C U S S I O N',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  ChatScreen())),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: () async {
                auth.signOut().then(
                  (value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
