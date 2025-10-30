---
title: "Class: ControlledCheckbox"
description: "Reactive checkbox with automatic state management and controller support."
---

```dart
/// Reactive checkbox with automatic state management and controller support.
///
/// A higher-level checkbox widget that provides automatic state management
/// through the controlled component pattern. Can be used with an external
/// [CheckboxController] for programmatic control or with callback-based
/// state management.
///
/// Supports all checkbox features including tri-state behavior, leading/trailing
/// widgets, and comprehensive theming. The widget automatically handles focus,
/// enabled states, and form integration.
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state management):**
/// ```dart
/// final controller = CheckboxController(CheckboxState.unchecked);
///
/// ControlledCheckbox(
///   controller: controller,
///   tristate: true,
///   leading: Text('Accept terms'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// bool checked = false;
///
/// ControlledCheckbox(
///   initialValue: checked ? CheckboxState.checked : CheckboxState.unchecked,
///   onChanged: (state) => setState(() {
///     checked = state == CheckboxState.checked;
///   }),
///   trailing: Text('Newsletter subscription'),
/// )
/// ```
class ControlledCheckbox extends StatelessWidget with ControlledComponent<CheckboxState> {
  /// External controller for programmatic state management.
  ///
  /// When provided, takes precedence over [initialValue] and [onChanged].
  /// The controller's state changes are automatically reflected in the widget.
  final CheckboxController? controller;
  /// Initial checkbox state when no controller is provided.
  ///
  /// Used only when [controller] is null. Defaults to [CheckboxState.unchecked].
  final CheckboxState initialValue;
  /// Callback fired when the checkbox state changes.
  ///
  /// Called with the new [CheckboxState] when user interaction occurs.
  /// If both [controller] and [onChanged] are provided, both will receive updates.
  final ValueChanged<CheckboxState>? onChanged;
  /// Whether the checkbox is interactive.
  ///
  /// When false, the checkbox becomes read-only and visually disabled.
  /// When null, automatically determines enabled state based on [onChanged] or [controller].
  final bool enabled;
  /// Optional widget displayed before the checkbox square.
  ///
  /// Commonly used for labels or icons. Automatically styled with small and
  /// medium text styles for consistency.
  final Widget? leading;
  /// Optional widget displayed after the checkbox square.
  ///
  /// Commonly used for labels, descriptions, or additional controls.
  /// Automatically styled with small and medium text styles for consistency.
  final Widget? trailing;
  /// Whether the checkbox supports three states including indeterminate.
  ///
  /// When true, clicking cycles through: checked -> unchecked -> indeterminate -> checked.
  /// When false, only toggles between checked and unchecked. Defaults to false.
  final bool tristate;
  /// Override size of the checkbox square in logical pixels.
  ///
  /// When null, uses the theme size or framework default (16px scaled).
  final double? size;
  /// Override spacing between checkbox and leading/trailing widgets.
  ///
  /// When null, uses the theme gap or framework default (8px scaled).
  final double? gap;
  /// Override color of the checkbox background when in unchecked state.
  ///
  /// When null, uses a semi-transparent version of the theme's input background color.
  final Color? backgroundColor;
  /// Override color of the checkbox when checked.
  ///
  /// When null, uses the theme active color or primary color.
  final Color? activeColor;
  /// Override color of the checkbox border when unchecked.
  ///
  /// When null, uses the theme border color or framework border color.
  final Color? borderColor;
  /// Override border radius of the checkbox square.
  ///
  /// When null, uses the theme border radius or small radius (4px).
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [ControlledCheckbox].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns depending on application architecture needs.
  ///
  /// Parameters:
  /// - [controller] (CheckboxController?, optional): external state controller
  /// - [initialValue] (CheckboxState, default: unchecked): starting state when no controller
  /// - [onChanged] (`ValueChanged<CheckboxState>?`, optional): state change callback
  /// - [enabled] (bool, default: true): whether checkbox is interactive
  /// - [leading] (Widget?, optional): widget displayed before checkbox
  /// - [trailing] (Widget?, optional): widget displayed after checkbox
  /// - [tristate] (bool, default: false): whether to support indeterminate state
  /// - [size] (double?, optional): override checkbox square size
  /// - [gap] (double?, optional): override spacing around checkbox
  /// - [backgroundColor] (Color?, optional): override unchecked state color
  /// - [activeColor] (Color?, optional): override checked state color
  /// - [borderColor] (Color?, optional): override border color
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override corner radius
  ///
  /// Example:
  /// ```dart
  /// ControlledCheckbox(
  ///   controller: controller,
  ///   tristate: true,
  ///   leading: Icon(Icons.star),
  ///   trailing: Text('Favorite'),
  /// )
  /// ```
  const ControlledCheckbox({super.key, this.controller, this.initialValue = CheckboxState.unchecked, this.onChanged, this.enabled = true, this.leading, this.trailing, this.tristate = false, this.size, this.gap, this.backgroundColor, this.activeColor, this.borderColor, this.borderRadius});
  Widget build(BuildContext context);
}
```
