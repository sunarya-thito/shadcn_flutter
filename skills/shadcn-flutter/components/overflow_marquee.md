# OverflowMarqueeTheme

Theme configuration for [OverflowMarquee] scrolling text displays.

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
| `direction` | `Axis?` | Scrolling direction of the marquee. |
| `duration` | `Duration?` | Duration of one full scroll cycle. |
| `delayDuration` | `Duration?` | Delay before scrolling starts again. |
| `step` | `double?` | Step size used to compute scroll speed. |
| `fadePortion` | `double?` | Portion of the child to fade at the edges. |
| `curve` | `Curve?` | Animation curve of the scroll. |
