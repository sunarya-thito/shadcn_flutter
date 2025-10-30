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
  /// Constraints for the popup menu size.
  final BoxConstraints? popupConstraints;
  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Border radius for select items.
  final BorderRadiusGeometry? borderRadius;
  /// Padding inside select items.
  final EdgeInsetsGeometry? padding;
  /// Whether to disable hover effects on items.
  final bool? disableHoverEffect;
  /// Whether the selected item can be unselected.
  final bool? canUnselect;
  /// Whether to automatically close the popover after selection.
  final bool? autoClosePopover;
  /// Creates a select theme.
  const SelectTheme({this.popupConstraints, this.popoverAlignment, this.popoverAnchorAlignment, this.borderRadius, this.padding, this.disableHoverEffect, this.canUnselect, this.autoClosePopover});
  /// Creates a copy of this theme with the given fields replaced.
  SelectTheme copyWith({ValueGetter<BoxConstraints?>? popupConstraints, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<bool?>? disableHoverEffect, ValueGetter<bool?>? canUnselect, ValueGetter<bool?>? autoClosePopover});
  bool operator ==(Object other);
  int get hashCode;
}
```
