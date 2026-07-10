import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ColorPickerTile extends StatelessWidget implements IComponentPage {
  const ColorPickerTile({super.key});

  @override
  String get title => 'Color Picker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'color_picker',
      title: 'Color Picker',
      reverse: true,
      reverseVertical: true,
      example: Card(
        child: ColorPicker(
          value: ColorDerivative.fromColor(material.Colors.blue),
        ),
      ),
    );
  }
}
