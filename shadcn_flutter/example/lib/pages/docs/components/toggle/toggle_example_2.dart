import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToggleExample2 extends StatefulWidget {
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
          child: Text('B').bold().center(),
          value: flag == 0,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 0 : -1;
            });
          },
        ).sized(width: 40, height: 40),
        Toggle(
          child: Text('I').italic().center(),
          value: flag == 1,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 1 : -1;
            });
          },
        ).sized(width: 40, height: 40),
        Toggle(
          child: Text('U').underline().center(),
          value: flag == 2,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 2 : -1;
            });
          },
        ).sized(width: 40, height: 40),
      ],
    ).gap(4);
  }
}
