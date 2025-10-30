---
title: "Class: WidgetTreeChangeDetector"
description: "A widget that detects changes in the widget tree."
---

```dart
/// A widget that detects changes in the widget tree.
class WidgetTreeChangeDetector extends StatefulWidget {
  /// The child widget to monitor.
  final Widget child;
  /// Callback invoked when the widget tree changes.
  final void Function() onWidgetTreeChange;
  /// Creates a [WidgetTreeChangeDetector].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Child widget.
  /// - [onWidgetTreeChange] (`VoidCallback`, required): Change callback.
  const WidgetTreeChangeDetector({super.key, required this.child, required this.onWidgetTreeChange});
  WidgetTreeChangeDetectorState createState();
}
```
