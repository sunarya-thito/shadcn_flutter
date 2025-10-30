---
title: "Class: MenuData"
description: "Data container for individual menu item state."
---

```dart
/// Data container for individual menu item state.
///
/// Wraps a popover controller for each menu item, managing submenu
/// display and interaction state.
class MenuData {
  /// Controller for this item's submenu popover.
  final PopoverController popoverController;
  /// Creates menu item data.
  ///
  /// Parameters:
  /// - [popoverController] (PopoverController?): Optional controller, creates default if null
  MenuData({PopoverController? popoverController});
}
```
