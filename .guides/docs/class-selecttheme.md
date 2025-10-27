---
title: "Class: SelectTheme"
description: "Theme data for customizing [Select] widget appearance and behavior."
---

```dart
/// Theme data for customizing [Select] widget appearance and behavior.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [Select] widgets, including popup constraints, positioning, styling, and
/// interaction behaviors. These properties can be set at the theme level
/// to provide consistent behavior across the application.
class SelectTheme {
  final BoxConstraints? popupConstraints;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool? disableHoverEffect;
  final bool? canUnselect;
  final bool? autoClosePopover;
  const SelectTheme({this.popupConstraints, this.popoverAlignment, this.popoverAnchorAlignment, this.borderRadius, this.padding, this.disableHoverEffect, this.canUnselect, this.autoClosePopover});
  SelectTheme copyWith({ValueGetter<BoxConstraints?>? popupConstraints, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<bool?>? disableHoverEffect, ValueGetter<bool?>? canUnselect, ValueGetter<bool?>? autoClosePopover});
  bool operator ==(Object other);
  int get hashCode;
}
```
