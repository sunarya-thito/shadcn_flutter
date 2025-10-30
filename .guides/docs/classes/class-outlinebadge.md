---
title: "Class: OutlineBadge"
description: "An outline-styled badge for displaying labels, counts, or status indicators."
---

```dart
/// An outline-styled badge for displaying labels, counts, or status indicators.
///
/// Uses outline styling with a visible border and no background fill,
/// suitable for less visually prominent badge elements.
class OutlineBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;
  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;
  /// Optional widget displayed before the child content.
  final Widget? leading;
  /// Optional widget displayed after the child content.
  final Widget? trailing;
  /// Optional custom style override for the badge.
  final AbstractButtonStyle? style;
  /// Creates an outline badge with the specified child content.
  const OutlineBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});
  Widget build(BuildContext context);
}
```
