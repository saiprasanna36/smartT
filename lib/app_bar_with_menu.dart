import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class AppBarWithMenu extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  AppBarWithMenu({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Settings') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            } else if (value == 'Logout') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (value == 'About') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("About"),
                  content: Text("This is a Flutter App with Firebase."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(value: 'Settings', child: Text('Settings')),
            PopupMenuItem(value: 'Logout', child: Text('Logout')),
            PopupMenuItem(value: 'About', child: Text('About')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
