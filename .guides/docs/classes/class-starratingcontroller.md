---
title: "Class: StarRatingController"
description: "A controller for managing [StarRating] widget values programmatically."
---

```dart
/// A controller for managing [StarRating] widget values programmatically.
///
/// This controller extends [ValueNotifier] and implements [ComponentController]
/// to provide a standardized way to control star rating values externally.
/// It allows programmatic manipulation of the rating value and provides
/// change notification capabilities.
///
/// The controller maintains a double value representing the current rating,
/// which is typically in the range of 0.0 to the maximum rating value.
///
/// Example:
/// ```dart
/// final controller = StarRatingController(3.5);
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Rating changed to: ${controller.value}');
/// });
///
/// // Update the rating
/// controller.value = 4.0;
/// ```
class StarRatingController extends ValueNotifier<double> with ComponentController<double> {
  /// Creates a [StarRatingController] with the given initial [value].
  ///
  /// The [value] parameter sets the initial rating value. Defaults to 0.0
  /// if not specified. The value should typically be within the range
  /// supported by the star rating widget (0.0 to max value).
  ///
  /// Parameters:
  /// - [value] (double, default: 0.0): Initial rating value
  StarRatingController([super.value = 0.0]);
}
```
