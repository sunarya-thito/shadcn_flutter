---
title: "Class: SwitchTheme"
description: "Theme configuration for [Switch] widget styling and visual appearance."
---

```dart
/// Theme configuration for [Switch] widget styling and visual appearance.
///
/// Defines the visual properties used by switch components including colors,
/// spacing, and border styling for different switch states. All properties are
/// optional and fall back to framework defaults when not specified.
///
/// Supports comprehensive customization of switch appearance including track
/// colors, thumb colors, and layout properties to match application design.
class SwitchTheme {
  /// Color of the switch track when in the active/on state.
  ///
  /// Applied as the background color of the switch track when toggled on.
  /// When null, uses the theme's primary color for visual consistency.
  final Color? activeColor;
  /// Color of the switch track when in the inactive/off state.
  ///
  /// Applied as the background color of the switch track when toggled off.
  /// When null, uses the theme's muted color for visual hierarchy.
  final Color? inactiveColor;
  /// Color of the switch thumb when in the active/on state.
  ///
  /// Applied to the circular thumb element when the switch is toggled on.
  /// When null, uses the theme's primary foreground color for contrast.
  final Color? activeThumbColor;
  /// Color of the switch thumb when in the inactive/off state.
  ///
  /// Applied to the circular thumb element when the switch is toggled off.
  /// When null, uses a contrasting color against the inactive track.
  final Color? inactiveThumbColor;
  /// Spacing between the switch and its leading/trailing widgets.
  ///
  /// Applied on both sides of the switch when leading or trailing widgets
  /// are provided. When null, defaults to framework spacing standards.
  final double? gap;
  /// Border radius applied to the switch track corners.
  ///
  /// Creates rounded corners on the switch track container. When null,
  /// uses a fully rounded appearance typical of toggle switches.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [SwitchTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  /// The theme can be applied to individual switches or globally through
  /// the component theme system.
  const SwitchTheme({this.activeColor, this.inactiveColor, this.activeThumbColor, this.inactiveThumbColor, this.gap, this.borderRadius});
  /// Returns a copy of this theme with the given fields replaced.
  SwitchTheme copyWith({ValueGetter<Color?>? activeColor, ValueGetter<Color?>? inactiveColor, ValueGetter<Color?>? activeThumbColor, ValueGetter<Color?>? inactiveThumbColor, ValueGetter<double?>? gap, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
