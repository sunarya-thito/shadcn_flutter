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
        gap(16),
        Row(
          children: [
            DestructiveButton(
              onPressed: () {
                setState(() {
                  _progress = 0;
                });
              },
              child: Text('Reset'),
            ),
            gap(16),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  _progress -= 10;
                });
              },
              child: Text('Decrease by 10'),
            ),
            gap(16),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  _progress += 10;
                });
              },
              child: Text('Increase by 10'),
            ),
          ],
        )
      ],
    );
  }
}
