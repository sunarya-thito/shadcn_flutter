---
title: "Class: AbsoluteResizablePaneController"
description: "Reference for AbsoluteResizablePaneController"
---

```dart
class AbsoluteResizablePaneController extends ChangeNotifier with ResizablePaneController {
  AbsoluteResizablePaneController(this._size, {bool collapsed = false});
  double get value;
  bool get collapsed;
  set size(double value);
  void collapse();
  void expand();
  void resize(double newSize, double paneSize, {double? minSize, double? maxSize});
  double computeSize(double paneSize, {double? minSize, double? maxSize});
}
```
