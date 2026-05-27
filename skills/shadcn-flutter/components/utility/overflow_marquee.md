# OverflowMarquee

Automatically scrolling widget for content that overflows its container.

## Usage

### Overflow Marquee Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'overflow_marquee/overflow_marquee_example_1.dart';

class OverflowMarqueeExample extends StatelessWidget {
  const OverflowMarqueeExample({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'overflow_marquee',
      description:
          'A widget that marquee its child when it overflows the available space.',
      displayName: 'Overflow Marquee',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/overflow_marquee/overflow_marquee_example_1.dart',
          child: OverflowMarqueeExample1(),
        ),
      ],
    );
  }
}

```

### Overflow Marquee Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OverflowMarqueeExample1 extends StatelessWidget {
  const OverflowMarqueeExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      child: OverflowMarquee(
        // When the text exceeds the available width, it smoothly scrolls horizontally.
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
      ),
    );
  }
}

```

### Overflow Marquee Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OverflowMarqueeTile extends StatelessWidget implements IComponentPage {
  const OverflowMarqueeTile({super.key});

  @override
  String get title => 'Overflow Marquee';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'overflow_marquee',
      title: 'Overflow Marquee',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 250,
          height: 120,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Scrolling Text:').bold(),
              const Gap(16),
              const OverflowMarquee(
                child: Text(
                  'This is a very long text that will scroll horizontally when it overflows the container width',
                ),
              ),
              const Gap(8),
              const Text('Auto-scrolling overflow text').muted(),
            ],
          ),
        ),
      ),
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
| `child` | `Widget` | The child widget to display and potentially scroll. |
| `direction` | `Axis?` | Scroll direction (horizontal or vertical).  If `null`, uses theme default or [Axis.horizontal]. |
| `duration` | `Duration?` | Total duration for one complete scroll cycle.  If `null`, uses theme default. |
| `step` | `double?` | Distance to scroll per animation step.  If `null`, scrolls the entire overflow amount. |
| `delayDuration` | `Duration?` | Pause duration between scroll cycles.  If `null`, uses theme default. |
| `fadePortion` | `double?` | Portion of edges to apply fade effect (0.0 to 1.0).  For example, 0.15 fades 15% of each edge. If `null`, uses theme default. |
| `curve` | `Curve?` | Animation curve for scroll motion.  If `null`, uses theme default or [Curves.linear]. |
