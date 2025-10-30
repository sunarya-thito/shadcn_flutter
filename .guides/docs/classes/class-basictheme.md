---
title: "Class: BasicTheme"
description: "Theme configuration for [Basic] layout widgets."
---

```dart
/// Theme configuration for [Basic] layout widgets.
///
/// Defines default alignment, spacing, and padding properties for Basic
/// layout components. These properties control how leading, trailing, title,
/// subtitle, and content elements are positioned and spaced.
class BasicTheme {
  /// Alignment for the leading widget.
  final AlignmentGeometry? leadingAlignment;
  /// Alignment for the trailing widget.
  final AlignmentGeometry? trailingAlignment;
  /// Alignment for the title widget.
  final AlignmentGeometry? titleAlignment;
  /// Alignment for the subtitle widget.
  final AlignmentGeometry? subtitleAlignment;
  /// Alignment for the content widget.
  final AlignmentGeometry? contentAlignment;
  /// Spacing between content elements.
  final double? contentSpacing;
  /// Spacing between title and subtitle.
  final double? titleSpacing;
  /// Main axis alignment for the overall layout.
  final MainAxisAlignment? mainAxisAlignment;
  /// Padding around the entire Basic widget.
  final EdgeInsetsGeometry? padding;
  /// Creates a [BasicTheme].
  const BasicTheme({this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.mainAxisAlignment, this.padding});
  /// Creates a copy of this theme with the given fields replaced.
  BasicTheme copyWith({ValueGetter<AlignmentGeometry?>? leadingAlignment, ValueGetter<AlignmentGeometry?>? trailingAlignment, ValueGetter<AlignmentGeometry?>? titleAlignment, ValueGetter<AlignmentGeometry?>? subtitleAlignment, ValueGetter<AlignmentGeometry?>? contentAlignment, ValueGetter<double?>? contentSpacing, ValueGetter<double?>? titleSpacing, ValueGetter<MainAxisAlignment?>? mainAxisAlignment, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
