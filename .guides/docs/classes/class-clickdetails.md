---
title: "Class: ClickDetails"
description: "Details about a click event, including the click count."
---

```dart
/// Details about a click event, including the click count.
///
/// Provides information about click interactions, particularly useful
/// for detecting single, double, or multiple clicks on a widget.
///
/// The [clickCount] indicates how many consecutive clicks have occurred
/// within the threshold duration (e.g., 1 for single click, 2 for double click).
class ClickDetails {
  /// The number of consecutive clicks within the threshold period.
  ///
  /// Increments for each click that occurs within [ClickDetector.threshold]
  /// duration of the previous click. Resets to 1 when threshold is exceeded.
  final int clickCount;
  /// Creates click details with the specified click count.
  ///
  /// Parameters:
  /// - [clickCount]: Number of consecutive clicks (required)
  const ClickDetails({required this.clickCount});
}
```
