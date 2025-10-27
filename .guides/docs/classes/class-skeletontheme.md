---
title: "Class: SkeletonTheme"
description: "Theme configuration for skeleton loading effects."
---

```dart
/// Theme configuration for skeleton loading effects.
///
/// Provides styling properties for skeleton loading animations including pulse
/// timing, colors, and animation behavior. These properties integrate with the
/// shadcn design system and work with the underlying Skeletonizer package.
///
/// The theme enables consistent skeleton styling across the application while
/// allowing for customization of animation characteristics and visual appearance.
class SkeletonTheme {
  /// The duration of one complete pulse animation cycle.
  ///
  /// Type: `Duration?`. If null, defaults to 1 second for a natural breathing
  /// effect. Controls the speed of the fade in/out pulse animation.
  final Duration? duration;
  /// The starting color of the pulse animation.
  ///
  /// Type: `Color?`. If null, uses primary color with 5% opacity from theme.
  /// Represents the lightest state of the skeleton shimmer effect.
  final Color? fromColor;
  /// The ending color of the pulse animation.
  ///
  /// Type: `Color?`. If null, uses primary color with 10% opacity from theme.
  /// Represents the darkest state of the skeleton shimmer effect.
  final Color? toColor;
  /// Whether to enable smooth transitions when switching between skeleton states.
  ///
  /// Type: `bool?`. If null, defaults to true. When enabled, provides smooth
  /// fade transitions when toggling skeleton visibility on/off.
  final bool? enableSwitchAnimation;
  /// Creates a [SkeletonTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// that integrate with the current theme's color scheme and design system.
  ///
  /// Example:
  /// ```dart
  /// const SkeletonTheme(
  ///   duration: Duration(milliseconds: 800),
  ///   fromColor: Colors.grey.withOpacity(0.1),
  ///   toColor: Colors.grey.withOpacity(0.2),
  ///   enableSwitchAnimation: true,
  /// );
  /// ```
  const SkeletonTheme({this.duration, this.fromColor, this.toColor, this.enableSwitchAnimation});
  /// Returns a copy of this theme with the given fields replaced.
  SkeletonTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Color?>? fromColor, ValueGetter<Color?>? toColor, ValueGetter<bool?>? enableSwitchAnimation});
  bool operator ==(Object other);
  int get hashCode;
}
```
