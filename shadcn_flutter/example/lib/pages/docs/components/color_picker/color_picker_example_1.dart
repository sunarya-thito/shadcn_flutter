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
    return SizedBox(
      width: 300,
      child: HSVColorPickerSet(
        color: color,
        onColorChanged: (value) {
          setState(() {
            color = value;
          });
        },
      ),
    );
  }
}
