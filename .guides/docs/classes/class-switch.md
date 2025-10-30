---
title: "Class: Switch"
description: "A Material Design switch for toggling boolean values."
---

```dart
/// A Material Design switch for toggling boolean values.
///
/// Provides a sliding toggle control for selecting between two states (on/off).
/// Supports customization of colors, leading/trailing widgets, and appearance
/// options. Unlike [ControlledSwitch], this widget requires explicit state
/// management.
///
/// Example:
/// ```dart
/// Switch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
///   activeColor: Colors.blue,
///   leading: Text('Enable feature'),
/// )
/// ```
class Switch extends StatefulWidget {
  /// The current state of the switch.
  final bool value;
  /// Callback invoked when the switch state changes.
  ///
  /// If `null`, the switch is disabled.
  final ValueChanged<bool>? onChanged;
  /// Optional leading widget displayed before the switch.
  ///
  /// Typically an icon or text label.
  final Widget? leading;
  /// Optional trailing widget displayed after the switch.
  ///
  /// Typically an icon or text label.
  final Widget? trailing;
  /// Whether the switch is interactive.
  ///
  /// When `false`, the switch is disabled. Defaults to `true`.
  final bool? enabled;
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
  /// Creates a [Switch].
  const Switch({super.key, required this.value, required this.onChanged, this.leading, this.trailing, this.enabled = true, this.gap, this.activeColor, this.inactiveColor, this.activeThumbColor, this.inactiveThumbColor, this.borderRadius});
  State<Switch> createState();
}
```
