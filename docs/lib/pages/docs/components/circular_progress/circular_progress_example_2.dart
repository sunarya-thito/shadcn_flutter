import 'package:shadcn_flutter/shadcn_flutter.dart';

class CircularProgressExample2 extends StatefulWidget {
  const CircularProgressExample2({super.key});

  @override
  State<CircularProgressExample2> createState() =>
      _CircularProgressExample2State();
}

class _CircularProgressExample2State extends State<CircularProgressExample2> {
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          value: _progress.clamp(0, 100) / 100,
          size: 48,
        ),
        const Gap(48),
        Row(
          children: [
            DestructiveButton(
              onPressed: () {
                setState(() {
                  _progress = 0;
                });
              },
              child: const Text('Reset'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  _progress -= 10;
                });
              },
              child: const Text('Decrease by 10'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                setState(() {
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
