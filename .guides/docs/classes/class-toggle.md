---
title: "Class: Toggle"
description: "Simple toggle button with stateful on/off behavior."
---

```dart
/// Simple toggle button with stateful on/off behavior.
///
/// A basic toggle button widget that maintains its own internal state for
/// on/off toggling. Provides a simplified interface compared to [ControlledToggle]
/// for cases where external state management is not required.
///
/// ## Features
///
/// - **Stateful toggling**: Built-in state management for simple use cases
/// - **Ghost button styling**: Default ghost button appearance
/// - **Form integration**: Automatic form field registration with boolean values
/// - **Accessibility**: Full screen reader and keyboard support
/// - **Custom styling**: Configurable button style and appearance
///
/// The widget automatically cycles between true/false states when pressed
/// and calls the [onChanged] callback with the new state.
///
/// Example:
/// ```dart
/// bool isEnabled = false;
///
/// Toggle(
///   value: isEnabled,
///   onChanged: (enabled) => setState(() => isEnabled = enabled),
///   child: Text('Enable notifications'),
/// );
/// ```
class Toggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final ButtonStyle style;
  final bool? enabled;
  /// Creates a [Toggle].
  ///
  /// The toggle button maintains its own state and calls [onChanged] when
  /// the state changes. Uses ghost button styling by default.
  ///
  /// Parameters:
  /// - [value] (bool, required): current toggle state
  /// - [onChanged] (`ValueChanged<bool>?`, optional): callback when state changes
  /// - [child] (Widget, required): content displayed inside the button
  /// - [enabled] (bool?, optional): whether button is interactive
  /// - [style] (ButtonStyle, default: ghost): button styling
  ///
  /// Example:
  /// ```dart
  /// Toggle(
  ///   value: isToggled,
  ///   onChanged: (value) => setState(() => isToggled = value),
  ///   child: Row(
  ///     children: [
  ///       Icon(Icons.notifications),
  ///       Text('Notifications'),
  ///     ],
  ///   ),
  /// )
  /// ```
  const Toggle({super.key, required this.value, this.onChanged, required this.child, this.enabled, this.style = const ButtonStyle.ghost()});
  ToggleState createState();
}
```
