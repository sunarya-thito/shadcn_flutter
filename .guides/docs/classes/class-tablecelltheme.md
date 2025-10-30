---
title: "Class: TableCellTheme"
description: "Theme configuration for individual table cells."
---

```dart
/// Theme configuration for individual table cells.
///
/// [TableCellTheme] provides state-aware styling options for table cells
/// using [WidgetStateProperty] to handle different interactive states like
/// hover, selected, disabled, etc. This enables rich visual feedback for
/// table interactions.
///
/// ## State-Aware Properties
/// All properties use [WidgetStateProperty] to support different visual
/// states:
/// - [WidgetState.hovered]: Mouse hover state
/// - [WidgetState.selected]: Cell/row selection state
/// - [WidgetState.disabled]: Disabled interaction state
/// - [WidgetState.pressed]: Active press state
///
/// Example:
/// ```dart
/// TableCellTheme(
///   backgroundColor: WidgetStateProperty.resolveWith((states) {
///     if (states.contains(WidgetState.hovered)) {
///       return Colors.blue.shade50;
///     }
///     return null;
///   }),
///   textStyle: WidgetStateProperty.all(
///     TextStyle(fontWeight: FontWeight.w500),
///   ),
/// );
/// ```
class TableCellTheme {
  /// State-aware border configuration for table cells.
  ///
  /// Type: `WidgetStateProperty<Border?>?`. Defines cell borders that can
  /// change based on interactive states. Useful for highlighting selected
  /// or hovered cells.
  final WidgetStateProperty<Border?>? border;
  /// State-aware background color for table cells.
  ///
  /// Type: `WidgetStateProperty<Color?>?`. Controls cell background colors
  /// that can change based on hover, selection, or other states.
  final WidgetStateProperty<Color?>? backgroundColor;
  /// State-aware text styling for table cell content.
  ///
  /// Type: `WidgetStateProperty<TextStyle?>?`. Controls text appearance
  /// including color, weight, size that can change based on cell states.
  final WidgetStateProperty<TextStyle?>? textStyle;
  /// Creates a [TableCellTheme].
  ///
  /// All parameters are optional and use [WidgetStateProperty] for
  /// state-aware styling.
  ///
  /// Parameters:
  /// - [border] (`WidgetStateProperty<Border?>?`, optional): State-aware borders
  /// - [backgroundColor] (`WidgetStateProperty<Color?>?`, optional): State-aware background
  /// - [textStyle] (`WidgetStateProperty<TextStyle?>?`, optional): State-aware text styling
  ///
  /// Example:
  /// ```dart
  /// TableCellTheme(
  ///   border: WidgetStateProperty.all(
  ///     Border.all(color: Colors.grey.shade300),
  ///   ),
  ///   backgroundColor: WidgetStateProperty.resolveWith((states) {
  ///     return states.contains(WidgetState.selected) ? Colors.blue.shade100 : null;
  ///   }),
  /// );
  /// ```
  const TableCellTheme({this.border, this.backgroundColor, this.textStyle});
  bool operator ==(Object other);
  int get hashCode;
  /// Creates a copy of this cell theme with the given values replaced.
  ///
  /// Returns a new [TableCellTheme] instance with the same state properties
  /// as this theme, except for any parameters that are explicitly provided.
  /// Use [ValueGetter] functions to specify new state properties.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   backgroundColor: () => WidgetStateProperty.all(Colors.yellow.shade50),
  ///   textStyle: () => WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
  /// );
  /// ```
  TableCellTheme copyWith({ValueGetter<WidgetStateProperty<Border>?>? border, ValueGetter<WidgetStateProperty<Color>?>? backgroundColor, ValueGetter<WidgetStateProperty<TextStyle>?>? textStyle});
}
```
