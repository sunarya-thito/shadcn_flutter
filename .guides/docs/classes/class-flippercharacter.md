---
title: "Class: FlipperCharacter"
description: "Animates a single character by flipping through [FlipperCharset]."
---

```dart
/// Animates a single character by flipping through [FlipperCharset].
class FlipperCharacter extends StatelessWidget {
  /// The character set used for flipping.
  final FlipperCharset charset;
  /// The target character to display.
  final String character;
  /// Duration of the flip animation.
  final Duration duration;
  /// Curve used for the flip animation.
  final Curve curve;
  /// Creates a [FlipperCharacter].
  const FlipperCharacter({super.key, required this.charset, required this.character, required this.duration, required this.curve});
  Widget build(BuildContext context);
}
```
