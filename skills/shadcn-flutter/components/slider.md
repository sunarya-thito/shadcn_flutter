# SliderController

Reactive controller for managing slider state with value operations.

## Usage

### Slider Example
```dart
import 'package:docs/pages/docs/components/slider/slider_example_1.dart';
import 'package:docs/pages/docs/components/slider/slider_example_2.dart';
import 'package:docs/pages/docs/components/slider/slider_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SliderExample extends StatelessWidget {
  const SliderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'slider',
      description:
          'A slider is a control for selecting a single value from a range of values.',
      displayName: 'Slider',
      children: [
        WidgetUsageExample(
          title: 'Slider Example',
          path: 'lib/pages/docs/components/slider/slider_example_1.dart',
          child: SliderExample1(),
        ),
        WidgetUsageExample(
          title: 'Slider with Range Example',
          path: 'lib/pages/docs/components/slider/slider_example_2.dart',
          child: SliderExample2(),
        ),
        WidgetUsageExample(
          title: 'Slider with Divisions Example',
          path: 'lib/pages/docs/components/slider/slider_example_3.dart',
          child: SliderExample3(),
        ),
      ],
    );
  }
}

```

### Slider Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample1 extends StatefulWidget {
  const SliderExample1({super.key});

  @override
  State<SliderExample1> createState() => _SliderExample1State();
}

class _SliderExample1State extends State<SliderExample1> {
  // A single-value slider in the 0–1 range (default).
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: (value) {
        setState(() {
          // Update local state when the thumb is dragged.
          this.value = value;
        });
      },
    );
  }
}

```

### Slider Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample2 extends StatefulWidget {
  const SliderExample2({super.key});

  @override
  State<SliderExample2> createState() => _SliderExample2State();
}

class _SliderExample2State extends State<SliderExample2> {
  // A ranged slider has a start and end thumb/value.
  SliderValue value = const SliderValue.ranged(0.5, 0.75);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        const Gap(16),
        // Display the current ranged values below the slider.
        Text('Value: ${value.start} - ${value.end}'),
      ],
    );
  }
}

```

### Slider Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample3 extends StatefulWidget {
  const SliderExample3({super.key});

  @override
  State<SliderExample3> createState() => _SliderExample3State();
}

class _SliderExample3State extends State<SliderExample3> {
  // Single-value slider with a custom range and discrete divisions.
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          // Allow values from 0 to 2 with 10 discrete steps.
          max: 2,
          divisions: 10,
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        const Gap(16),
        // Show the current numeric value.
        Text('Value: ${value.value}'),
      ],
    );
  }
}

```

### Slider Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SliderTile extends StatelessWidget implements IComponentPage {
  const SliderTile({super.key});

  @override
  String get title => 'Slider';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'slider',
      title: 'Slider',
      center: true,
      scale: 2,
      example: Slider(
        value: const SliderValue.single(0.75),
        onChanged: (value) {},
      ).sized(width: 100),
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

