---
title: "Class: Theme"
description: "An inherited widget that provides theme data to its descendants."
---

```dart
/// An inherited widget that provides theme data to its descendants.
class Theme extends InheritedTheme {
  /// The theme data to provide to descendants.
  final ThemeData data;
  /// Creates a [Theme].
  ///
  /// Parameters:
  /// - [data] (`ThemeData`, required): Theme data to provide.
  /// - [child] (`Widget`, required): Child widget.
  const Theme({super.key, required this.data, required super.child});
  /// Gets the [ThemeData] from the closest [Theme] ancestor.
  ///
  /// Throws if no [Theme] is found in the widget tree.
  ///
  /// Returns: `ThemeData` — the theme data.
  static ThemeData of(BuildContext context);
  bool updateShouldNotify(covariant Theme oldWidget);
  Widget wrap(BuildContext context, Widget child);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
