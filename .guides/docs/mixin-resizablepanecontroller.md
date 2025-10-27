---
title: "Mixin: ResizablePaneController"
description: "Reference for ResizablePaneController"
---

```dart
mixin ResizablePaneController implements ValueListenable<double> {
  /// Resizes the controller by the given [delta] amount.
  void resize(double newSize, double paneSize);
  void collapse();
  void expand();
  double computeSize(double paneSize, {double? minSize, double? maxSize});
  bool get collapsed;
  bool tryExpandSize(double size, [PanelSibling direction = PanelSibling.both]);
  bool tryExpand([PanelSibling direction = PanelSibling.both]);
  bool tryCollapse([PanelSibling direction = PanelSibling.both]);
}
```
