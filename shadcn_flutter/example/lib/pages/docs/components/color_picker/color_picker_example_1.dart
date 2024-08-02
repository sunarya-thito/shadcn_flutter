import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample1 extends StatefulWidget {
  const ColorPickerExample1({super.key});

  @override
  State<ColorPickerExample1> createState() => _ColorPickerExample1State();
}

class _ColorPickerExample1State extends State<ColorPickerExample1> {
  HSVColor color = HSVColor.fromColor(Colors.blue);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HSVColorPicker(
          color: color,
          mode: PromptMode.popover,
          onChanged: (value) {
            setState(() {
              color = value;
            });
          },
        ),
        Gap(16),
        HSVColorPicker(
          color: color,
          mode: PromptMode.dialog,
          onChanged: (value) {
            setState(() {
              color = value;
            });
          },
        ),
      ],
    );
  }
}
