import 'package:flutter/material.dart';
import '../components/drawer.dart';


/*
  Setting Page

  - Dark Mode
  - Account Settings
  - Privacy Policy

*/

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  // Build UI
  @override
  Widget build(BuildContext context) {

    // Scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Body
      body: Row(
        children: [
          MyDrawer(),

          Expanded(
            child: Column(
              children: [

                buildContainer(context),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Container buildContainer(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Settings",
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),

          Container(
            height: 50,
            width: 226,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  size: 25,
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Maria Santos",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Student",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
