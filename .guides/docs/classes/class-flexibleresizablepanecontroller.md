---
title: "Class: FlexibleResizablePaneController"
description: "Controller for resizable panes with flexible (proportional) sizing."
---

```dart
/// Controller for resizable panes with flexible (proportional) sizing.
///
/// Manages a panel whose size is specified as a flex factor relative to
/// the total available space. Similar to Flutter's [Flexible] widget concept.
///
/// Example:
/// ```dart
/// final controller = FlexibleResizablePaneController(1.0);
/// 
/// ResizablePane(
///   controller: controller,
///   child: Container(color: Colors.red),
/// )
/// ```
class FlexibleResizablePaneController extends ChangeNotifier with ResizablePaneController {
  /// Creates a [FlexibleResizablePaneController].
  ///
  /// Parameters:
  /// - [_flex] (`double`, required): Initial flex factor.
  /// - [collapsed] (`bool`, default: `false`): Initial collapsed state.
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
