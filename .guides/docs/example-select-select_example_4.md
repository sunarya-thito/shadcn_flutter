---
title: "Example: components/select/select_example_4.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample4 extends StatefulWidget {
  const SelectExample4({super.key});

  @override
  State<SelectExample4> createState() => _SelectExample4State();
}

class _SelectExample4State extends State<SelectExample4> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      popupConstraints: const BoxConstraints(
        maxHeight: 300,
        maxWidth: 200,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
      // Constrain popup width to its intrinsic content size (no virtualization in this variant).
      popupWidthConstraint: PopoverConstraint.intrinsic,
      // Use a simple non-virtualized popup; suitable for small lists.
      popup: const SelectPopup.noVirtualization(
        items: SelectItemList(
          children: [
            SelectItemButton(
              value: 'Apple',
              child: Text('Apple'),
            ),
            SelectItemButton(
              value: 'Banana',
              child: Text('Banana'),
            ),
            SelectItemButton(
              value: 'Cherry',
              child: Text('Cherry'),
            ),
          ],
        ),
      ),
    );
  }
}

```
