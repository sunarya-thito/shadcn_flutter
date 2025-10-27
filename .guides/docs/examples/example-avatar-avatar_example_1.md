---
title: "Example: components/avatar/avatar_example_1.dart"
description: "Component example"
---

Source preview
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
