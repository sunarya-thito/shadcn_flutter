import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProgressExample1 extends StatefulWidget {
  const ProgressExample1({super.key});

  @override
  State<ProgressExample1> createState() => _ProgressExample1State();
}

class _ProgressExample1State extends State<ProgressExample1> {
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 400,
          child: Progress(
            progress: _progress.clamp(0, 100),
            min: 0,
            max: 100,
          ),
        ),
        const Gap(16),
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
                if (_progress > 0) {
                  setState(() {
                    _progress -= 10;
                  });
                }
              },
              child: const Text('Decrease by 10'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                if (_progress < 100) {
                  setState(() {
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
