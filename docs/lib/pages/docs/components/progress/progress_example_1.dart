import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProgressExample1 extends StatefulWidget {
  const ProgressExample1({super.key});

  @override
  State<ProgressExample1> createState() => _ProgressExample1State();
}

class _ProgressExample1State extends State<ProgressExample1> {
  // Track the current progress value as a percentage (0–100).
  // This is a controlled example: UI buttons below update this state.
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Constrain the progress bar width so it doesn't grow to the full page width in docs.
        SizedBox(
          width: 400,
          child: Progress(
            // Clamp the provided value so the widget never receives out-of-range input.
            // Alternatively, you can ensure only 0–100 values are set in state.
            progress: _progress.clamp(0, 100),
            // The logical domain for the progress value. Values outside will be coerced by clamp above.
            min: 0,
            max: 100,
          ),
        ),
        const Gap(16),
        // Simple controls to demonstrate changing progress.
        Row(
          children: [
            DestructiveButton(
              onPressed: () {
                setState(() {
                  // Reset back to 0%.
                  _progress = 0;
                });
              },
              child: const Text('Reset'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                // Defensive check so we don't go below 0.
                if (_progress > 0) {
                  setState(() {
                    // Decrease by a fixed step.
                    _progress -= 10;
                  });
                }
              },
              child: const Text('Decrease by 10'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                // Defensive check so we don't go above 100.
                if (_progress < 100) {
                  setState(() {
                    // Increase by a fixed step.
                    _progress += 10;
                  });
                }
              },
              child: const Text('Increase by 10'),
            ),
          ],
        )
      ],
    );
  }
}
