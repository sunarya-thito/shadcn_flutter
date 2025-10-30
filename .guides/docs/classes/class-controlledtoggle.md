---
title: "Class: ControlledToggle"
description: "A controlled version of [Toggle] that integrates with form state management."
---

```dart
/// A controlled version of [Toggle] that integrates with form state management.
///
/// [ControlledToggle] implements the [ControlledComponent] mixin to provide
/// automatic form integration, validation, and state management. It serves as
/// a bridge between external state management (via [ToggleController] or
/// [onChanged] callbacks) and the underlying [Toggle] widget.
///
/// This widget is ideal for use in forms where the toggle state needs to be
/// managed externally, validated, or persisted. It automatically handles the
/// conversion between controlled and uncontrolled modes based on the provided
/// parameters.
///
/// Example:
/// ```dart
/// final controller = ToggleController(false);
///
/// ControlledToggle(
///   controller: controller,
///   child: Row(
///     children: [
///       Icon(Icons.notifications),
///       Text('Enable notifications'),
///     ],
///   ),
/// );
/// ```
class ControlledToggle extends StatelessWidget with ControlledComponent<bool> {
  /// The initial toggle state when no controller is provided.
  ///
  /// Used only in uncontrolled mode. If both [controller] and [initialValue]
  /// are provided, [controller] takes precedence.
  final bool? initialValue;
  /// Callback invoked when the toggle state changes.
  ///
  /// Called with the new boolean value whenever the user toggles the button.
  /// If null, the toggle becomes read-only (though it can still be controlled
  /// via [controller] if provided).
  final ValueChanged<bool>? onChanged;
  /// Whether the toggle is interactive.
  ///
  /// When false, the toggle appears disabled and doesn't respond to user input.
  /// The toggle can still be changed programmatically via [controller].
  final bool enabled;
  /// Controller for managing toggle state externally.
  ///
  /// When provided, the toggle operates in controlled mode and its state is
  /// managed entirely by this controller. Changes are reflected immediately
  /// and [onChanged] is called when the user interacts with the toggle.
  final ToggleController? controller;
  /// The child widget to display inside the toggle button.
  ///
  /// Typically contains text, icons, or a combination of both. The child
  /// receives the visual styling and interaction behavior of the toggle button.
  final Widget child;
  /// Visual styling for the toggle button.
  ///
  /// Defines the appearance, colors, padding, and other visual characteristics
  /// of the toggle. Defaults to ghost button style with subtle appearance changes
  /// between toggled and untoggled states.
  final ButtonStyle style;
  /// Creates a [ControlledToggle] widget.
  ///
  /// Parameters:
  /// - [controller] (ToggleController?, optional): External state controller.
  /// - [initialValue] (bool?, optional): Initial state for uncontrolled mode.
  /// - [onChanged] (`ValueChanged<bool>?`, optional): State change callback.
  /// - [enabled] (bool, default: true): Whether the toggle is interactive.
  /// - [child] (Widget, required): Content to display in the toggle button.
  /// - [style] (ButtonStyle, default: ButtonStyle.ghost()): Visual styling.
  ///
  /// Example:
  /// ```dart
  /// ControlledToggle(
  ///   initialValue: false,
  ///   onChanged: (value) => print('Toggled: $value'),
  ///   enabled: true,
  ///   style: ButtonStyle.secondary(),
  ///   child: Text('Toggle Me'),
  /// );
  /// ```
  const ControlledToggle({super.key, this.controller, this.initialValue, this.onChanged, this.enabled = true, required this.child, this.style = const ButtonStyle.ghost()});
  Widget build(BuildContext context);
}
```
