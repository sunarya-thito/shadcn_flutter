# BadgeTheme

Theme data for customizing badge widget appearance across different styles.

## Usage

### Badge Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'badge/badge_example_1.dart';
import 'badge/badge_example_2.dart';
import 'badge/badge_example_3.dart';
import 'badge/badge_example_4.dart';

class BadgeExample extends StatelessWidget {
  const BadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'badge',
      description: 'Badges are small status descriptors for UI elements.',
      displayName: 'Badge',
      children: [
        WidgetUsageExample(
          title: 'Primary Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_1.dart',
          child: BadgeExample1(),
        ),
        WidgetUsageExample(
          title: 'Secondary Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_2.dart',
          child: BadgeExample2(),
        ),
        WidgetUsageExample(
          title: 'Outline Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_3.dart',
          child: BadgeExample3(),
        ),
        WidgetUsageExample(
          title: 'Destructive Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_4.dart',
          child: BadgeExample4(),
        ),
      ],
    );
  }
}

```

### Badge Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Primary badge style.
///
/// Badges are small, attention-grabbing labels. Use `PrimaryBadge` for the
/// default emphasis.
class BadgeExample1 extends StatelessWidget {
  const BadgeExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimaryBadge(
      child: Text('Primary'),
    );
  }
}

```

### Badge Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Secondary badge style.
///
/// Use `SecondaryBadge` for a lighter emphasis compared to primary.
class BadgeExample2 extends StatelessWidget {
  const BadgeExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SecondaryBadge(
      child: Text('Secondary'),
    );
  }
}

```

### Badge Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Outline badge style.
///
/// Outlined appearance for a more subtle badge.
class BadgeExample3 extends StatelessWidget {
  const BadgeExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const OutlineBadge(
      child: Text('Outline'),
    );
  }
}

```

### Badge Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Destructive badge style.
///
/// Use `DestructiveBadge` to call attention to critical or dangerous states.
class BadgeExample4 extends StatelessWidget {
  const BadgeExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return const DestructiveBadge(
      child: Text('Destructive'),
    );
  }
}

```

### Badge Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeTile extends StatelessWidget implements IComponentPage {
  const BadgeTile({super.key});

  @override
  String get title => 'Badge';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'badge',
      title: 'Badge',
      center: true,
      scale: 1.5,
      example: const Column(
        children: [
          PrimaryBadge(child: Text('Primary')),
          SecondaryBadge(child: Text('Secondary')),
          DestructiveBadge(child: Text('Destructive')),
        ],
      ).gap(8),
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
| `primaryStyle` | `AbstractButtonStyle?` | Style for [PrimaryBadge]. |
| `secondaryStyle` | `AbstractButtonStyle?` | Style for [SecondaryBadge]. |
| `outlineStyle` | `AbstractButtonStyle?` | Style for [OutlineBadge]. |
| `destructiveStyle` | `AbstractButtonStyle?` | Style for [DestructiveBadge]. |
