# StarRatingTheme

Theme data for customizing [StarRating] widget appearance.

## Usage

### Star Rating Example
```dart
import 'package:docs/pages/docs/components/star_rating/star_rating_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class StarRatingExample extends StatelessWidget {
  const StarRatingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'star_rating',
      displayName: 'Star Rating',
      description: 'A component for rating.',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/star_rating/star_rating_example_1.dart',
          child: StarRatingExample1(),
        ),
      ],
    );
  }
}

```

### Star Rating Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StarRatingExample1 extends StatefulWidget {
  const StarRatingExample1({super.key});

  @override
  State<StarRatingExample1> createState() => _StarRatingExample1State();
}

class _StarRatingExample1State extends State<StarRatingExample1> {
  // The current rating value (supports fractional values like 1.5 for half-stars).
  double value = 1.5;
  @override
  Widget build(BuildContext context) {
    return StarRating(
      // Control the icon size used for each star.
      starSize: 32,
      value: value,
      onChanged: (value) {
        setState(() {
          // Update the rating when the user taps/drags on the stars.
          this.value = value;
        });
      },
    );
  }
}

```

### Star Rating Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class StarRatingTile extends StatelessWidget implements IComponentPage {
  const StarRatingTile({super.key});

  @override
  String get title => 'Star Rating';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'star_rating',
      title: 'Star Rating',
      scale: 1,
      example: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StarRating(
            starSize: 64,
            value: 3.5,
          ),
          Gap(16),
          StarRating(
            starSize: 64,
            value: 2.5,
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
| `activeColor` | `Color?` | The color of the filled portion of the stars. |
| `backgroundColor` | `Color?` | The color of the unfilled portion of the stars. |
| `starSize` | `double?` | The size of each star. |
| `starSpacing` | `double?` | The spacing between stars. |
