import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToggleExample2 extends StatefulWidget {
  const ToggleExample2({super.key});

  @override
  _ToggleExample2State createState() => _ToggleExample2State();
}

class _ToggleExample2State extends State<ToggleExample2> {
  int flag = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Toggle(
          value: flag == 0,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 0 : -1;
            });
          },
          child: const Text('B').bold().center(),
        ).sized(width: 40, height: 40),
        Toggle(
          value: flag == 1,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 1 : -1;
            });
          },
          child: const Text('I').italic().center(),
        ).sized(width: 40, height: 40),
        Toggle(
          value: flag == 2,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 2 : -1;
            });
          },
          child: const Text('U').underline().center(),
        ).sized(width: 40, height: 40),
      ],
    ).gap(4);
  }
}
