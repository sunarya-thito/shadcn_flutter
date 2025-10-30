---
title: "Class: ShadcnUI"
description: "A widget that provides text and icon styling for shadcn UI components."
---

```dart
/// A widget that provides text and icon styling for shadcn UI components.
///
/// Applies consistent text styles and icon themes to its descendants.
class ShadcnUI extends StatelessWidget {
  /// Optional text style override.
  final TextStyle? textStyle;
  /// The child widget.
  final Widget child;
  /// Creates a ShadcnUI widget.
  const ShadcnUI({super.key, this.textStyle, required this.child});
  Widget build(BuildContext context);
}
```
