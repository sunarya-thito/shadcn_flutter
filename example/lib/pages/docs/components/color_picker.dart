import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorPickerExample extends StatefulWidget {
  @override
  State<ColorPickerExample> createState() => _ColorPickerExampleState();
}

class _ColorPickerExampleState extends State<ColorPickerExample> {
  HSVColor color = HSVColor.fromColor(Colors.blue);
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'color_picker',
      description:
          'A color picker is a widget that allows the user to pick a color.',
      displayName: 'Color Picker',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return SizedBox(
              width: 300,
              child: ColorPickerSet(
                color: color,
                onColorChanged: (value) {
                  setState(() {
                    color = value;
                  });
                },
              ),
            );
          },
          code: '',
        ),
      ],
    );
  }
}
