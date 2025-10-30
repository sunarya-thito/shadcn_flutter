---
title: "Class: DrawerOverlay"
description: "Widget that manages drawer overlay layers."
---

```dart
/// Widget that manages drawer overlay layers.
///
/// Provides a container for drawer overlays, managing their lifecycle and
/// hierarchical relationships. Supports nested drawers through layer data
/// propagation.
///
/// Example:
/// ```dart
/// DrawerOverlay(
///   child: MyAppContent(),
/// )
/// ```
class DrawerOverlay extends StatefulWidget {
  /// Child widget displayed under the overlay layer.
  final Widget child;
  /// Creates a drawer overlay.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content widget
  const DrawerOverlay({super.key, required this.child});
  State<DrawerOverlay> createState();
  /// Finds the drawer layer data from the widget tree.
  ///
  /// Searches up the widget tree for the nearest [DrawerLayerData].
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFind(BuildContext context, [bool root = false]);
  /// Finds the drawer layer data using messenger lookup.
  ///
  /// Similar to [maybeFind] but uses the messenger mechanism for lookup.
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFindMessenger(BuildContext context, [bool root = false]);
}
```
