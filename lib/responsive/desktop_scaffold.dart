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
          Text(
            'SSU Prime Header',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          Container(
            height: 40,
            width: 100,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text('Yellow Box'),
          ),
        ],
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: Column(
        children: [

          // Tiles below
          Padding(padding: const EdgeInsets.all(8.0)),
          Expanded(
            child: ListView.builder(itemCount: 1, // Items for the tiles.
              itemBuilder: (context, index) {
              return const MyTile();
              },
            ),
          ),

          // Boxes on the top
          buildAspectRatio(),
        ],
      ),
    );
  }


  AspectRatio buildAspectRatio() {
    return AspectRatio(
        aspectRatio: 3,
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
