import 'package:flutter/material.dart';
import 'package:ssu_prime/components/drawer.dart';
import '../utilities/box.dart';
import '../utilities/tile.dart';

/*
  Tablet Scaffold

  - This is where the Tablet size will be displayed.

*/


class TabletScaffold extends StatefulWidget {

  const TabletScaffold({
    super.key,

  });

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: myAppBar,
      body: Column(
        children: [
          // Boxes on the top
          buildAspectRatio(),

          // Tiles below
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Items for the tiles.
              itemBuilder: (context, index) {
                return const MyTile();
              },
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
