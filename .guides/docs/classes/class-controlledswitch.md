---
title: "Class: ControlledSwitch"
description: "A controlled switch widget with automatic state management."
---

```dart
/// A controlled switch widget with automatic state management.
///
/// Manages its state either through an external [controller] or internal
/// state with [initialValue]. Provides a toggle interface for boolean values
/// with customizable appearance including colors, icons, and layout options.
///
/// Example:
/// ```dart
/// ControlledSwitch(
///   initialValue: true,
///   onChanged: (value) => print('Switched to: $value'),
///   leading: Icon(Icons.wifi),
///   activeColor: Colors.green,
/// )
/// ```
class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final SwitchController? controller;
  /// Optional leading widget displayed before the switch.
  ///
  /// Typically an icon or text label.
  final Widget? leading;
  /// Optional trailing widget displayed after the switch.
  ///
  /// Typically an icon or text label.
  final Widget? trailing;
  /// Spacing between the switch and [leading]/[trailing] widgets.
  ///
  /// If `null`, uses the default gap from the theme.
  final double? gap;
  /// Color of the switch when in the active (on) state.
  ///
  /// If `null`, uses the theme's primary color.
  final Color? activeColor;
  /// Color of the switch when in the inactive (off) state.
  ///
  /// If `null`, uses a default inactive color from the theme.
  final Color? inactiveColor;
  /// Color of the thumb (knob) when the switch is active.
  ///
  /// If `null`, uses a default thumb color.
  final Color? activeThumbColor;
  /// Color of the thumb (knob) when the switch is inactive.
  ///
  /// If `null`, uses a default thumb color.
  final Color? inactiveThumbColor;
  /// Border radius for the switch track.
  ///
  /// If `null`, uses the default border radius from the theme.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [ControlledSwitch].
  const ControlledSwitch({super.key, this.controller, this.initialValue = false, this.onChanged, this.enabled = true, this.leading, this.trailing, this.gap, this.activeColor, this.inactiveColor, this.activeThumbColor, this.inactiveThumbColor, this.borderRadius});
  Widget build(BuildContext context);
}
```
