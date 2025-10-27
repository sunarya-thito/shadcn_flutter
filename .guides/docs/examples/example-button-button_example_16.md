---
title: "Example: components/button/button_example_16.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample16 extends StatelessWidget {
  const ButtonExample16({super.key});

  @override
  Widget build(BuildContext context) {
    return CardButton(
      onPressed: () {},
      child: const Basic(
        title: Text('Project #1'),
        subtitle: Text('Project description'),
        content:
            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      ),
    );
  }
}

```
