---
title: "Class: ScaffoldTheme"
description: "Theme data for customizing [Scaffold] widget appearance."
---

```dart
/// Theme data for customizing [Scaffold] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Scaffold] widgets, including background colors for different sections,
/// loading spark behavior, and keyboard avoidance settings. These properties
/// can be set at the theme level to provide consistent styling across the application.
class ScaffoldTheme {
  /// Background color of the scaffold body.
  final Color? backgroundColor;
  /// Background color of the header section.
  final Color? headerBackgroundColor;
  /// Background color of the footer section.
  final Color? footerBackgroundColor;
  /// Whether to show loading sparks by default.
  final bool? showLoadingSparks;
  /// Whether the scaffold should resize for the onscreen keyboard.
  final bool? resizeToAvoidBottomInset;
  /// Creates a [ScaffoldTheme].
  const ScaffoldTheme({this.backgroundColor, this.headerBackgroundColor, this.footerBackgroundColor, this.showLoadingSparks, this.resizeToAvoidBottomInset});
  /// Creates a copy of this theme with the given fields replaced.
  ScaffoldTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? headerBackgroundColor, ValueGetter<Color?>? footerBackgroundColor, ValueGetter<bool?>? showLoadingSparks, ValueGetter<bool?>? resizeToAvoidBottomInset});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
