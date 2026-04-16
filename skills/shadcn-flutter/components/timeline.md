# TimelineTheme

Theme configuration for [Timeline] widgets.

## Usage

### Timeline Example
```dart
import 'package:docs/pages/docs/components/timeline/timeline_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TimelineExample extends StatelessWidget {
  const TimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'timeline',
      description: 'A timeline is a way of displaying a list of events in '
          'chronological order, sometimes described as a project artifact.',
      displayName: 'Timeline',
      children: [
        WidgetUsageExample(
          title: 'Timeline Example',
          path: 'lib/pages/docs/components/timeline/timeline_example_1.dart',
          child: TimelineExample1(),
        ),
      ],
    );
  }
}

```

### Timeline Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a static Timeline with entries showing time, title, and content.

class TimelineExample1 extends StatelessWidget {
  const TimelineExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Timeline(
      // Each TimelineData item renders a time, title, and detailed content.
      // Styling/layout comes from the Timeline widget; content is plain widgets.
      data: [
        TimelineData(
          time: const Text('2022-01-01'),
          title: const Text('First event'),
          content: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Odio euismod lacinia at quis risus sed vulputate odio ut. Quam viverra orci sagittis eu volutpat odio facilisis mauris.'),
        ),
        TimelineData(
          time: const Text('2022-01-02'),
          title: const Text('Second event'),
          content: const Text(
              'Aut eius excepturi ex recusandae eius est minima molestiae. Nam dolores iusto ad fugit reprehenderit hic dolorem quisquam et quia omnis non suscipit nihil sit libero distinctio. Ad dolorem tempora sit nostrum voluptatem qui tempora unde? Sit rerum magnam nam ipsam nesciunt aut rerum necessitatibus est quia esse non magni quae.'),
        ),
        TimelineData(
          time: const Text('2022-01-03'),
          title: const Text('Third event'),
          content: const Text(
            'Sit culpa quas ex nulla animi qui deleniti minus rem placeat mollitia. Et enim doloremque et quia sequi ea dolores voluptatem ea rerum vitae. Aut itaque incidunt est aperiam vero sit explicabo fuga id optio quis et molestiae nulla ex quae quam. Ab eius dolores ab tempora dolorum eos beatae soluta At ullam placeat est incidunt cumque.',
          ),
        ),
      ],
    );
  }
}

```

### Timeline Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/timeline/timeline_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimelineTile extends StatelessWidget implements IComponentPage {
  const TimelineTile({super.key});

  @override
  String get title => 'Timeline';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'timeline',
      title: 'Timeline',
      scale: 1,
      example: const TimelineExample1().sized(width: 700, height: 800),
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
| `timeConstraints` | `BoxConstraints?` | Default constraints for the time column width.  Controls the minimum and maximum width allocated for displaying time information in each timeline row. If null, individual Timeline widgets use their own constraints or a default of 120 logical pixels. |
| `spacing` | `double?` | Default horizontal spacing between timeline columns.  Determines the gap between the time column, indicator column, and content column. If null, defaults to 16 logical pixels scaled by theme scaling factor. |
| `dotSize` | `double?` | Default diameter of timeline indicator dots.  Controls the size of the circular (or square, based on theme radius) indicator that marks each timeline entry. If null, defaults to 12 logical pixels. |
| `connectorThickness` | `double?` | Default thickness of connector lines between timeline entries.  Controls the width of vertical lines that connect timeline indicators. If null, defaults to 2 logical pixels scaled by theme scaling factor. |
| `color` | `Color?` | Default color for indicators and connectors when not specified per entry.  Used as the fallback color for timeline dots and connecting lines when individual [TimelineData] entries don't specify their own color. |
| `rowGap` | `double?` | Default vertical spacing between timeline rows.  Controls the gap between each timeline entry in the vertical layout. If null, defaults to 16 logical pixels scaled by theme scaling factor. |
