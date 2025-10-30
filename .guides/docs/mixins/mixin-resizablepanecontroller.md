---
title: "Mixin: ResizablePaneController"
description: "Mixin for controllers that manage resizable pane sizing."
---

```dart
/// Mixin for controllers that manage resizable pane sizing.
///
/// Provides methods to resize, collapse, and expand panels programmatically.
/// Implementations include [AbsoluteResizablePaneController] for fixed sizes
/// and [FlexibleResizablePaneController] for flexible/proportional sizes.
mixin ResizablePaneController implements ValueListenable<double> {
  /// Resizes the controller to the given [newSize] within the [paneSize] bounds.
  void resize(double newSize, double paneSize);
  /// Collapses the panel to its minimum size.
  void collapse();
  /// Expands the panel to its maximum or default size.
  void expand();
  /// Computes the actual size based on [paneSize] and optional constraints.
  double computeSize(double paneSize, {double? minSize, double? maxSize});
  /// Whether the panel is currently collapsed.
  bool get collapsed;
  /// Attempts to expand by [size] pixels in the specified [direction].
  ///
  /// Returns `true` if successful, `false` if expansion was blocked.
  bool tryExpandSize(double size, [PanelSibling direction = PanelSibling.both]);
  /// Attempts to expand the panel in the specified [direction].
  ///
  /// Returns `true` if successful, `false` if expansion was blocked.
  bool tryExpand([PanelSibling direction = PanelSibling.both]);
  /// Attempts to collapse the panel in the specified [direction].
  ///
  /// Returns `true` if successful, `false` if collapse was blocked.
  bool tryCollapse([PanelSibling direction = PanelSibling.both]);
}
```
