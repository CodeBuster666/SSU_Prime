import 'package:flutter/material.dart';

/*
  Setting List Tile

  A simple tile for each item in the setting page.

  ----------------------------------------------------------------
  Instruction:
    To use this widget, you need:

    - title (e.g. "Light Mode")
    - action (e.g. toggleTheme() )
*/

class SettingTile extends StatelessWidget {
  final String title;
  final Widget action;

  const SettingTile({
    super.key,
    required this.title,
    required this.action,
  });

  // Build UI
  @override
  Widget build(BuildContext context) {

    // Container
    return Container(
        decoration: BoxDecoration(

          //Color of the list tile
          color: Theme.of(context).colorScheme.secondary,

          // Curve Border
          borderRadius: BorderRadius.circular(10),
        ),

        // Padding  outside the list tile
        margin:  const EdgeInsets.only(left: 24, right: 24, top: 10),

        // Padding inside the list tile
        padding: const EdgeInsets.all(8),

        // Row
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            Text(title,
              style: TextStyle(
                fontWeight:
                FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),

            // Action
            action,
          ],
        )
    );
  }
}
