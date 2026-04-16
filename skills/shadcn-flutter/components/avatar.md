# Avatar

A circular or rounded rectangular widget for displaying user profile images or initials.

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
- **Flexible Content**: Supports both images and text initials
- **Automatic Fallback**: Falls back to initials when images fail to load
- **Badge Support**: Optional badge overlay for status or notification indicators
- **Network Images**: Built-in support for network images with caching
- **Theming**: Comprehensive theming via [AvatarTheme]
- **Group Integration**: Works with [AvatarGroup] for overlapping layouts

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `initials` | `String` | User initials or text to display in the avatar.  Primary fallback content when no image is provided via [provider] or when image loading fails. Should typically contain user's initials or a short representative text. |
| `backgroundColor` | `Color?` | Background color for the avatar when displaying initials.  Type: `Color?`. Used as the container background color when showing [initials]. If null, defaults to the theme's muted color. |
| `size` | `double?` | Size of the avatar in logical pixels.  Type: `double?`. Controls both width and height of the avatar container. If null, defaults to theme.scaling * 40 pixels. |
| `borderRadius` | `double?` | Border radius for avatar corners in logical pixels.  Type: `double?`. Creates rounded corners on the avatar container. If null, defaults to theme.radius * size for proportional rounding. |
| `badge` | `AvatarWidget?` | Optional badge widget to overlay on the avatar.  Type: `AvatarWidget?`. Typically an [AvatarBadge] for status indicators. Positioned according to [badgeAlignment] with [badgeGap] spacing. |
| `badgeAlignment` | `AlignmentGeometry?` | Position of the badge relative to the avatar.  Type: `AlignmentGeometry?`. Controls where the [badge] is positioned. If null, uses a calculated offset based on avatar and badge sizes. |
| `badgeGap` | `double?` | Spacing between the avatar and badge in logical pixels.  Type: `double?`. Controls the gap between the avatar edge and badge edge. If null, defaults to theme.scaling * 4 pixels. |
| `provider` | `ImageProvider?` | Image provider for displaying user photos.  Type: `ImageProvider?`. Can be any Flutter image provider (NetworkImage, AssetImage, etc.). If null or loading fails, shows [initials] instead. |
