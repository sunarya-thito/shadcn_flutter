---
title: "Class: OverlayAnchorScope"
description: "Provides a local [OverlayAnchorRegistry] to its subtree, so [OverlayAnchor]  keys only need to be unique within this scope rather than globally.   Place a scope around each repeated region (list item, tab, dialog, route)  that reuses the same anchor keys. Both the [OverlayAnchor] and the code that  opens a [LinkedAnchor]-based overlay must sit under the same scope for them  to connect."
---

```dart
/// Provides a local [OverlayAnchorRegistry] to its subtree, so [OverlayAnchor]
/// keys only need to be unique within this scope rather than globally.
///
/// Place a scope around each repeated region (list item, tab, dialog, route)
/// that reuses the same anchor keys. Both the [OverlayAnchor] and the code that
/// opens a [LinkedAnchor]-based overlay must sit under the same scope for them
/// to connect.
class OverlayAnchorScope extends StatefulWidget {
  /// The subtree that shares this scope's registry.
  final Widget child;
  /// Creates an [OverlayAnchorScope].
  const OverlayAnchorScope({super.key, required this.child});
  State<OverlayAnchorScope> createState();
}
```
