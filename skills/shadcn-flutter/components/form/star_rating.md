# StarRating

An interactive star rating widget for collecting user feedback and ratings.

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
| `value` | `double` | The current rating value.  Should be between `0` and [max]. Fractional values are supported. |
| `onChanged` | `ValueChanged<double>?` | Callback invoked when the rating changes.  If `null`, the widget is in read-only mode. |
| `step` | `double` | The minimum increment for rating changes.  When a user interacts with the stars, the value will snap to multiples of this step. Defaults to `0.5` for half-star precision. |
| `direction` | `Axis` | The layout direction of the stars.  Can be [Axis.horizontal] or [Axis.vertical]. Defaults to horizontal. |
| `max` | `double` | The maximum rating value.  Determines how many stars are displayed. Defaults to `5.0`. |
| `activeColor` | `Color?` | The color of filled star portions.  If `null`, uses the theme's primary color. |
| `backgroundColor` | `Color?` | The color of unfilled star portions.  If `null`, uses a default background color from the theme. |
| `starPoints` | `double` | The number of points per star.  Defaults to `5` for traditional five-pointed stars. |
| `starSize` | `double?` | Override size of each star.  If `null`, uses the default size from the theme. |
| `starSpacing` | `double?` | Override spacing between stars.  If `null`, uses the default spacing from the theme. |
| `starPointRounding` | `double?` | Rounding radius for star points.  Controls how rounded the tips of the star points appear. If `null`, uses sharp points. |
| `starValleyRounding` | `double?` | Rounding radius for star valleys.  Controls how rounded the inner valleys between star points appear. If `null`, uses sharp valleys. |
| `starSquash` | `double?` | Vertical compression factor for stars.  Values less than `1.0` make stars appear squashed. If `null`, stars maintain their natural proportions. |
| `starInnerRadiusRatio` | `double?` | Inner to outer radius ratio for stars.  Controls the depth of star valleys. Lower values create deeper valleys. If `null`, uses a default ratio. |
| `starRotation` | `double?` | Rotation angle for stars in radians.  Rotates each star by this angle. If `null`, stars are not rotated. |
| `enabled` | `bool?` | Whether the star rating is interactive.  When `false`, the widget is in read-only mode. Defaults to `true` if [onChanged] is provided. |
