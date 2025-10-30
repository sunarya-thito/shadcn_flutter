---
title: "Class: Checkbox"
description: "Core checkbox widget with comprehensive theming and interaction support."
---

```dart
/// Core checkbox widget with comprehensive theming and interaction support.
///
/// A low-level checkbox implementation that provides direct state control
/// and extensive customization options. Supports all three checkbox states,
/// smooth animations, accessibility features, and form integration.
///
/// ## Features
///
/// - **Tri-state support**: checked, unchecked, and indeterminate states
/// - **Smooth animations**: animated checkmark drawing and state transitions
/// - **Comprehensive theming**: colors, sizing, spacing, and border customization
/// - **Accessibility**: proper semantics, focus management, and keyboard support
/// - **Form integration**: automatic form field registration and validation support
/// - **Layout flexibility**: leading/trailing widgets with automatic styling
///
/// For most use cases, consider [ControlledCheckbox] which provides higher-level
/// state management. Use this widget directly when you need fine-grained control
/// over the checkbox behavior and lifecycle.
///
/// Example:
/// ```dart
/// Checkbox(
///   state: CheckboxState.checked,
///   onChanged: (newState) {
///     setState(() => currentState = newState);
///   },
///   tristate: true,
///   leading: Icon(Icons.security),
///   trailing: Text('Enable security features'),
/// )
/// ```
class Checkbox extends StatefulWidget {
  /// Current state of the checkbox.
  ///
  /// Must be one of [CheckboxState.checked], [CheckboxState.unchecked], or
  /// [CheckboxState.indeterminate]. The widget rebuilds when this changes
  /// to reflect the new visual state with appropriate animations.
  final CheckboxState state;
  /// Callback fired when the user interacts with the checkbox.
  ///
  /// Called with the new [CheckboxState] that should be applied. When null,
  /// the checkbox becomes non-interactive and visually disabled.
  ///
  /// The callback is responsible for updating the parent widget's state
  /// to reflect the change - this widget does not manage its own state.
  final ValueChanged<CheckboxState>? onChanged;
  /// Optional widget displayed before the checkbox square.
  ///
  /// Commonly used for icons or primary labels. The widget is automatically
  /// styled with small and medium text styles for visual consistency.
  /// Spacing between leading widget and checkbox is controlled by [gap].
  final Widget? leading;
  /// Optional widget displayed after the checkbox square.
  ///
  /// Commonly used for labels, descriptions, or secondary information.
  /// The widget is automatically styled with small and medium text styles
  /// for visual consistency. Spacing is controlled by [gap].
  final Widget? trailing;
  /// Whether the checkbox supports indeterminate state cycling.
  ///
  /// When true, user interaction cycles through: checked -> unchecked -> indeterminate.
  /// When false, only toggles between checked and unchecked states.
  /// The indeterminate state can still be set programmatically regardless of this setting.
  final bool tristate;
  /// Whether the checkbox is interactive and enabled.
  ///
  /// When false, the checkbox becomes visually disabled and non-interactive.
  /// When null, the enabled state is automatically determined from the presence
  /// of an [onChanged] callback.
  final bool? enabled;
  /// Size of the checkbox square in logical pixels.
  ///
  /// Overrides the theme default. When null, uses [CheckboxTheme.size] or
  /// framework default (16 logical pixels scaled by theme scaling factor).
  final double? size;
  /// Spacing between the checkbox and its leading/trailing widgets.
  ///
  /// Overrides the theme default. Applied on both sides when leading or trailing
  /// widgets are present. When null, uses [CheckboxTheme.gap] or framework default.
  final double? gap;
  /// Color of the checkbox background when in unchecked state.
  ///
  /// Overrides the theme default. Applied as the background color when unchecked.
  /// When null, uses a semi-transparent version of the theme's input background color.
  final Color? backgroundColor;
  /// Color used for the checkbox when in checked state.
  ///
  /// Overrides the theme default. Applied as both background and border color
  /// when checked. When null, uses [CheckboxTheme.activeColor] or theme primary color.
  final Color? activeColor;
  /// Color used for the checkbox border when unchecked or indeterminate.
  ///
  /// Overrides the theme default. Only visible in unchecked state as checked
  /// state uses [activeColor]. When null, uses [CheckboxTheme.borderColor] or theme border color.
  final Color? borderColor;
  /// Border radius applied to the checkbox square.
  ///
  /// Overrides the theme default. Creates rounded corners on the checkbox container.
  /// When null, uses [CheckboxTheme.borderRadius] or theme small radius.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [Checkbox] widget.
  ///
  /// The [state] and [onChanged] parameters work together to provide controlled
  /// component behavior - the widget displays the provided state and notifies
  /// of user interactions through the callback.
  ///
  /// Parameters:
  /// - [state] (CheckboxState, required): current checkbox state to display
  /// - [onChanged] (`ValueChanged<CheckboxState>?`, required): interaction callback
  /// - [leading] (Widget?, optional): widget displayed before checkbox
  /// - [trailing] (Widget?, optional): widget displayed after checkbox
  /// - [tristate] (bool, default: false): enable indeterminate state cycling
  /// - [enabled] (bool?, optional): override interactivity (null = auto-detect)
  /// - [size] (double?, optional): override checkbox square size
  /// - [gap] (double?, optional): override spacing around checkbox
  /// - [backgroundColor] (Color?, optional): override unchecked state color
  /// - [activeColor] (Color?, optional): override checked state color
  /// - [borderColor] (Color?, optional): override border color
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override corner radius
  ///
  /// Example:
  /// ```dart
  /// Checkbox(
  ///   state: isAccepted ? CheckboxState.checked : CheckboxState.unchecked,
  ///   onChanged: (state) => setState(() {
  ///     isAccepted = state == CheckboxState.checked;
  ///   }),
  ///   trailing: Text('I accept the terms and conditions'),
  /// )
  /// ```
  const Checkbox({super.key, required this.state, required this.onChanged, this.leading, this.trailing, this.tristate = false, this.enabled, this.size, this.gap, this.backgroundColor, this.activeColor, this.borderColor, this.borderRadius});
  State<Checkbox> createState();
}
```
