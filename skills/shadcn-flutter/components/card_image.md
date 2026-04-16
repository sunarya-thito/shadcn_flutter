# CardImageTheme

Theme configuration for [CardImage] components.

## Usage

### Card Image Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/card_image/card_image_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardImageExample extends StatelessWidget {
  const CardImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'card_image',
      description:
          'A card image is an interactive card that displays an image.',
      displayName: 'Card Image',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/card_image/card_image_example_1.dart',
          child: CardImageExample1(),
        ),
      ],
    );
  }
}

```

### Card Image Example 1
```dart
import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Horizontally scrollable list of CardImage items.
///
/// Demonstrates enabling both touch and mouse drag for horizontal scroll,
/// and using [CardImage] to show an image with title/subtitle. Tapping a
/// card opens a simple dialog.
class CardImageExample1 extends StatelessWidget {
  const CardImageExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 10; i++)
                CardImage(
                  // Simple interaction: open a dialog on tap.
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Card Image'),
                          content: const Text('You clicked on a card image.'),
                          actions: [
                            PrimaryButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  // Network image; replace with your own provider as needed.
                  image: Image.network(
                    'https://picsum.photos/200/300',
                  ),
                  // Title and subtitle appear over the image.
                  title: Text('Card Number ${i + 1}'),
                  subtitle: const Text('Lorem ipsum dolor sit amet'),
                ),
            ],
          ).gap(8),
        ),
      ),
    );
  }
}

```

### Card Image Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardImageTile extends StatelessWidget implements IComponentPage {
  const CardImageTile({super.key});

  @override
  String get title => 'Card Image';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'card_image',
      title: 'Card Image',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.border),
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 48,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Card Title').bold().large(),
                    const Gap(8),
                    const Text(
                            'This is a description of the card content. It provides additional information about the image above.')
                        .muted(),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlineButton(
                            onPressed: () {},
                            child: const Text('Cancel'),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: PrimaryButton(
                            onPressed: () {},
                            child: const Text('Action'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
| `style` | `AbstractButtonStyle?` | Button style for the card. |
| `direction` | `Axis?` | Layout direction for title/subtitle relative to the image. |
| `hoverScale` | `double?` | Scale factor when hovering over the image. |
| `normalScale` | `double?` | Normal scale factor for the image. |
| `backgroundColor` | `Color?` | Background color for the image container. |
| `borderColor` | `Color?` | Border color for the image container. |
| `gap` | `double?` | Gap between image and text content. |
