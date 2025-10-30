---
title: "Class: CodeSnippetTheme"
description: "Theme configuration for [CodeSnippet] components."
---

```dart
/// Theme configuration for [CodeSnippet] components.
///
/// [CodeSnippetTheme] provides styling options for code snippet containers
/// including background colors, borders, padding, and visual appearance.
/// It integrates with the shadcn_flutter theming system to ensure consistent
/// styling across code display components.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<CodeSnippetTheme>(
///   data: CodeSnippetTheme(
///     backgroundColor: Colors.grey.shade900,
///     borderColor: Colors.grey.shade700,
///     borderWidth: 1.0,
///     borderRadius: BorderRadius.circular(8.0),
///     padding: EdgeInsets.all(16.0),
///   ),
///   child: MyCodeSnippetWidget(),
/// );
/// ```
class CodeSnippetTheme {
  /// Background color of the code snippet container.
  ///
  /// Type: `Color?`. Used as the background color for the code display area.
  /// If null, uses the theme's default muted background color.
  final Color? backgroundColor;
  /// Border color of the code snippet container.
  ///
  /// Type: `Color?`. Color used for the container border outline.
  /// If null, uses the theme's default border color.
  final Color? borderColor;
  /// Border width of the code snippet container in logical pixels.
  ///
  /// Type: `double?`. Thickness of the border around the code container.
  /// If null, uses the theme's default border width.
  final double? borderWidth;
  /// Border radius for the code snippet container corners.
  ///
  /// Type: `BorderRadiusGeometry?`. Controls corner rounding of the container.
  /// If null, uses the theme's default radius for code components.
  final BorderRadiusGeometry? borderRadius;
  /// Padding for the code content area.
  ///
  /// Type: `EdgeInsetsGeometry?`. Internal spacing around the code text.
  /// If null, uses default padding appropriate for code display.
  final EdgeInsetsGeometry? padding;
  /// Creates a [CodeSnippetTheme].
  ///
  /// All parameters are optional and will fall back to theme defaults
  /// when not provided.
  ///
  /// Parameters:
  /// - [backgroundColor] (Color?, optional): Container background color
  /// - [borderColor] (Color?, optional): Border outline color
  /// - [borderWidth] (double?, optional): Border thickness in pixels
  /// - [borderRadius] (BorderRadiusGeometry?, optional): Corner radius
  /// - [padding] (EdgeInsetsGeometry?, optional): Content padding
  ///
  /// Example:
  /// ```dart
  /// CodeSnippetTheme(
  ///   backgroundColor: Colors.black87,
  ///   borderRadius: BorderRadius.circular(12.0),
  ///   padding: EdgeInsets.all(20.0),
  /// );
  /// ```
  const CodeSnippetTheme({this.backgroundColor, this.borderColor, this.borderWidth, this.borderRadius, this.padding});
  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Returns a new [CodeSnippetTheme] instance with the same values as this
  /// theme, except for any parameters that are explicitly provided. Use
  /// [ValueGetter] functions to specify new values.
  ///
  /// Parameters are [ValueGetter] functions that return the new value when called.
  /// This allows for conditional value setting and proper null handling.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   backgroundColor: () => Colors.blue.shade50,
  ///   padding: () => EdgeInsets.all(12.0),
  /// );
  /// ```
  CodeSnippetTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
