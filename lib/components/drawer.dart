import 'package:flutter/material.dart';
import 'package:ssu_prime/responsive/desktop_scaffold.dart';
import 'package:ssu_prime/views/leaderboard_page.dart';
import 'package:ssu_prime/views/login_page.dart';
import 'package:ssu_prime/views/mock_test_page.dart';
import 'package:ssu_prime/views/schedule_page.dart';
import 'package:ssu_prime/views/setting_page.dart';
import '../services/auth/auth_service.dart';
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


  // Access Authentication Service
  final _auth = AuthService();

  // Logout
  void logout() async{
    _auth.logout();
  }


  @override
  Widget build(BuildContext context) {

    // const Drawer
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),

            const SizedBox(height: 10),

            // Divider line
            Divider(
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).highlightColor,
            ),

            const SizedBox(height: 30),

            // Profile List Tile
            DrawerTile(
              title: "Dashboard",
              icon: Icons.dashboard,
              onTap: () {
                // Pop Menu Drawer
                Navigator.pop(context);

                // Go to Dashboard Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DesktopScaffold(),
                  ),
                );
              },
            ),

            // Home List Tile
            DrawerTile(
              title: "Review Modules",
              icon: Icons.menu_book,
              onTap: () {
                // Pop Menu Drawer
                Navigator.pop(context);

                // Go to Homepage
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
              icon: Icons.quiz,
              onTap: () {
                // Pop Menu Drawer
                Navigator.pop(context);

                // Go to Mock Test
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MockTestPage(),
                  ),
                );

              },
            ),

            //Leadersboard List Tile
            DrawerTile(
              title: "Leadersboard",
              icon: Icons.leaderboard,
              onTap: () {
                // Pop Menu Drawer
                Navigator.pop(context);

                // Go to Leaderboard Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaderboardPage(),
                  ),
                );
              },
            ),

            //Leadersboard List Tile
            DrawerTile(
              title: "Community",
              icon: Icons.people_sharp,
              onTap: () {
                // Pop Menu Drawer
                Navigator.pop(context);

                // Go to Leaderboard Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaderboardPage(),
                  ),
                );
              },
            ),

            //Schedule List Tile
            DrawerTile(
              title: "Schedule",
              icon: Icons.calendar_today,
              onTap: () {
                // Pop Menu Drawer
                Navigator.pop(context);

                // Go to Schedule Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(),
                  ),
                );
              },
            ),

            //Settings List Tile
            DrawerTile(
              title: "Settings",
              icon: Icons.settings,
              onTap: () {
                // Pop menu drawer
                Navigator.pop(context);


                // Go to Settings Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
              }, // OnTap
            ),

            const Spacer(),

            // Log Out List Tile
            DrawerTile(
              title: "Log Out",
              icon: Icons.logout,
              onTap: (){

                // Go to Login Page
                Navigator.push(
                    context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      onTap: logout,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}



