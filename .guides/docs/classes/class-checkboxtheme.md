---
title: "Class: CheckboxTheme"
description: "Theme configuration for [Checkbox] widget styling and visual appearance."
---

```dart
/// Theme configuration for [Checkbox] widget styling and visual appearance.
///
/// Defines the visual properties used by checkbox components including colors,
/// dimensions, spacing, and border styling. All properties are optional and
/// fall back to framework defaults when not specified.
///
/// Can be applied globally through [ComponentTheme] or used to override
/// specific checkbox instances with custom styling.
class CheckboxTheme {
  /// Color of the checkbox background when in unchecked state.
  ///
  /// Applied as the background color when the checkbox is unchecked.
  /// When null, uses a semi-transparent version of the theme's input background color.
  final Color? backgroundColor;
  /// Color of the checkbox background when in checked state.
  ///
  /// Applied as both background and border color when the checkbox is checked.
  /// When null, uses the theme's primary color.
  final Color? activeColor;
  /// Color of the checkbox border when in unchecked state.
  ///
  /// Only visible when the checkbox is unchecked or in indeterminate state.
  /// When null, uses the theme's border color.
  final Color? borderColor;
  /// Size of the checkbox square in logical pixels.
  ///
  /// Controls both width and height of the checkbox square. The checkmark
  /// and indeterminate indicator are scaled proportionally. When null,
  /// defaults to 16 logical pixels scaled by theme scaling factor.
  final double? size;
  /// Spacing between the checkbox and its leading/trailing widgets.
  ///
  /// Applied on both sides of the checkbox square when leading or trailing
  /// widgets are provided. When null, defaults to 8 logical pixels scaled
  /// by theme scaling factor.
  final double? gap;
  /// Border radius applied to the checkbox square corners.
  ///
  /// Creates rounded corners on the checkbox container. When null, uses
  /// the theme's small border radius (typically 4 logical pixels).
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [CheckboxTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  /// The theme can be applied to individual checkboxes or globally through
  /// the component theme system.
  const CheckboxTheme({this.backgroundColor, this.activeColor, this.borderColor, this.size, this.gap, this.borderRadius});
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = theme.copyWith(
  ///   activeColor: () => Colors.green,
  ///   size: () => 20.0,
  /// );
  /// ```
  CheckboxTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? activeColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? size, ValueGetter<double?>? gap, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
