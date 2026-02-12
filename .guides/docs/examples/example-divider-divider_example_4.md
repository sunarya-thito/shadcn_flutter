---
title: "Example: components/divider/divider_example_4.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DividerExample4 extends StatelessWidget {
  const DividerExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      width: 600,
      height: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).colorScheme.border.withAlpha(64),
            width: 100,
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return Button.ghost(
                  onPressed: () {},
                  child: Text('Button $index'),
                );
              },
            ),
          ),
          PaintOrder(
            paintOrder: 3,
            child: VerticalDivider(
              childAlignment: const AxisAlignment(-0.6),
              padding: EdgeInsets.zero,
              child: IconButton.outline(
                icon: const Icon(Icons.arrow_back_ios_new),
                shape: ButtonShape.circle,
                size: ButtonSize.small,
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

```
