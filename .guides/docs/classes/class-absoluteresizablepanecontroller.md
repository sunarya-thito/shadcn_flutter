---
title: "Class: AbsoluteResizablePaneController"
description: "Controller for resizable panes with absolute (fixed) sizing."
---

```dart
/// Controller for resizable panes with absolute (fixed) sizing.
///
/// Manages a panel with a specific pixel size that can be adjusted through
/// dragging or programmatic control. Size is maintained as an absolute value.
///
/// Example:
/// ```dart
/// final controller = AbsoluteResizablePaneController(200);
/// 
/// ResizablePane(
///   controller: controller,
///   child: Container(color: Colors.blue),
/// )
/// ```
class AbsoluteResizablePaneController extends ChangeNotifier with ResizablePaneController {
  /// Creates an [AbsoluteResizablePaneController].
  ///
  /// Parameters:
  /// - [_size] (`double`, required): Initial absolute size in pixels.
  /// - [collapsed] (`bool`, default: `false`): Initial collapsed state.
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
