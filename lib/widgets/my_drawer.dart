import 'package:chat_app/screens/settings_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          ),
          CustomListTile(
            txt: 'H O M E',
            onTap: () {
              Navigator.pop(context);
            },
            icon: Icons.home,
          ),
          CustomListTile(
            txt: 'S E T T I N G S',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingsPage.id);
            },
            icon: Icons.settings,
          ),
          const Spacer(),
          CustomListTile(
            txt: 'L O G O U T',
            onTap: () {
              //FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
