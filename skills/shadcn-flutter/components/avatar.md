# AvatarTheme

Theme configuration for [Avatar] and related avatar components.

## Usage

### Avatar Example
```dart
import 'package:docs/pages/docs/components/avatar/avatar_example_1.dart';
import 'package:docs/pages/docs/components/avatar/avatar_example_2.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'avatar/avatar_example_3.dart';

class AvatarExample extends StatelessWidget {
  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'avatar',
      description: 'Avatars are used to represent people or objects.',
      displayName: 'Avatar',
      children: [
        WidgetUsageExample(
          title: 'Avatar Example',
          path: 'lib/pages/docs/components/avatar/avatar_example_1.dart',
          child: AvatarExample1(),
        ),
        WidgetUsageExample(
          title: 'Avatar Example with Username Initials',
          path: 'lib/pages/docs/components/avatar/avatar_example_2.dart',
          child: AvatarExample2(),
        ),
        WidgetUsageExample(
          title: 'Avatar Example with Badge',
          path: 'lib/pages/docs/components/avatar/avatar_example_3.dart',
          child: AvatarExample3(),
        ),
      ],
    );
  }
}

```

### Avatar Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Avatar with image and initials fallback.
///
/// If the image fails to load, the [initials] will be shown over the
/// [backgroundColor]. This example uses a remote GitHub avatar URL.
class AvatarExample1 extends StatelessWidget {
  const AvatarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      backgroundColor: Colors.red,
      // Helper to derive initials from a username or full name.
      initials: Avatar.getInitials('sunarya-thito'),
      provider: const NetworkImage(
          'https://avatars.githubusercontent.com/u/64018564?v=4'),
    );
  }
}

```

### Avatar Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Simple Avatar with initials only.
///
/// Demonstrates customizing the avatar [size] while displaying
/// just the text initials (no image provider).
class AvatarExample2 extends StatelessWidget {
  const AvatarExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      // Use initials when you don't have an image.
      initials: Avatar.getInitials('sunarya-thito'),
      size: 64,
    );
  }
}

```

### Avatar Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Avatar with a status badge.
///
/// Shows how to attach an [AvatarBadge] to indicate presence/status
/// (e.g., online/offline) or any small highlight.
class AvatarExample3 extends StatelessWidget {
  const AvatarExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      initials: Avatar.getInitials('sunarya-thito'),
      size: 64,
      badge: const AvatarBadge(
        size: 20,
        color: Colors.green,
      ),
    );
  }
}

```

### Avatar Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AvatarTile extends StatelessWidget implements IComponentPage {
  const AvatarTile({super.key});

  @override
  String get title => 'Avatar';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'avatar',
      title: 'Avatar',
      scale: 1.5,
      example: Card(
        child: Row(
          children: [
            Avatar(
              initials: Avatar.getInitials('sunarya-thito'),
              provider: const NetworkImage(
                  'https://avatars.githubusercontent.com/u/64018564?v=4'),
            ),
            const Gap(16),
            Avatar(
              initials: Avatar.getInitials('sunarya-thito'),
            ),
          ],
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
| `size` | `double?` | Default size for avatar components in logical pixels.  Controls the width and height of avatar containers. If null, defaults to 40 logical pixels scaled by theme scaling factor. |
| `borderRadius` | `double?` | Border radius for avatar corners in logical pixels.  Creates rounded corners on avatar containers. If null, defaults to theme radius multiplied by avatar size for proportional rounding. |
| `backgroundColor` | `Color?` | Background color for avatar containers when displaying initials.  Used as the background color when no image is provided or when image loading fails. If null, uses the muted color from theme color scheme. |
| `badgeAlignment` | `AlignmentGeometry?` | Alignment of badge relative to the main avatar.  Controls where badges are positioned when attached to avatars. If null, badges are positioned at a calculated offset based on avatar size. |
| `badgeGap` | `double?` | Spacing between avatar and badge components.  Controls the gap between the main avatar and any attached badges. If null, defaults to 4 logical pixels scaled by theme scaling factor. |
| `textStyle` | `TextStyle?` | Text style for avatar initials display.  Applied to text when displaying user initials in avatar containers. If null, uses bold foreground color from theme. |
