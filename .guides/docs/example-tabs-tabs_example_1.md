---
title: "Example: components/tabs/tabs_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates Tabs as a header paired with an IndexedStack body.
// Tabs manages the active index; the stack swaps content without unmounting.

class TabsExample1 extends StatefulWidget {
  const TabsExample1({super.key});

  @override
  State<TabsExample1> createState() => _TabsExample1State();
}

class _TabsExample1State extends State<TabsExample1> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tabs(
          // Bind the active tab index; Tabs is the header-only control.
          index: index,
          children: const [
            TabItem(child: Text('Tab 1')),
            TabItem(child: Text('Tab 2')),
            TabItem(child: Text('Tab 3')),
          ],
          onChanged: (int value) {
            // Keep header and body in sync by updating state.
            setState(() {
              index = value;
            });
          },
        ),
        const Gap(8),
        // The IndexedStack acts as the tab body; it switches content by index
        // without unmounting inactive children.
        IndexedStack(
          index: index,
          children: const [
            NumberedContainer(
              index: 1,
            ),
            NumberedContainer(
              index: 2,
            ),
            NumberedContainer(
              index: 3,
            ),
          ],
        ).sized(height: 300),
      ],
    );
  }
}

```
