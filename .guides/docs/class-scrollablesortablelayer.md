---
title: "Class: ScrollableSortableLayer"
description: "A sortable layer that provides automatic scrolling during drag operations."
---

```dart
/// A sortable layer that provides automatic scrolling during drag operations.
///
/// ScrollableSortableLayer extends the basic sortable functionality with automatic
/// scrolling when dragged items approach the edges of scrollable areas. This provides
/// a smooth user experience when dragging items in long lists or grids that extend
/// beyond the visible area.
///
/// The layer monitors drag positions and automatically scrolls the associated
/// scroll controller when the drag position comes within the configured threshold
/// of the scroll area edges. Scrolling speed is proportional to proximity to edges.
///
/// Features:
/// - Automatic scrolling when dragging near scroll area edges
/// - Configurable scroll threshold distance from edges
/// - Proportional scrolling speed based on proximity
/// - Optional overscroll support for scrolling beyond normal bounds
/// - Integrated with standard Flutter ScrollController
///
/// This layer should wrap scrollable widgets like ListView, GridView, or CustomScrollView
/// that contain sortable items. The scroll controller must be provided to enable
/// automatic scrolling functionality.
///
/// Example:
/// ```dart
/// ScrollController scrollController = ScrollController();
///
/// ScrollableSortableLayer(
///   controller: scrollController,
///   scrollThreshold: 80.0,
///   child: ListView.builder(
///     controller: scrollController,
///     itemBuilder: (context, index) => Sortable(...),
///   ),
/// )
/// ```
class ScrollableSortableLayer extends StatefulWidget {
  /// The child widget containing sortable items within a scrollable area.
  ///
  /// Type: `Widget`. Typically a scrollable widget like ListView or GridView
  /// that contains sortable items and uses the same controller.
  final Widget child;
  /// The scroll controller that manages the scrollable area.
  ///
  /// Type: `ScrollController`. Must be the same controller used by the scrollable
  /// widget in the child tree. This allows the layer to control scrolling during
  /// drag operations.
  final ScrollController controller;
  /// Distance from scroll area edges that triggers automatic scrolling.
  ///
  /// Type: `double`, default: `50.0`. When a dragged item comes within this
  /// distance of the top or bottom edge (for vertical scrolling), automatic
  /// scrolling begins. Larger values provide earlier scroll activation.
  final double scrollThreshold;
  /// Whether to allow scrolling beyond the normal scroll bounds.
  ///
  /// Type: `bool`, default: `false`. When true, drag operations can trigger
  /// scrolling past the normal scroll limits, similar to overscroll behavior.
  final bool overscroll;
  /// Creates a [ScrollableSortableLayer] with automatic scrolling support.
  ///
  /// Configures a sortable layer that provides automatic scrolling when dragged
  /// items approach the edges of the scrollable area.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The scrollable widget containing sortable items
  /// - [controller] (ScrollController, required): The scroll controller to manage
  /// - [scrollThreshold] (double, default: 50.0): Distance from edges for scroll trigger
  /// - [overscroll] (bool, default: false): Whether to allow overscroll behavior
  ///
  /// Example:
  /// ```dart
  /// final controller = ScrollController();
  ///
  /// ScrollableSortableLayer(
  ///   controller: controller,
  ///   scrollThreshold: 60.0,
  ///   overscroll: true,
  ///   child: ListView.builder(
  ///     controller: controller,
  ///     itemCount: items.length,
  ///     itemBuilder: (context, index) => Sortable<Item>(
  ///       data: SortableData(items[index]),
  ///       child: ItemWidget(items[index]),
  ///     ),
  ///   ),
  /// )
  /// ```
  const ScrollableSortableLayer({super.key, required this.child, required this.controller, this.scrollThreshold = 50, this.overscroll = false});
  State<ScrollableSortableLayer> createState();
}
```
