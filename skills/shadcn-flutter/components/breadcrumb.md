# BreadcrumbTheme

Theme for [Breadcrumb].

## Usage

### Breadcrumb Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'breadcrumb/breadcrumb_example_1.dart';

class BreadcrumbExample extends StatelessWidget {
  const BreadcrumbExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'breadcrumb',
      description:
          'Breadcrumbs are a secondary navigation scheme that reveals the user’s location in a website or web application.',
      displayName: 'Breadcrumb',
      children: [
        WidgetUsageExample(
          title: 'Breadcrumb Example',
          path:
              'lib/pages/docs/components/breadcrumb/breadcrumb_example_1.dart',
          child: BreadcrumbExample1(),
        ),
      ],
    );
  }
}

```

### Breadcrumb Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Breadcrumb with arrow separators.
///
/// Demonstrates how to compose a [Breadcrumb] from a series of items,
/// mixing interactive [TextButton]s and static labels. The `separator`
/// controls the visual delimiter between items.
class BreadcrumbExample1 extends StatelessWidget {
  const BreadcrumbExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Breadcrumb(
      // Use a built-in arrow separator for a conventional look.
      separator: Breadcrumb.arrowSeparator,
      children: [
        TextButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Home'),
        ),
        const MoreDots(),
        TextButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Components'),
        ),
        // Final segment as a non-interactive label.
        const Text('Breadcrumb'),
      ],
    );
  }
}

```

### Breadcrumb Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/breadcrumb/breadcrumb_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BreadcrumbTile extends StatelessWidget implements IComponentPage {
  const BreadcrumbTile({super.key});

  @override
  String get title => 'Breadcrumb';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'Breadcrumb',
      name: 'breadcrumb',
      example: BreadcrumbExample1(),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `separator` | `Widget?` | Separator widget between breadcrumb items. |
| `padding` | `EdgeInsetsGeometry?` | Padding around the breadcrumb row. |
