---
title: "Class: ResizableTableTheme"
description: "Theme configuration for resizable tables."
---

```dart
/// Theme configuration for resizable tables.
///
/// Provides styling options for resizable table components including
/// the base table theme, resizer appearance, and interaction behavior.
///
/// Example:
/// ```dart
/// ResizableTableTheme(
///   tableTheme: TableTheme(...),
///   resizerThickness: 2.0,
///   resizerColor: Colors.blue,
/// )
/// ```
class ResizableTableTheme {
  /// Base theme configuration for the table.
  final TableTheme? tableTheme;
  /// Thickness of the resize handle in pixels.
  final double? resizerThickness;
  /// Color of the resize handle.
  final Color? resizerColor;
  /// Creates a [ResizableTableTheme].
  const ResizableTableTheme({this.tableTheme, this.resizerThickness, this.resizerColor});
  bool operator ==(Object other);
  int get hashCode;
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [tableTheme] (`ValueGetter<TableTheme?>?`, optional): New table theme.
  /// - [resizerThickness] (`ValueGetter<double?>?`, optional): New resizer thickness.
  /// - [resizerColor] (`ValueGetter<Color?>?`, optional): New resizer color.
  ///
  /// Returns: A new [ResizableTableTheme] with updated properties.
  ResizableTableTheme copyWith({ValueGetter<TableTheme?>? tableTheme, ValueGetter<double?>? resizerThickness, ValueGetter<Color?>? resizerColor});
}
```
