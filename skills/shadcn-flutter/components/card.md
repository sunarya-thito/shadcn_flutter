# CardTheme

Theme data for customizing [Card] and [SurfaceCard] widget appearance.

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
| `padding` | `EdgeInsetsGeometry?` | Padding inside the card. |
| `filled` | `bool?` | Whether the card is filled. |
| `fillColor` | `Color?` | The fill color when [filled] is true. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius of the card. |
| `borderColor` | `Color?` | Border color of the card. |
| `borderWidth` | `double?` | Border width of the card. |
| `clipBehavior` | `Clip?` | Clip behavior of the card. |
| `boxShadow` | `List<BoxShadow>?` | Box shadow of the card. |
| `surfaceOpacity` | `double?` | Surface opacity for blurred background. |
| `surfaceBlur` | `double?` | Surface blur for blurred background. |
| `duration` | `Duration?` | Animation duration for transitions. |
