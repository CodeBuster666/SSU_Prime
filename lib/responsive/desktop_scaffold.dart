import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../utilities/box.dart';
import '../utilities/tile.dart';

/*
  Desktop Scaffold

  - This is where the Tablet size will be displayed.

*/


class DesktopScaffold extends StatefulWidget {

  const DesktopScaffold({
    super.key,
  });

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Row(
        children: [
          MyDrawer(),

          Expanded(
            flex: 5,
            child: Column(
              children: [

                // Header
                buildContainer(context),

                // Tile
                buildExpanded(),

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
          SizedBox(width: 100),
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


  Expanded buildExpanded() {
    return Expanded(
      child: Column(
        children: [
          // Tiles at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const MyTile(), // Ensure MyTile is displayed at the top
          ),

          // Boxes below the tile
          Expanded(
            child: () {
              final List<Widget> boxes = [
                const MyBox(
                  icon: Icons.menu_book_outlined,
                  label: "Current Module",
                  title: "Educational Psychology",
                  subText: "Progress: 75%",
                  buttonText: "Resume Module",
                  boxColor: Colors.blueAccent,
                ),
                const MyBox(
                  icon: Icons.description_outlined,
                  label: "Mock Test",
                  title: "Practice Test #4",
                  subText: "Duration: 2 hours",
                  buttonText: "Start Test",
                  boxColor: Colors.green,
                ),
                const MyBox(
                  icon: Icons.emoji_events_outlined,
                  label: "Your Rank",
                  title: "#3 This Week",
                  subText: "Score: 92/100",
                  buttonText: "View Leaderboard",
                  boxColor: Colors.orange,
                ),
                const MyBox(
                  icon: Icons.calendar_today_outlined,
                  label: "Next Session",
                  title: "Child Development",
                  subText: "Today, 2:00 PM",
                  buttonText: "Join Session",
                  boxColor: Colors.purple,
                ),
              ];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: boxes,
                ),
              );
            }(), // Call buildAspectRatio here
          ),
        ],
      ),
    );
  }
}