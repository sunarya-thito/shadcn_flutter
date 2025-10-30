---
title: "Class: SwiperTheme"
description: "Theme configuration for swiper overlay behavior and appearance."
---

```dart
/// Theme configuration for swiper overlay behavior and appearance.
///
/// Defines default properties for swiper components including overlay
/// behavior, drag interaction, surface effects, and visual styling.
///
/// Features:
/// - Configurable drag and expansion behavior
/// - Surface effects and backdrop styling
/// - Barrier and interaction customization
/// - Consistent theming across swiper variants
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     SwiperTheme: SwiperTheme(
///       expands: true,
///       draggable: true,
///       barrierDismissible: true,
///       transformBackdrop: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class SwiperTheme {
  /// Whether the swiper should expand to fill available space.
  final bool? expands;
  /// Whether the swiper can be dragged to dismiss.
  final bool? draggable;
  /// Whether tapping the barrier dismisses the swiper.
  final bool? barrierDismissible;
  /// Builder for custom backdrop content.
  final WidgetBuilder? backdropBuilder;
  /// Whether to respect device safe areas.
  final bool? useSafeArea;
  /// Whether to show the drag handle.
  final bool? showDragHandle;
  /// Border radius for the swiper container.
  final BorderRadiusGeometry? borderRadius;
  /// Size of the drag handle when displayed.
  final Size? dragHandleSize;
  /// Whether to transform the backdrop when shown.
  final bool? transformBackdrop;
  /// Opacity for surface effects.
  final double? surfaceOpacity;
  /// Blur intensity for surface effects.
  final double? surfaceBlur;
  /// Color of the modal barrier.
  final Color? barrierColor;
  /// Hit test behavior for gesture detection.
  final HitTestBehavior? behavior;
  /// Creates a [SwiperTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Example:
  /// ```dart
  /// const SwiperTheme(
  ///   expands: true,
  ///   draggable: true,
  ///   transformBackdrop: true,
  /// )
  /// ```
  const SwiperTheme({this.expands, this.draggable, this.barrierDismissible, this.backdropBuilder, this.useSafeArea, this.showDragHandle, this.borderRadius, this.dragHandleSize, this.transformBackdrop, this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.behavior});
  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// All parameters are wrapped in [ValueGetter] to allow lazy evaluation
  /// and dynamic theme changes.
  SwiperTheme copyWith({ValueGetter<bool?>? expands, ValueGetter<bool?>? draggable, ValueGetter<bool?>? barrierDismissible, ValueGetter<WidgetBuilder?>? backdropBuilder, ValueGetter<bool?>? useSafeArea, ValueGetter<bool?>? showDragHandle, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<Size?>? dragHandleSize, ValueGetter<bool?>? transformBackdrop, ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<Color?>? barrierColor, ValueGetter<HitTestBehavior?>? behavior});
  int get hashCode;
  bool operator ==(Object other);
  String toString();
}
```
