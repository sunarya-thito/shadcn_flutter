---
title: "Example: components/button/button_example_15.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample15 extends StatelessWidget {
  const ButtonExample15({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      leading: const StatedWidget.map(
        states: {
          'disabled': Icon(Icons.close),
          {WidgetState.hovered, WidgetState.focused}:
              Icon(Icons.add_a_photo_rounded),
          WidgetState.hovered: Icon(Icons.add_a_photo),
        },
        child: Icon(Icons.add_a_photo_outlined),
      ),
      onPressed: () {},
      child: const StatedWidget(
        focused: Text('Focused'),
        hovered: Text('Hovered'),
        pressed: Text('Pressed'),
        child: Text('Normal'),
      ),
    );
  }
}

```
