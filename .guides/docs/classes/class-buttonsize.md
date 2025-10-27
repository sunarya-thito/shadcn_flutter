---
title: "Class: ButtonSize"
description: "Defines the relative size scaling for button components."
---

```dart
/// Defines the relative size scaling for button components.
///
/// [ButtonSize] controls the overall scale of buttons, affecting text size,
/// icon size, and proportional padding. The scaling factor is applied to
/// all dimensional properties to maintain visual consistency.
///
/// Example:
/// ```dart
/// Button.primary(
///   style: ButtonStyle.primary().copyWith(size: ButtonSize.large),
///   child: Text('Large Button'),
/// );
/// ```
class ButtonSize {
  /// The scaling factor applied to button dimensions.
  ///
  /// A value of 1.0 represents normal size, values less than 1.0 create smaller
  /// buttons, and values greater than 1.0 create larger buttons.
  final double scale;
  /// Creates a [ButtonSize] with the specified scaling factor.
  const ButtonSize(this.scale);
  /// Standard button size (scale: 1.0).
  static const ButtonSize normal = ButtonSize(1);
  /// Extra small button size (scale: 0.5).
  static const ButtonSize xSmall = ButtonSize(1 / 2);
  /// Small button size (scale: 0.75).
  static const ButtonSize small = ButtonSize(3 / 4);
  /// Large button size (scale: 2.0).
  static const ButtonSize large = ButtonSize(2);
  /// Extra large button size (scale: 3.0).
  static const ButtonSize xLarge = ButtonSize(3);
}
```
