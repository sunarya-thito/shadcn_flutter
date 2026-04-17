# DotIndicator

Navigation indicator with customizable dots showing current position in a sequence.

## Usage

### Dot Indicator Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'dot_indicator/dot_indicator_example_1.dart';

class DotIndicatorExample extends StatelessWidget {
  const DotIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'dot_indicator',
      description:
          'A widget that displays a series of dots to indicate the current index in a list of items.',
      displayName: 'Dot Indicator',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/dot_indicator/dot_indicator_example_1.dart',
          child: DotIndicatorExample1(),
        ),
      ],
    );
  }
}

```

### Dot Indicator Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DotIndicatorExample1 extends StatefulWidget {
  const DotIndicatorExample1({super.key});

  @override
  State<DotIndicatorExample1> createState() => _DotIndicatorExample1State();
}

class _DotIndicatorExample1State extends State<DotIndicatorExample1> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    // A simple pager-like dot indicator with 5 steps.
    // Tap/click updates the current index via onChanged.
    return DotIndicator(
        index: _index,
        length: 5,
        onChanged: (index) {
          setState(() {
            _index = index;
          });
        });
  }
}

```

### Dot Indicator Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DotIndicatorTile extends StatelessWidget implements IComponentPage {
  const DotIndicatorTile({super.key});

  @override
  String get title => 'Dot Indicator';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'dot_indicator',
      title: 'Dot Indicator',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Page Indicators:').bold(),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const Gap(16),
            const Text('Step 1 of 5').muted(),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}

```



## Features
- **Position indication**: Clear visual representation of current position
- **Interactive navigation**: Optional tap-to-navigate functionality
- **Flexible orientation**: Horizontal or vertical dot arrangement
- **Custom dot builders**: Complete control over dot appearance and behavior
- **Responsive spacing**: Automatic scaling with theme configuration
- **Accessibility support**: Screen reader friendly with semantic information

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `index` | `int` | The current active index (0-based). |
| `length` | `int` | The total number of dots to display. |
| `onChanged` | `ValueChanged<int>?` | Callback invoked when a dot is tapped. |
| `spacing` | `double?` | Spacing between dots. |
| `direction` | `Axis` | The direction of the dot layout (horizontal or vertical). |
| `padding` | `EdgeInsetsGeometry?` | Padding around the dots container. |
| `dotBuilder` | `DotBuilder?` | Custom builder for individual dots. |
