# Card

A versatile container widget that provides a card-like appearance with comprehensive styling options.

## Usage

### Card Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'card/card_example_1.dart';

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'card',
      description:
          'Cards are surfaces that display content and actions on a single topic.',
      displayName: 'Card',
      children: [
        WidgetUsageExample(
          title: 'Card Example',
          path: 'lib/pages/docs/components/card/card_example_1.dart',
          child: CardExample1(),
        ),
      ],
    );
  }
}

```

### Card Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Card with form-like content and actions.
///
/// Demonstrates using [Card] as a container with padding, headings,
/// inputs, and action buttons aligned via a [Row] and [Spacer].
class CardExample1 extends StatelessWidget {
  const CardExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create project').semiBold(),
          const SizedBox(height: 4),
          const Text('Deploy your new project in one-click').muted().small(),
          const SizedBox(height: 24),
          const Text('Name').semiBold().small(),
          const SizedBox(height: 4),
          const TextField(placeholder: Text('Name of your project')),
          const SizedBox(height: 16),
          const Text('Description').semiBold().small(),
          const SizedBox(height: 4),
          const TextField(placeholder: Text('Description of your project')),
          const SizedBox(height: 24),
          Row(
            children: [
              OutlineButton(
                child: const Text('Cancel'),
                onPressed: () {},
              ),
              const Spacer(),
              PrimaryButton(
                child: const Text('Deploy'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ).intrinsic();
  }
}

```

### Card Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../card/card_example_1.dart';

class CardTile extends StatelessWidget implements IComponentPage {
  const CardTile({super.key});

  @override
  String get title => 'Card';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'card',
      title: 'Card',
      example: CardExample1(),
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
| `child` | `Widget` | The child widget to display within the card. |
| `padding` | `EdgeInsetsGeometry?` | Padding inside the card around the [child].  If `null`, uses default padding from the theme. |
| `filled` | `bool?` | Whether the card has a filled background.  When `true`, the card has a solid background color. When `false` or `null`, uses theme defaults. |
| `fillColor` | `Color?` | The background fill color of the card.  Only applies when [filled] is `true`. If `null`, uses theme default. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for rounded corners on the card.  If `null`, uses default border radius from the theme. |
| `borderColor` | `Color?` | Color of the card's border.  If `null`, uses default border color from the theme. |
| `borderWidth` | `double?` | Width of the card's border in logical pixels.  If `null`, uses default border width from the theme. |
| `clipBehavior` | `Clip?` | How to clip the card's content.  Controls overflow clipping behavior. If `null`, uses [Clip.none]. |
| `boxShadow` | `List<BoxShadow>?` | Box shadows to apply to the card.  Creates elevation and depth effects. If `null`, no shadows are applied. |
| `surfaceOpacity` | `double?` | Opacity of the card's surface effect.  Controls the transparency of surface overlays. If `null`, uses theme default. |
| `surfaceBlur` | `double?` | Blur amount for the card's surface effect.  Creates a frosted glass or blur effect. If `null`, no blur is applied. |
| `duration` | `Duration?` | Duration for card appearance animations.  Controls how long transitions take when card properties change. If `null`, uses default animation duration. |
