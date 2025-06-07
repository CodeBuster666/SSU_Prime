import 'package:flutter/material.dart';
import '../views/review_modules_page.dart';
import 'drawer_tile.dart';

/*
Menu drawer which is access on the left side of the app bar.

Contains
- User Profile
- Settings
- Log Out

*/

var myAppBar = AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(
    color: Colors.blue,
  ),
);


class MyDrawer extends StatelessWidget {


  MyDrawer({
    super.key,

  });

  /*
  // Access Authentication Service
  final _auth = AuthService();

  // Logout
  void logout() async{
    _auth.logout();
  }

   */

  @override
  Widget build(BuildContext context) {

    // const Drawer
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [

            const SizedBox(height: 30),
            // App logo
            ListTile(
              leading: Icon(
                Icons.school,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                  "SSU Prime",
                style: TextStyle(
                color: Theme.of(context).textTheme.headlineMedium?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),

            const SizedBox(height: 10),

            // Divider line
            Divider(
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).highlightColor,
            ),

            const SizedBox(height: 20),

            // Profile List Tile
            DrawerTile(
              title: "Dashboard",
              icon: Icons.dashboard,
              onTap: () {},
            ),

            // Home List Tile
            DrawerTile(
              title: "Review Modules",
              icon: Icons.reviews,
              onTap: () {
                // pop menu drawer
                Navigator.pop(context);

                // go to home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewModulesPage(),
                  ),
                );
              },
            ),

            //Mock Test List Tile
            DrawerTile(
              title: "Mock Test",
              icon: Icons.text_snippet,
              onTap: () {},
            ),

            //Leadersboard List Tile
            DrawerTile(
              title: "Leadersboard",
              icon: Icons.leaderboard,
              onTap: () {},
            ),

            //Schedule List Tile
            DrawerTile(
              title: "Schedule",
              icon: Icons.date_range,
              onTap: () {},
            ),

            //Settings List Tile
            DrawerTile(
              title: "Settings",
              icon: Icons.settings,
              onTap: () {
                // pop menu drawer
                Navigator.pop(context);

                /*
                // go to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );

                 */


              }, // OnTap
            ),

            const Spacer(),

            // Log Out List Tile
            DrawerTile(
              title: "Log Out",
              icon: Icons.logout,
              onTap: (){},
            ),

            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}



