---
title: "Class: FlexibleResizablePaneController"
description: "Reference for FlexibleResizablePaneController"
---

```dart
class FlexibleResizablePaneController extends ChangeNotifier with ResizablePaneController {
  FlexibleResizablePaneController(this._flex, {bool collapsed = false});
  double get value;
  bool get collapsed;
  set flex(double value);
  void collapse();
  void expand();
  void resize(double newSize, double paneSize, {double? minSize, double? maxSize});
  double computeSize(double paneSize, {double? minSize, double? maxSize});
}
```
