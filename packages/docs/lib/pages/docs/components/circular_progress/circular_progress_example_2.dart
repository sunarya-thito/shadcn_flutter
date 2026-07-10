import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Determinate circular progress indicator with controls.
///
/// Demonstrates binding a numeric progress value to [CircularProgressIndicator]
/// and updating it via buttons. Value should be a fraction between 0 and 1.
class CircularProgressExample2 extends StatefulWidget {
  const CircularProgressExample2({super.key});

  @override
  State<CircularProgressExample2> createState() =>
      _CircularProgressExample2State();
}

class _CircularProgressExample2State extends State<CircularProgressExample2> {
  // Track progress in percentage (0-100) for easier mental mapping.
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          // The widget expects a normalized value [0..1].
          value: _progress.clamp(0, 100) / 100,
          size: 48,
        ),
        const Gap(48),
        Row(
          children: [
            DestructiveButton(
              onPressed: () {
                setState(() {
                  // Reset to 0%.
                  _progress = 0;
                });
              },
              child: const Text('Reset'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  // Decrease by 10%.
                  _progress -= 10;
                });
              },
              child: const Text('Decrease by 10'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  // Increase by 10%.
                  _progress += 10;
                });
              },
              child: const Text('Increase by 10'),
            ),
          ],
        )
      ],
    );
  }
}
