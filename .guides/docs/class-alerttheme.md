---
title: "Class: AlertTheme"
description: "Theme configuration for [Alert] components."
---

```dart
/// Theme configuration for [Alert] components.
///
/// Provides visual styling properties for alert components including padding,
/// background color, and border color. These properties can be overridden at
/// the widget level or applied globally via [ComponentTheme].
///
/// The theme integrates with the overall design system by using appropriate
/// color schemes and scaling factors from [ThemeData].
class AlertTheme {
  /// The internal padding around the alert content.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses default padding based on scaling.
  /// Controls the spacing between the alert border and its content elements.
  final EdgeInsetsGeometry? padding;
  /// The background color of the alert container.
  ///
  /// Type: `Color?`. If null, uses [ColorScheme.card] from the current theme.
  /// Applied to the [OutlinedContainer] that wraps the alert content.
  final Color? backgroundColor;
  /// The border color of the alert outline.
  ///
  /// Type: `Color?`. If null, uses the default border color from [OutlinedContainer].
  /// Defines the visual boundary around the alert.
  final Color? borderColor;
  /// Creates an [AlertTheme].
  ///
  /// All parameters are optional and can be null to use default values.
  ///
  /// Example:
  /// ```dart
  /// const AlertTheme(
  ///   padding: EdgeInsets.all(16.0),
  ///   backgroundColor: Colors.blue,
  ///   borderColor: Colors.blueAccent,
  /// );
  /// ```
  const AlertTheme({this.padding, this.backgroundColor, this.borderColor});
  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional replacement of values.
  /// If a getter function is null, the original value is preserved.
  ///
  /// Returns:
  /// A new [AlertTheme] instance with updated values.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = theme.copyWith(
  ///   backgroundColor: () => Colors.red,
  /// );
  /// ```
  AlertTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
