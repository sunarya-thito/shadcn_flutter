---
title: "Class: FadedScrollableViewport"
description: "Applies a fade mask at the scroll edges of [child].   Useful for indicating overflow in scrollables without showing scrollbars."
---

```dart
/// Applies a fade mask at the scroll edges of [child].
///
/// Useful for indicating overflow in scrollables without showing scrollbars.
class FadedScrollableViewport extends StatefulWidget {
  /// The scrollable content to fade.
  final Widget child;
  /// Distance over which the fade ramps in or out.
  final double fadeExtent;
  /// Size of the fade gradient along the scroll axis.
  final double fadeSize;
  /// Creates a [FadedScrollableViewport].
  const FadedScrollableViewport({super.key, this.fadeExtent = 20.0, this.fadeSize = 50.0, required this.child});
  State<FadedScrollableViewport> createState();
}
```
