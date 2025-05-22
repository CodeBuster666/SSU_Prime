import 'package:flutter/material.dart';
import 'package:ssu_prime/components/drawer.dart';
import 'package:ssu_prime/utilities/box.dart';
import '../utilities/tile.dart';


/*
  Mobile Scaffold

  - This is where the Tablet size will be displayed.

*/


class MobileScaffold extends StatefulWidget {


  const MobileScaffold({
    super.key,

  });

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {

  // Build UI
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
        aspectRatio: 1,
        child: SizedBox(
          width: double.infinity,
          child: GridView.builder(
              itemCount: 4, // items for the boxes.
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return const MyBox();
              },
          ),
        ),
    );
  }
}
