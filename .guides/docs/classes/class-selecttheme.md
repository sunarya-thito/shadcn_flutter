---
title: "Class: SelectTheme"
description: "Theme data for customizing [Select] widget appearance and behavior.   This class defines the visual and behavioral properties that can be applied to  [Select] widgets, including popup constraints, positioning, styling, and  interaction behaviors. These properties can be set at the theme level  to provide consistent behavior across the application."
---

```dart
/// Theme data for customizing [Select] widget appearance and behavior.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [Select] widgets, including popup constraints, positioning, styling, and
/// interaction behaviors. These properties can be set at the theme level
/// to provide consistent behavior across the application.
class SelectTheme extends ComponentThemeData {
  /// Constraints for the popup menu size.
  final BoxConstraints? popupConstraints;
  /// Overrides the [OverlayConfiguration] used to present the popup, when
  /// not overridden per-instance by [SelectBase.overlayConfiguration].
  final OverlayConfiguration? overlayConfiguration;
  /// Whether the popup may adapt to a different presentation on mobile
  /// platforms (see [showOverlay]'s `adaptive` parameter), when not
  /// overridden per-instance by [SelectBase.adaptiveOverlay].
  final bool? adaptiveOverlay;
  /// Border radius for select items.
  final BorderRadiusGeometry? borderRadius;
  /// Padding inside select items.
  final EdgeInsetsGeometry? padding;
  /// Overrides the decoration of the select trigger.
  ///
  /// Resolved per [WidgetState], so a single delegate covers the idle, hovered,
  /// focused and disabled appearance — border color, background color and
  /// anything else a [BoxDecoration] carries. It receives the decoration the
  /// trigger would otherwise use, so it can adjust rather than replace it:
  ///
  /// ```dart
  /// SelectTheme(
  ///   decoration: (context, states, value) {
  ///     final decoration = value as BoxDecoration;
  ///     return decoration.copyWith(
  ///       border: Border.all(
  ///         color: states.contains(WidgetState.focused)
  ///             ? Colors.blue
  ///             : Colors.gray,
  ///       ),
  ///     );
  ///   },
  /// )
  /// ```
  ///
  /// Applied after [borderRadius], so a delegate that rewrites the border
  /// radius wins over it.
  final WidgetStatePropertyDelegate<Decoration>? decoration;
  /// Whether to disable hover effects on items.
  final bool? disableHoverEffect;
  /// Whether the selected item can be unselected.
  final bool? canUnselect;
  /// Whether to automatically close the popover after selection.
  final bool? autoClosePopover;
  /// Creates a select theme.
  const SelectTheme({this.popupConstraints, this.overlayConfiguration, this.adaptiveOverlay, this.borderRadius, this.padding, this.decoration, this.disableHoverEffect, this.canUnselect, this.autoClosePopover});
  /// Creates a copy of this theme with the given fields replaced.
  SelectTheme copyWith({ValueGetter<BoxConstraints?>? popupConstraints, ValueGetter<OverlayConfiguration?>? overlayConfiguration, ValueGetter<bool?>? adaptiveOverlay, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<WidgetStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<bool?>? disableHoverEffect, ValueGetter<bool?>? canUnselect, ValueGetter<bool?>? autoClosePopover});
  bool operator ==(Object other);
  int get hashCode;
}
```
