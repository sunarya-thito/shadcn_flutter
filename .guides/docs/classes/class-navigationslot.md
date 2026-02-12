---
title: "Class: NavigationSlot"
description: "A navigation header/footer item with configurable content.   Designed for navigation header and footer sections. The layout adapts to  the navigation expansion state and keeps a compact density when collapsed."
---

```dart
/// A navigation header/footer item with configurable content.
///
/// Designed for navigation header and footer sections. The layout adapts to
/// the navigation expansion state and keeps a compact density when collapsed.
class NavigationSlot extends StatelessWidget {
  /// Leading widget (usually an icon or avatar).
  final Widget leading;
  /// Primary title widget.
  final Widget title;
  /// Optional subtitle widget shown under the title.
  final Widget? subtitle;
  /// Optional trailing widget (often a chevron or action icon).
  final Widget? trailing;
  /// Gap multiplier between the text block and trailing widget.
  final double? trailingGap;
  /// Callback for press interactions.
  final VoidCallback? onPressed;
  /// Alignment for the button content.
  final AlignmentGeometry? alignment;
  /// Creates a [NavigationSlot].
  const NavigationSlot({super.key, required this.leading, required this.title, this.subtitle, this.trailing, this.trailingGap, this.onPressed, this.alignment});
  Widget build(BuildContext context);
}
```
