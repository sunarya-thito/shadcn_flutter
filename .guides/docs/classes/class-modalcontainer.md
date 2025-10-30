---
title: "Class: ModalContainer"
description: "A container widget that provides consistent styling for modal content."
---

```dart
/// A container widget that provides consistent styling for modal content.
///
/// Wraps modal content in a [SurfaceCard] with appropriate styling that
/// adapts to full-screen mode. Handles surface effects, borders, shadows,
/// and clipping behavior automatically based on the modal context.
///
/// Features:
/// - Automatic full-screen mode detection
/// - Surface styling with blur and opacity effects  
/// - Configurable borders and shadows
/// - Clip behavior control
/// - Theme integration
///
/// Example:
/// ```dart
/// ModalContainer(
///   padding: EdgeInsets.all(16),
///   borderRadius: BorderRadius.circular(12),
///   filled: true,
///   child: Column(
///     children: [
///       Text('Dialog Title'),
///       Text('Dialog content here'),
///     ],
///   ),
/// )
/// ```
class ModalContainer extends StatelessWidget {
  /// Model key used to identify full-screen modal mode.
  static const kFullScreenMode = #modal_surface_card_fullscreen;
  /// Checks if the current context is in full-screen modal mode.
  ///
  /// Returns `true` if the modal should display in full-screen mode,
  /// which affects styling such as border radius and shadows.
  static bool isFullScreenMode(BuildContext context);
  /// The child widget to display inside the modal container.
  final Widget child;
  /// Padding applied inside the container around the child.
  final EdgeInsetsGeometry? padding;
  /// Whether the container should have a filled background.
  final bool filled;
  /// Background fill color when [filled] is true.
  final Color? fillColor;
  /// Border radius for the container corners.
  final BorderRadiusGeometry? borderRadius;
  /// Color of the container border.
  final Color? borderColor;
  /// Width of the container border in logical pixels.
  final double? borderWidth;
  /// Clipping behavior for the container content.
  final Clip clipBehavior;
  /// Drop shadow effects applied to the container.
  final List<BoxShadow>? boxShadow;
  /// Surface opacity for backdrop effects.
  final double? surfaceOpacity;
  /// Surface blur intensity for backdrop effects.
  final double? surfaceBlur;
  /// Animation duration for surface transitions.
  final Duration? duration;
  /// Creates a [ModalContainer].
  ///
  /// The [child] parameter is required. Other parameters customize the
  /// container's appearance and behavior.
  ///
  /// Parameters:
  /// - [child] (Widget, required): content to display in the container
  /// - [padding] (EdgeInsetsGeometry?, optional): inner padding around child
  /// - [filled] (bool, default: false): whether to show background fill
  /// - [fillColor] (Color?, optional): background fill color when filled is true
  /// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius
  /// - [clipBehavior] (Clip, default: Clip.none): clipping behavior for content
  /// - [borderColor] (Color?, optional): border color
  /// - [borderWidth] (double?, optional): border width in logical pixels
  /// - [boxShadow] (`List<BoxShadow>?`, optional): drop shadow effects
  /// - [surfaceOpacity] (double?, optional): backdrop opacity level
  /// - [surfaceBlur] (double?, optional): backdrop blur intensity
  /// - [duration] (Duration?, optional): animation duration for transitions
  ///
  /// Example:
  /// ```dart
  /// ModalContainer(
  ///   filled: true,
  ///   padding: EdgeInsets.all(24),
  ///   borderRadius: BorderRadius.circular(8),
  ///   child: Text('Modal Content'),
  /// )
  /// ```
  const ModalContainer({super.key, required this.child, this.padding, this.filled = false, this.fillColor, this.borderRadius, this.clipBehavior = Clip.none, this.borderColor, this.borderWidth, this.boxShadow, this.surfaceOpacity, this.surfaceBlur, this.duration});
  Widget build(BuildContext context);
}
```
