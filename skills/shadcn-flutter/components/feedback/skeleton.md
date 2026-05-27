# SkeletonTheme

Theme configuration for skeleton loading effects.

## Usage

### Skeleton Example
```dart
import 'package:docs/pages/docs/components/skeleton/skeleton_example_1.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class SkeletonExample extends StatelessWidget {
  const SkeletonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'skeleton',
      description:
          'Skeleton is a placeholder for content that hasn\'t loaded yet.',
      displayName: 'Skeleton',
      children: [
        const Text('This component uses widget from ')
            .thenButton(
                child: const Text('https://pub.dev/packages/skeletonizer'),
                onPressed: () {
                  openInNewTab('https://pub.dev/packages/skeletonizer');
                })
            .p(),
        const WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/skeleton/skeleton_example_1.dart',
          child: SkeletonExample1(),
        ),
      ],
    );
  }
}

```

### Skeleton Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SkeletonExample1 extends StatelessWidget {
  const SkeletonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Basic(
          title: Text('Skeleton Example 1'),
          content:
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: Avatar(
            initials: '',
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
        const Gap(24),
        Basic(
          title: const Text('Skeleton Example 1'),
          content: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: const Avatar(
            initials: '',
          ).asSkeleton(),
          // Note: Avatar and other Image related widget needs its own skeleton
          trailing: const Icon(Icons.arrow_forward),
        )
            // Wrap the whole row in a skeleton to show a loading placeholder for text and icons.
            .asSkeleton(),
      ],
    );
  }
}

```

### Skeleton Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SkeletonTile extends StatelessWidget implements IComponentPage {
  const SkeletonTile({super.key});

  @override
  String get title => 'Skeleton';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Skeleton',
      name: 'skeleton',
      scale: 1,
      example: Card(
        child: Column(
          children: [
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const Avatar(
                initials: '',
              ).asSkeleton(),
              // Note: Avatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
            const Gap(16),
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const Avatar(
                initials: '',
              ).asSkeleton(),
              // Note: Avatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
            const Gap(16),
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const Avatar(
                initials: '',
              ).asSkeleton(),
              // Note: Avatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
          ],
        ),
      ).sized(height: 300),
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
| `duration` | `Duration?` | The duration of one complete pulse animation cycle.  Type: `Duration?`. If null, defaults to 1 second for a natural breathing effect. Controls the speed of the fade in/out pulse animation. |
| `fromColor` | `Color?` | The starting color of the pulse animation.  Type: `Color?`. If null, uses primary color with 5% opacity from theme. Represents the lightest state of the skeleton shimmer effect. |
| `toColor` | `Color?` | The ending color of the pulse animation.  Type: `Color?`. If null, uses primary color with 10% opacity from theme. Represents the darkest state of the skeleton shimmer effect. |
| `enableSwitchAnimation` | `bool?` | Whether to enable smooth transitions when switching between skeleton states.  Type: `bool?`. If null, defaults to true. When enabled, provides smooth fade transitions when toggling skeleton visibility on/off. |
