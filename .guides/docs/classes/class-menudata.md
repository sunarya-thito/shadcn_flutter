---
title: "Class: MenuData"
description: "Data container for individual menu item state.   Wraps a popover controller for each menu item, managing submenu  display and interaction state."
---

```dart
/// Data container for individual menu item state.
///
/// Wraps a popover controller for each menu item, managing submenu
/// display and interaction state.
class MenuData {
  /// Controller for this item's submenu popover.
  final OverlayController overlayController;
  /// Creates menu item data.
  ///
  /// Parameters:
  /// - [overlayController] (OverlayController?): Optional controller, creates default if null
  MenuData({OverlayController? overlayController});
}
```
