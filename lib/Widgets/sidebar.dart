import 'package:flutter/material.dart';

import '../Screens/home.dart';

class Sidebar extends StatelessWidget {
  final String email;

  const Sidebar({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("User Name"),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.redAccent),
            ),
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/home') {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.smart_toy_outlined),
            title: Text('Models'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/models') {
                Navigator.pushReplacementNamed(context, '/models');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
