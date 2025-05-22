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
      appBar: myAppBar,
      body: Row(
        children: [
          MyDrawer(),

          Expanded(
            flex: 2,
            child: Column(
            children: [
              // Boxes on the top
              buildAspectRatio(),

                // Tiles below
              Expanded(
                child: ListView.builder(itemCount: 4, // Items for the tiles.
                  itemBuilder: (context, index) {
                    return const MyTile();
                  },
                ),
              ),
            ],
    ),
          ),

          // Tiles to the right side
          Expanded(
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.yellow)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio buildAspectRatio() {
    return AspectRatio(
        aspectRatio: 4,
        child: SizedBox(
          width: double.infinity,
          child: GridView.builder(
              itemCount: 4, // items for the boxes.
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) {
              return const MyBox();
              },
          ),
        ),
    );
  }
}
