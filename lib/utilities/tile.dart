import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile({super.key});

  @override
  Widget build(BuildContext context) {
    // Example progress value (e.g. 70%)
    double progress = 0.7;

    return Padding(
      padding: const EdgeInsets.all(0.9),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text
            Row(
              children: const [
                Text(
                  '👏 WELCOME BACK 👏',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),

            // Subtitle
            const Text(
              'Track your progress and continue your review journey',
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 10), // Adjust spacing before progress
            // Progress bar with percentage
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
                const SizedBox(height: 1),
                Text(
                  '${(progress * 100).toInt()}% complete',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
