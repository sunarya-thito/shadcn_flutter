import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class InputTile extends StatelessWidget implements IComponentPage {
  const InputTile({super.key});

  @override
  String get title => 'Text Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'input',
      title: 'Text Input',
      scale: 2,
      example: Card(
        child: const TextField(
          initialValue: 'Hello World',
          features: [
            InputFeature.leading(Icon(material.Icons.edit)),
          ],
        ).sized(width: 250, height: 32),
      ).sized(height: 400),
    );
  }
}
