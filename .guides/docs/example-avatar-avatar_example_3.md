---
title: "Example: components/avatar/avatar_example_3.dart"
description: "Component example"
---

Source preview
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
