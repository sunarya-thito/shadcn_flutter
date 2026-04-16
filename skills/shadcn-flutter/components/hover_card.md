# HoverCardTheme

Theme configuration for hover card behavior and appearance.

## Usage

### Hover Card Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/hover_card/hover_card_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverCardExample extends StatelessWidget {
  const HoverCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'hover_card',
      description:
          'For sighted users to preview content available behind a link',
      displayName: 'Hover Card',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/hover_card/hover_card_example_1.dart',
          child: HoverCardExample1(),
        ),
      ],
    );
  }
}

```

### Hover Card Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverCardExample1 extends StatelessWidget {
  const HoverCardExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // HoverCard shows a floating panel when the user hovers over the child.
    // - hoverBuilder builds the content of the floating card.
    // - child is the anchor widget users point at/hover to reveal the card.
    return HoverCard(
      hoverBuilder: (context) {
        // SurfaceCard provides an elevated container with default padding and
        // surface styling. We constrain the width so the text wraps nicely.
        return const SurfaceCard(
          child: Basic(
            leading: FlutterLogo(),
            title: Text('@flutter'),
            content: Text(
                'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.'),
          ),
        ).sized(width: 300);
      },
      child: LinkButton(
        // The LinkButton acts as the hover target. onPressed is provided for
        // completeness but not used in this example.
        onPressed: () {},
        child: const Text('@flutter'),
      ),
    );
  }
}

```

### Hover Card Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material hide Card;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CursorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = material.Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 12)
      ..lineTo(3, 9)
      ..lineTo(5, 11)
      ..lineTo(7, 9)
      ..lineTo(4, 7)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HoverCardTile extends StatelessWidget implements IComponentPage {
  const HoverCardTile({super.key});

  @override
  String get title => 'Hover Card';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'hover_card',
      title: 'Hover Card',
      scale: 1,
      example: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('@flutter').medium().underline(),
              const Gap(16),
              const Card(
                child: Basic(
                  leading: FlutterLogo(),
                  title: Text('@flutter'),
                  content: Text(
                      'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.'),
                ),
              ).sized(width: 300),
            ],
          ),
          Positioned(
            top: 13,
            left: 160,
            child: CustomPaint(
              painter: CursorPainter(),
            ),
          ),
        ],
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
| `debounce` | `Duration?` | Duration to wait before hiding the hover card after mouse exit. |
| `wait` | `Duration?` | Duration to wait before showing the hover card after mouse enter. |
| `popoverAlignment` | `AlignmentGeometry?` | Alignment of the popover relative to its anchor. |
| `anchorAlignment` | `AlignmentGeometry?` | Alignment point on the anchor widget. |
| `popoverOffset` | `Offset?` | Offset of the popover from its calculated position. |
| `behavior` | `HitTestBehavior?` | Hit test behavior for mouse interactions. |
