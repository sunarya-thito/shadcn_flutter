---
title: "Example: components/item_picker/item_picker_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample3 extends StatefulWidget {
  const ItemPickerExample3({super.key});

  @override
  State<ItemPickerExample3> createState() => _ItemPickerExample3State();
}

class _ItemPickerExample3State extends State<ItemPickerExample3> {
  final List<NamedColor> colors = const [
    NamedColor('Red', Colors.red),
    NamedColor('Green', Colors.green),
    NamedColor('Blue', Colors.blue),
    NamedColor('Yellow', Colors.yellow),
    NamedColor('Purple', Colors.purple),
    NamedColor('Cyan', Colors.cyan),
    NamedColor('Orange', Colors.orange),
    NamedColor('Pink', Colors.pink),
    NamedColor('Teal', Colors.teal),
    NamedColor('Amber', Colors.amber),
  ];
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showItemPickerDialog<NamedColor>(
          context,
          items: ItemList(colors),
          initialValue: colors[selectedColor],
          title: const Text('Pick a color'),
          builder: (context, item) {
            return ItemPickerOption(
              value: item,
              selectedStyle: const ButtonStyle.primary(
                shape: ButtonShape.circle,
              ),
              style: const ButtonStyle.ghost(
                shape: ButtonShape.circle,
              ),
              label: Text(item.name),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: item.color, shape: BoxShape.circle),
              ),
            );
          },
        ).then(
```
