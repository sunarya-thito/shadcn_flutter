import 'package:shadcn_flutter/shadcn_flutter.dart';

class LinearProgressExample2 extends StatefulWidget {
  const LinearProgressExample2({super.key});

  @override
  State<LinearProgressExample2> createState() => _LinearProgressExample2State();
}

class _LinearProgressExample2State extends State<LinearProgressExample2> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          child: LinearProgressIndicator(
            // Supplying a value (0.0..1.0) switches the indicator to determinate mode.
            value: value,
          ),
        ),
        const Gap(24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              onPressed: () {
                setState(() {
                  value = 0;
                });
              },
              child: const Text('Reset'),
            ),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                if (value + 0.1 >= 1) {
                  return;
                }
                setState(() {
                  value += 0.1;
                });
              },
              child: const Text('Increase'),
            ),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                if (value - 0.1 <= 0) {
                  return;
                }
                setState(() {
                  value -= 0.1;
                });
              },
              child: const Text('Decrease'),
            ),
          ],
        )
      ],
    );
  }
}
