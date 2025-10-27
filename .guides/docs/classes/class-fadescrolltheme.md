---
title: "Class: FadeScrollTheme"
description: "Theme configuration for [FadeScroll]."
---

```dart
/// Theme configuration for [FadeScroll].
class FadeScrollTheme {
  /// The distance from the start before fading begins.
  final double? startOffset;
  /// The distance from the end before fading begins.
  final double? endOffset;
  /// The gradient colors used for the fade.
  final List<Color>? gradient;
  /// Creates a [FadeScrollTheme].
  const FadeScrollTheme({this.startOffset, this.endOffset, this.gradient});
  /// Creates a copy of this theme but with the given fields replaced.
  FadeScrollTheme copyWith({ValueGetter<double?>? startOffset, ValueGetter<double?>? endOffset, ValueGetter<List<Color>?>? gradient});
  bool operator ==(Object other);
  int get hashCode;
}
```
