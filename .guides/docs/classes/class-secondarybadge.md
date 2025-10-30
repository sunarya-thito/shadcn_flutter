---
title: "Class: SecondaryBadge"
description: "A secondary-styled badge for displaying labels, counts, or status indicators."
---

```dart
/// A secondary-styled badge for displaying labels, counts, or status indicators.
///
/// Similar to [PrimaryBadge] but with secondary (muted) styling suitable for
/// less prominent information.
class SecondaryBadge extends StatelessWidget {
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
  /// Creates a secondary badge with the specified child content.
  const SecondaryBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});
  Widget build(BuildContext context);
}
```
