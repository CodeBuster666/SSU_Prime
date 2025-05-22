import 'package:flutter/material.dart';

/*
Drawer Tile it is a simple tile for each item in the menu drawer.

--------------------------------------------------------

Usage
- Title (e.g. "User Profile")
- icon (e.g. "Icons.home")
- function (e.g. goToHomePage)

*/

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;


  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  // Build UI
  @override
  Widget build(BuildContext context) {

    //List of Tiles
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).highlightColor,
      ),
      onTap: onTap,
    );
  }
}