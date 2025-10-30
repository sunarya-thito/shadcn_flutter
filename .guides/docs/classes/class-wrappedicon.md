---
title: "Class: WrappedIcon"
description: "A widget that wraps an icon with custom theme data."
---

```dart
/// A widget that wraps an icon with custom theme data.
///
/// Applies icon theme styling to a child icon widget using a builder
/// function that can access the current context and theme. Useful for
/// applying dynamic icon styles based on theme values.
///
/// Example:
/// ```dart
/// WrappedIcon(
///   data: (context, theme) => IconThemeData(
///     size: 24,
///     color: theme.colorScheme.primary,
///   ),
///   child: Icon(Icons.star),
/// )
/// ```
class WrappedIcon extends StatelessWidget {
  /// Builder function that creates the icon theme data.
  final WrappedIconDataBuilder<IconThemeData> data;
  /// The child icon widget to apply the theme to.
  final Widget child;
  /// Creates a [WrappedIcon].
  ///
  /// Parameters:
  /// - [data] (`WrappedIconDataBuilder<IconThemeData>`, required): Theme builder.
  /// - [child] (`Widget`, required): Icon widget to wrap.
  const WrappedIcon({super.key, required this.data, required this.child});
  /// Returns this widget (callable syntax support).
  ///
  /// Allows using the wrapped icon as a callable function.
  Widget call();
  Widget build(BuildContext context);
  /// Creates a copy of this wrapped icon with modified icon theme data.
  ///
  /// Parameters:
  /// - [data] (`WrappedIconDataBuilder<IconThemeData>?`, optional): New icon theme data builder.
  ///
  /// Returns: A new [WrappedIcon] with merged theme data.
  WrappedIcon copyWith({WrappedIconDataBuilder<IconThemeData>? data});
}
```
