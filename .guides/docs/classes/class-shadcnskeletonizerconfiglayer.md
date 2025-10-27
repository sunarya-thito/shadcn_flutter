---
title: "Class: ShadcnSkeletonizerConfigLayer"
description: "A configuration layer that provides Skeletonizer setup with theme integration."
---

```dart
/// A configuration layer that provides Skeletonizer setup with theme integration.
///
/// ShadcnSkeletonizerConfigLayer acts as a bridge between the shadcn theme system
/// and the underlying Skeletonizer package, ensuring skeleton loading effects
/// are consistent with the overall design system. This widget wraps content
/// with properly configured skeleton animation settings.
///
/// The component automatically resolves theme values from [SkeletonTheme] and
/// applies appropriate defaults based on the current theme's color scheme and
/// scaling factors. It creates a [SkeletonizerConfig] with [PulseEffect] for
/// smooth, accessible loading animations.
///
/// This is typically used internally by skeleton extension methods and should
/// rarely be instantiated directly by application code.
///
/// Example:
/// ```dart
/// ShadcnSkeletonizerConfigLayer(
///   theme: Theme.of(context),
///   child: YourContentWidget(),
/// );
/// ```
class ShadcnSkeletonizerConfigLayer extends StatelessWidget {
  /// The theme data used for skeleton configuration.
  ///
  /// Type: `ThemeData`, required. Provides color scheme, scaling factors,
  /// and other design system values for skeleton appearance calculation.
  final ThemeData theme;
  /// The child widget to wrap with skeleton configuration.
  ///
  /// Type: `Widget`, required. The content that will have skeleton
  /// configuration available through the widget tree.
  final Widget child;
  /// Override duration for the pulse animation cycle.
  ///
  /// Type: `Duration?`. If provided, overrides theme and default duration
  /// values for this specific configuration layer.
  final Duration? duration;
  /// Override starting color for the pulse animation.
  ///
  /// Type: `Color?`. If provided, overrides theme and default color
  /// values for the lightest pulse state.
  final Color? fromColor;
  /// Override ending color for the pulse animation.
  ///
  /// Type: `Color?`. If provided, overrides theme and default color
  /// values for the darkest pulse state.
  final Color? toColor;
  /// Override switch animation behavior.
  ///
  /// Type: `bool?`. If provided, overrides theme and default animation
  /// behavior when toggling skeleton visibility.
  final bool? enableSwitchAnimation;
  /// Creates a [ShadcnSkeletonizerConfigLayer].
  ///
  /// The [theme] and [child] parameters are required for proper skeleton
  /// configuration and content wrapping. Override parameters allow for
  /// fine-tuned control of skeleton appearance at the layer level.
  ///
  /// Parameters:
  /// - [theme] (ThemeData, required): Theme for skeleton configuration calculation
  /// - [child] (Widget, required): Content to wrap with skeleton configuration
  /// - [duration] (Duration?, optional): Pulse animation duration override
  /// - [fromColor] (Color?, optional): Pulse start color override
  /// - [toColor] (Color?, optional): Pulse end color override
  /// - [enableSwitchAnimation] (bool?, optional): Switch animation behavior override
  ///
  /// Example:
  /// ```dart
  /// ShadcnSkeletonizerConfigLayer(
  ///   theme: Theme.of(context),
  ///   duration: Duration(milliseconds: 1200),
  ///   child: MyContentWidget(),
  /// );
  /// ```
  const ShadcnSkeletonizerConfigLayer({super.key, required this.theme, required this.child, this.duration, this.fromColor, this.toColor, this.enableSwitchAnimation});
  Widget build(BuildContext context);
}
```
