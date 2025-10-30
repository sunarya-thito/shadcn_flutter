---
title: "Class: KeyboardDisplay"
description: "A widget that displays keyboard shortcuts in a visually appealing format."
---

```dart
/// A widget that displays keyboard shortcuts in a visually appealing format.
///
/// Renders keyboard key combinations as styled keyboard key representations,
/// typically used in tooltips, help text, or UI elements that need to
/// communicate keyboard shortcuts to users. The display automatically
/// formats keys with appropriate spacing and visual styling.
///
/// Supports both direct key specification through a list of [LogicalKeyboardKey]
/// objects and automatic conversion from [ShortcutActivator] instances.
/// Keys are displayed as individual key representations with configurable
/// spacing between them.
///
/// The component integrates with the keyboard shortcut theming system
/// and adapts its appearance based on the current theme and scaling settings.
/// Visual styling matches platform conventions for keyboard key representations.
///
/// Example:
/// ```dart
/// KeyboardDisplay(
///   keys: [
///     LogicalKeyboardKey.controlLeft,
///     LogicalKeyboardKey.keyS,
///   ],
///   spacing: 4.0,
/// )
/// ```
class KeyboardDisplay extends StatelessWidget {
  /// Spacing between individual keyboard key displays.
  ///
  /// Controls the horizontal gap between adjacent key representations.
  /// When null, uses theme-appropriate default spacing.
  final double? spacing;
  /// Creates a [KeyboardDisplay] from a list of keyboard keys.
  ///
  /// Displays the specified keyboard keys as styled key representations
  /// with appropriate spacing. This constructor allows direct control
  /// over which keys are displayed.
  ///
  /// Parameters:
  /// - [keys] (`List<LogicalKeyboardKey>`, required): Keys to display
  /// - [spacing] (double?, optional): Gap between key displays
  ///
  /// Example:
  /// ```dart
  /// KeyboardDisplay(
  ///   keys: [LogicalKeyboardKey.alt, LogicalKeyboardKey.tab],
  ///   spacing: 6.0,
  /// )
  /// ```
  const KeyboardDisplay({super.key, required List<LogicalKeyboardKey> keys, this.spacing});
  /// Creates a [KeyboardDisplay] from a shortcut activator.
  ///
  /// Automatically extracts the keyboard keys from the provided
  /// [ShortcutActivator] and displays them as styled key representations.
  /// This constructor is convenient when working with Flutter's shortcut system.
  ///
  /// Parameters:
  /// - [activator] (ShortcutActivator, required): Shortcut to extract keys from
  /// - [spacing] (double?, optional): Gap between key displays
  ///
  /// Example:
  /// ```dart
  /// KeyboardDisplay.fromActivator(
  ///   activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
  ///   spacing: 4.0,
  /// )
  /// ```
  const KeyboardDisplay.fromActivator({super.key, required ShortcutActivator activator, this.spacing});
  Widget build(BuildContext context);
}
```
