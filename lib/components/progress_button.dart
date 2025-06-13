import 'package:flutter/material.dart';

/*
  Progress Button
    - clickable button after the progress indicator.
*/

class ProgressButton extends StatelessWidget {
  final int progress;
  final String label;
  final void Function()? onTap;

  const ProgressButton({
    super.key,
    required this.progress,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )
          ),
          child: Text(_getButtonText()),
        ),
      ),
    );
  }

  String _getButtonText() {
    if (label.toLowerCase().contains('best score')) {
      return progress == 0 ? 'Start Test' : 'Take Test Again';
    } else if (label.toLowerCase().contains('progress')) {
      return progress == 0 ? 'Start Module' : 'Continue Learning';
    }
    return progress == 0 ? 'Start' : 'Continue'; // Default fallback
  }
}
