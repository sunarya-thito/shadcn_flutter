---
title: "Class: FadeScroll"
description: "A widget that applies fade effects at the edges of scrollable content."
---

```dart
/// A widget that applies fade effects at the edges of scrollable content.
///
/// Adds gradient fade overlays to the start and end of scrollable content,
/// creating a visual cue that there's more content to scroll.
class FadeScroll extends StatelessWidget {
  /// The offset from the start where the fade begins.
  final double? startOffset;
  /// The offset from the end where the fade begins.
  final double? endOffset;
  /// The cross-axis offset for the start fade.
  final double startCrossOffset;
  /// The cross-axis offset for the end fade.
  final double endCrossOffset;
  /// The scrollable child widget.
  final Widget child;
  /// The scroll controller to monitor for scroll position.
  final ScrollController controller;
  /// The gradient colors for the fade effect.
  final List<Color>? gradient;
  /// Creates a fade scroll widget.
  const FadeScroll({super.key, this.startOffset, this.endOffset, required this.child, required this.controller, this.gradient, this.startCrossOffset = 0, this.endCrossOffset = 0});
  Widget build(BuildContext context);
}
```
