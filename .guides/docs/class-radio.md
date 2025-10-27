---
title: "Class: Radio"
description: "A radio button widget that displays a circular selection indicator."
---

```dart
/// A radio button widget that displays a circular selection indicator.
///
/// [Radio] provides a visual representation of a selectable option within
/// a radio group. It displays as a circular button with an inner dot when
/// selected and an empty circle when unselected. The widget supports focus
/// indication and customizable colors and sizing.
///
/// The radio button animates smoothly between selected and unselected states,
/// providing visual feedback to user interactions. It integrates with the
/// focus system to provide accessibility support and keyboard navigation.
///
/// Typically used within [RadioItem] or [RadioGroup] components rather than
/// standalone, as it only provides the visual representation without the
/// interaction logic.
///
/// Example:
/// ```dart
/// Radio(
///   value: isSelected,
///   focusing: hasFocus,
///   size: 20,
///   activeColor: Colors.blue,
/// );
/// ```
class Radio extends StatelessWidget {
  /// Whether this radio button is selected.
  ///
  /// When true, displays the inner selection indicator.
  /// When false, shows only the outer circle border.
  final bool value;
  /// Whether this radio button currently has focus.
  ///
  /// When true, displays a focus outline around the radio button
  /// for accessibility and keyboard navigation indication.
  final bool focusing;
  /// Size of the radio button in logical pixels.
  ///
  /// Controls both the width and height of the circular radio button.
  /// If null, uses the size from the current [RadioTheme].
  final double? size;
  /// Color of the inner selection indicator when selected.
  ///
  /// Applied to the inner dot that appears when [value] is true.
  /// If null, uses the activeColor from the current [RadioTheme].
  final Color? activeColor;
  /// Color of the outer border circle.
  ///
  /// Applied to the border of the radio button in both selected and
  /// unselected states. If null, uses the borderColor from the current [RadioTheme].
  final Color? borderColor;
  /// Background color of the radio button circle.
  ///
  /// Applied as the fill color behind the border. If null, uses the
  /// backgroundColor from the current [RadioTheme].
  final Color? backgroundColor;
  /// Creates a [Radio] with the specified selection state and styling.
  ///
  /// The [value] parameter is required and determines whether the radio
  /// appears selected. All other parameters are optional and will fall
  /// back to theme values when not specified.
  ///
  /// Parameters:
  /// - [value] (bool, required): Whether the radio button is selected
  /// - [focusing] (bool, default: false): Whether the radio has focus
  /// - [size] (double?, optional): Size of the radio button in pixels
  /// - [activeColor] (Color?, optional): Color of the selection indicator
  /// - [borderColor] (Color?, optional): Color of the outer border
  /// - [backgroundColor] (Color?, optional): Color of the background fill
  ///
  /// Example:
  /// ```dart
  /// Radio(
  ///   value: selectedValue == itemValue,
  ///   focusing: focusNode.hasFocus,
  ///   size: 18,
  /// );
  /// ```
  const Radio({super.key, required this.value, this.focusing = false, this.size, this.activeColor, this.borderColor, this.backgroundColor});
  Widget build(BuildContext context);
}
```
