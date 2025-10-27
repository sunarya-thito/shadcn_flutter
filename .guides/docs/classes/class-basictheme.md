---
title: "Class: BasicTheme"
description: "Reference for BasicTheme"
---

```dart
class BasicTheme {
  final AlignmentGeometry? leadingAlignment;
  final AlignmentGeometry? trailingAlignment;
  final AlignmentGeometry? titleAlignment;
  final AlignmentGeometry? subtitleAlignment;
  final AlignmentGeometry? contentAlignment;
  final double? contentSpacing;
  final double? titleSpacing;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  const BasicTheme({this.leadingAlignment, this.trailingAlignment, this.titleAlignment, this.subtitleAlignment, this.contentAlignment, this.contentSpacing, this.titleSpacing, this.mainAxisAlignment, this.padding});
  BasicTheme copyWith({ValueGetter<AlignmentGeometry?>? leadingAlignment, ValueGetter<AlignmentGeometry?>? trailingAlignment, ValueGetter<AlignmentGeometry?>? titleAlignment, ValueGetter<AlignmentGeometry?>? subtitleAlignment, ValueGetter<AlignmentGeometry?>? contentAlignment, ValueGetter<double?>? contentSpacing, ValueGetter<double?>? titleSpacing, ValueGetter<MainAxisAlignment?>? mainAxisAlignment, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
