---
title: "Class: KeyboardKeyDisplay"
description: "A widget that displays a single keyboard key in a styled format."
---

```dart
/// A widget that displays a single keyboard key in a styled format.
///
/// Renders an individual keyboard key as a styled representation that
/// resembles a physical keyboard key. Used internally by [KeyboardDisplay]
/// but can also be used standalone for displaying individual keys.
///
/// The key display automatically formats the key label based on the
/// [LogicalKeyboardKey] and applies appropriate styling including
/// padding, shadows, and theme-consistent appearance.
///
/// Example:
/// ```dart
/// KeyboardKeyDisplay(
///   keyboardKey: LogicalKeyboardKey.controlLeft,
///   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
/// )
/// ```
class KeyboardKeyDisplay extends StatelessWidget {
  /// The keyboard key to display.
  ///
  /// Specifies which keyboard key should be rendered. The display
  /// automatically formats the key label and applies appropriate styling.
  final LogicalKeyboardKey keyboardKey;
  /// Internal padding applied within the key display.
  ///
  /// Controls spacing around the key label text. When null,
  /// uses theme-appropriate default padding for key displays.
  final EdgeInsetsGeometry? padding;
  /// Box shadows applied to the key display for depth effect.
  ///
  /// Creates visual depth to simulate the appearance of physical
  /// keyboard keys. When null, uses theme default shadows.
  final List<BoxShadow>? boxShadow;
  /// Creates a [KeyboardKeyDisplay] for the specified keyboard key.
  ///
  /// The [keyboardKey] parameter is required and determines which
  /// key is displayed. Visual appearance can be customized through
  /// the optional padding and shadow parameters.
  ///
  /// Parameters:
  /// - [keyboardKey] (LogicalKeyboardKey, required): Key to display
  /// - [padding] (EdgeInsetsGeometry?, optional): Internal padding
  /// - [boxShadow] (`List<BoxShadow>?`, optional): Shadow effects
  ///
  /// Example:
  /// ```dart
  /// KeyboardKeyDisplay(
  ///   keyboardKey: LogicalKeyboardKey.escape,
  ///   padding: EdgeInsets.all(6),
  /// )
  /// ```
  const KeyboardKeyDisplay({super.key, required this.keyboardKey, this.padding, this.boxShadow});
  Widget build(BuildContext context);
}
```
