---
title: "Class: ModalBackdropTheme"
description: "Theme configuration for modal backdrop appearance and behavior."
---

```dart
/// Theme configuration for modal backdrop appearance and behavior.
///
/// Defines the visual and behavioral properties of the backdrop that appears
/// behind modal dialogs, including border radius, padding, barrier color,
/// and modal interaction settings.
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     ModalBackdropTheme: ModalBackdropTheme(
///       barrierColor: Colors.black54,
///       borderRadius: BorderRadius.circular(12),
///       modal: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class ModalBackdropTheme {
  /// Border radius applied to the modal surface.
  final BorderRadiusGeometry? borderRadius;
  /// Padding around the modal content area.
  final EdgeInsetsGeometry? padding;
  /// Color of the barrier that appears behind the modal.
  final Color? barrierColor;
  /// Whether the backdrop behaves as a modal (blocking interaction).
  final bool? modal;
  /// Whether to clip the surface for visual effects.
  final bool? surfaceClip;
  /// Creates a [ModalBackdropTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Parameters:
  /// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius for the modal surface
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around modal content
  /// - [barrierColor] (Color?, optional): backdrop color, typically semi-transparent
  /// - [modal] (bool?, optional): whether backdrop blocks user interaction
  /// - [surfaceClip] (bool?, optional): whether to clip surface for visual effects
  ///
  /// Example:
  /// ```dart
  /// const ModalBackdropTheme(
  ///   borderRadius: BorderRadius.circular(8),
  ///   barrierColor: Color.fromRGBO(0, 0, 0, 0.5),
  ///   modal: true,
  /// )
  /// ```
  const ModalBackdropTheme({this.borderRadius, this.padding, this.barrierColor, this.modal, this.surfaceClip});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Uses [ValueGetter] functions to allow null value assignments.
  /// Any parameter set to null will use the current value.
  ///
  /// Returns:
  /// A new [ModalBackdropTheme] with updated values.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = theme.copyWith(
  ///   barrierColor: () => Colors.red.withOpacity(0.3),
  ///   modal: () => false,
  /// );
  /// ```
  ModalBackdropTheme copyWith({ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? barrierColor, ValueGetter<bool?>? modal, ValueGetter<bool?>? surfaceClip});
  bool operator ==(Object other);
  int get hashCode;
}
```
