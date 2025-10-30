---
title: "Extension: DebugContainer"
description: "Extension that adds debug container wrapping functionality to widgets."
---

```dart
/// Extension that adds debug container wrapping functionality to widgets.
///
/// Provides a [debugContainer] method to wrap widgets with a colored container
/// for debugging layout issues. Only active when [kDebugContainerVisible] is true.
extension DebugContainer on Widget {
  /// Wraps this widget with a colored debug container.
  ///
  /// The container uses the specified [color] (defaults to red) to highlight
  /// the widget's bounds, making it easier to visualize layout during development.
  /// Returns the original widget unchanged if [kDebugContainerVisible] is false.
  Widget debugContainer([Color color = Colors.red]);
}
```
