---
title: "Example: components/app_bar/app_bar_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// AppBar with header, title, subtitle, and action buttons.
///
/// Demonstrates the structure of [AppBar] and how to provide leading and
/// trailing actions using outline-styled icon buttons.
class AppBarExample1 extends StatelessWidget {
  const AppBarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: AppBar(
        // Optional top line above the main title area.
        header: const Text('This is Header'),
        // Primary title and an optional subtitle.
        title: const Text('This is Title'),
        subtitle: const Text('This is Subtitle'),
        leading: [
          // Leading actions typically appear on the left.
          OutlineButton(
            density: ButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.arrow_back),
          ),
        ],
        trailing: [
          // Trailing actions typically appear on the right.
          OutlineButton(
            density: ButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.search),
          ),
          OutlineButton(
            density: ButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

```
