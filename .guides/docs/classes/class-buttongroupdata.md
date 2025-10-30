---
title: "Class: ButtonGroupData"
description: "Data class defining border radius multipliers for grouped buttons."
---

```dart
/// Data class defining border radius multipliers for grouped buttons.
///
/// [ButtonGroupData] specifies which corners of a button should have reduced
/// border radius when part of a [ButtonGroup]. Values of 0.0 remove the radius
/// entirely (for internal buttons), while 1.0 preserves the full radius (for
/// end buttons).
///
/// This class uses directional values (start/end) to support RTL layouts properly.
/// The static constants provide common configurations for different positions
/// within a button group.
///
/// Example:
/// ```dart
/// // First button in horizontal group - preserve left radius, remove right
/// ButtonGroupData.horizontal(end: 0.0)
///
/// // Middle button - remove all radius
/// ButtonGroupData.zero
///
/// // Last button in horizontal group - remove left radius, preserve right
/// ButtonGroupData.horizontal(start: 0.0)
/// ```
class ButtonGroupData {
  /// No modification - full border radius on all corners.
  static const ButtonGroupData none = ButtonGroupData.all(1.0);
  /// Zero radius - removes border radius from all corners.
  static const ButtonGroupData zero = ButtonGroupData.all(0.0);
  /// Horizontal start position - full start radius, no end radius.
  static const ButtonGroupData horizontalStart = ButtonGroupData.horizontal(end: 0.0);
  /// Horizontal end position - no start radius, full end radius.
  static const ButtonGroupData horizontalEnd = ButtonGroupData.horizontal(start: 0.0);
  /// Vertical top position - full top radius, no bottom radius.
  static const ButtonGroupData verticalTop = ButtonGroupData.vertical(bottom: 0.0);
  /// Vertical bottom position - no top radius, full bottom radius.
  static const ButtonGroupData verticalBottom = ButtonGroupData.vertical(top: 0.0);
  /// Border radius multiplier for top-start corner (0.0 to 1.0).
  final double topStartValue;
  /// Border radius multiplier for top-end corner (0.0 to 1.0).
  final double topEndValue;
  /// Border radius multiplier for bottom-start corner (0.0 to 1.0).
  final double bottomStartValue;
  /// Border radius multiplier for bottom-end corner (0.0 to 1.0).
  final double bottomEndValue;
  /// Creates button group data with individual corner multipliers.
  const ButtonGroupData({required this.topStartValue, required this.topEndValue, required this.bottomStartValue, required this.bottomEndValue});
  /// Creates horizontal group data with start and end multipliers.
  ///
  /// Both top and bottom on each side use the same value.
  const ButtonGroupData.horizontal({double start = 1.0, double end = 1.0});
  /// Creates vertical group data with top and bottom multipliers.
  ///
  /// Both start and end on each side use the same value.
  const ButtonGroupData.vertical({double top = 1.0, double bottom = 1.0});
  /// Creates group data with the same multiplier for all corners.
  const ButtonGroupData.all(double value);
  /// Creates group data for a button at [index] in a horizontal group of [length] buttons.
  ///
  /// Returns:
  /// - [horizontalStart] for the first button (index 0)
  /// - [zero] for middle buttons
  /// - [horizontalEnd] for the last button
  /// - [none] if group has only one button
  factory ButtonGroupData.horizontalIndex(int index, int length);
  /// Creates group data for a button at [index] in a vertical group of [length] buttons.
  ///
  /// Returns:
  /// - [verticalTop] for the first button (index 0)
  /// - [zero] for middle buttons
  /// - [verticalBottom] for the last button
  /// - [none] if group has only one button
  factory ButtonGroupData.verticalIndex(int index, int length);
  /// Applies corner multipliers to a border radius.
  ///
  /// Multiplies each corner's radius by the corresponding corner value,
  /// properly handling text direction for start/end mapping to left/right.
  ///
  /// Parameters:
  /// - [borderRadius]: The base border radius to modify
  /// - [textDirection]: Text direction for resolving start/end to left/right
  ///
  /// Returns a new [BorderRadiusGeometry] with modified corner radii.
  BorderRadiusGeometry applyToBorderRadius(BorderRadiusGeometry borderRadius, TextDirection textDirection);
  /// Combines this group data with another by multiplying corresponding corner values.
  ///
  /// Useful for nesting button groups or applying multiple grouping effects.
  /// Each corner value is multiplied: result = this.value * other.value.
  ///
  /// Example:
  /// ```dart
  /// final half = ButtonGroupData.all(0.5);
  /// final end = ButtonGroupData.horizontal(start: 0.0);
  /// final combined = half.applyToButtonGroupData(end);
  /// // combined has: topStart=0, bottomStart=0, topEnd=0.5, bottomEnd=0.5
  /// ```
  ButtonGroupData applyToButtonGroupData(ButtonGroupData other);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
