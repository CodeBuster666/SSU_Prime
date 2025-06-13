import 'package:flutter/material.dart';
import 'package:ssu_prime/components/progress_button.dart';

/*

  Card

  --------------------------------------------------------

  Usage
  - Title (e.g. "Mock Test")
  - Icon (e.g. "Icons.test")
  - Label (e.g. "Practice Test")
  - Progress Bar (e.g. Progress: 74%)
  - Function (e.g. goToReviewModulePage)
*/

class MyCard extends StatelessWidget {
  final String title;
  final String description;
  final String label;
  final int progress;
  final VoidCallback ? onPressed;

  const MyCard({
    super.key,
    required this.title,
    required this.description,
    required this.label,
    required this.progress,
    this.onPressed,
  });

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      /*
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),

       */
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              description,
              style:  TextStyle(
                color:Colors.grey[600],
              ),
            ),

            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Text(
                  '$progress%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),

            const SizedBox(height: 25),

            ProgressButton(
              progress: progress,
              label: label,
              onTap: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
