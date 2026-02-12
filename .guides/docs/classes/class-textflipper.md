---
title: "Class: TextFlipper"
description: "Animates a string by flipping each character."
---

```dart
/// Animates a string by flipping each character.
class TextFlipper extends StatelessWidget {
  /// The character set used for each character flip.
  final FlipperCharset charset;
  /// The text to animate.
  final String text;
  /// Duration of the flip animation for each character.
  final Duration duration;
  /// Curve used for the flip animation.
  final Curve curve;
  /// Creates a [TextFlipper].
  const TextFlipper({super.key, this.charset = FlipperCharset.all, required this.text, this.duration = const Duration(milliseconds: 500), this.curve = Curves.easeInOut});
  Widget build(BuildContext context);
}
```
