# Divider

A horizontal line widget used to visually separate content sections.

## Usage

### Divider Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'divider/divider_example_1.dart';
import 'divider/divider_example_2.dart';
import 'divider/divider_example_3.dart';

class DividerExample extends StatelessWidget {
  const DividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'divider',
      description:
          'A divider is a thin line that groups content in lists and layouts.',
      displayName: 'Divider',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Divider Example',
          path: 'lib/pages/docs/components/divider/divider_example_1.dart',
          child: DividerExample1(),
        ),
        WidgetUsageExample(
          title: 'Vertical Divider Example',
          path: 'lib/pages/docs/components/divider/divider_example_2.dart',
          child: DividerExample2(),
        ),
        WidgetUsageExample(
          title: 'Divider with Text Example',
          path: 'lib/pages/docs/components/divider/divider_example_3.dart',
          child: DividerExample3(),
        ),
      ],
    );
  }
}

```

### Divider Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Horizontal dividers between list items.
///
/// Use [Divider] to visually separate vertically-stacked content.
class DividerExample1 extends StatelessWidget {
  const DividerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(),
          Text('Item 2'),
          Divider(),
          Text('Item 3'),
        ],
      ),
    );
  }
}

```

### Divider Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Vertical dividers between columns.
///
/// Use [VerticalDivider] to separate horizontally-arranged content.
class DividerExample2 extends StatelessWidget {
  const DividerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Text('Item 1')),
          VerticalDivider(),
          Expanded(child: Text('Item 2')),
          VerticalDivider(),
          Expanded(child: Text('Item 3')),
        ],
      ),
    );
  }
}

```

### Divider Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dividers with centered labels.
///
/// [Divider.child] can render text or other widgets inline with the rule.
class DividerExample3 extends StatelessWidget {
  const DividerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 2'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 3'),
        ],
      ),
    );
  }
}

```

### Divider Example 4
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

### Divider Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../divider/divider_example_3.dart';

class DividerTile extends StatelessWidget implements IComponentPage {
  const DividerTile({super.key});

  @override
  String get title => 'Divider';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'divider',
      title: 'Divider',
      scale: 1.2,
      example: Card(child: DividerExample3()),
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
| `color` | `Color?` | The color of the divider line. |
| `height` | `double?` | The total height of the divider (including padding). |
| `thickness` | `double?` | The thickness of the divider line. |
| `indent` | `double?` | The amount of empty space before the divider line starts. |
| `endIndent` | `double?` | The amount of empty space after the divider line ends. |
| `child` | `Widget?` | Optional child widget to display alongside the divider (e.g., text label). |
| `padding` | `EdgeInsetsGeometry?` | Padding around the divider content. |
| `childAlignment` | `AxisAlignmentGeometry?` | Alignment of the [child] along the divider axis. |
