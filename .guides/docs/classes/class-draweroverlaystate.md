---
title: "Class: DrawerOverlayState"
description: "State class for [DrawerOverlay] managing drawer entry lifecycle."
---

```dart
/// State class for [DrawerOverlay] managing drawer entry lifecycle.
///
/// Manages the stack of active drawer overlays, handling their addition,
/// removal, and size computation. Maintains a backdrop key for managing
/// backdrop transformations.
class DrawerOverlayState extends State<DrawerOverlay> {
  /// Key for the backdrop widget to enable transformations.
  final GlobalKey backdropKey;
  /// Adds a drawer overlay entry to the list of active entries.
  ///
  /// Updates the widget state to include the new entry, triggering a rebuild
  /// to display the drawer overlay.
  ///
  /// Parameters:
  /// - [entry] (`DrawerOverlayEntry`, required): The drawer entry to add.
  ///
  /// Example:
  /// ```dart
  /// final entry = DrawerOverlayEntry(
  ///   builder: (context) => MyDrawerContent(),
  /// );
  /// drawerState.addEntry(entry);
  /// ```
  void addEntry(DrawerOverlayEntry entry);
  /// Computes the size of the drawer overlay area.
  ///
  /// Returns the size of the overlay's render box. Used for positioning
  /// and sizing drawer content.
  ///
  /// Throws [AssertionError] if overlay is not ready (no size available).
  ///
  /// Returns [Size] of the overlay area.
  Size computeSize();
  /// Removes a drawer entry from the overlay stack.
  ///
  /// Triggers a rebuild to update the overlay display after removing
  /// the specified entry.
  ///
  /// Parameters:
  /// - [entry] (DrawerOverlayEntry, required): Entry to remove
  void removeEntry(DrawerOverlayEntry entry);
  Widget build(BuildContext context);
}
```
