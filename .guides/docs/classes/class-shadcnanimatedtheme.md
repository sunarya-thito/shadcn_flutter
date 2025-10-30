---
title: "Class: ShadcnAnimatedTheme"
description: "An animated theme widget for shadcn_flutter."
---

```dart
/// An animated theme widget for shadcn_flutter.
///
/// Animates theme changes over time with smooth transitions.
class ShadcnAnimatedTheme extends StatelessWidget {
  /// The child widget to apply the theme to.
  final Widget child;
  /// The theme data to animate to.
  final ThemeData data;
  /// The duration of the animation.
  final Duration duration;
  /// The curve for the animation.
  final Curve curve;
  /// Called when the animation completes.
  final VoidCallback? onEnd;
  /// Creates an animated theme widget.
  const ShadcnAnimatedTheme({super.key, required this.data, required this.duration, this.curve = Curves.linear, this.onEnd, required this.child});
  Widget build(BuildContext context);
}
```
