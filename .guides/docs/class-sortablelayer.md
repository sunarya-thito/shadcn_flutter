---
title: "Class: SortableLayer"
description: "A layer widget that manages drag-and-drop sessions for sortable widgets."
---

```dart
/// A layer widget that manages drag-and-drop sessions for sortable widgets.
///
/// SortableLayer is a required wrapper that coordinates drag-and-drop operations
/// between multiple sortable widgets. It provides the infrastructure for managing
/// drag sessions, rendering ghost elements during dragging, and handling drop
/// animations.
///
/// The layer maintains the drag state and provides a rendering context for ghost
/// widgets that follow the cursor during drag operations. It also manages drop
/// animations and cleanup when drag operations complete.
///
/// Features:
/// - Centralized drag session management across multiple sortable widgets
/// - Ghost widget rendering with cursor following during drag operations
/// - Configurable drop animations with custom duration and curves
/// - Boundary locking to constrain drag operations within the layer bounds
/// - Automatic cleanup and state management for drag sessions
///
/// All sortable widgets must be descendants of a SortableLayer to function properly.
/// The layer should be placed at a level that encompasses all related sortable widgets.
///
/// Example:
/// ```dart
/// SortableLayer(
///   lock: true, // Constrain dragging within bounds
///   dropDuration: Duration(milliseconds: 300),
///   dropCurve: Curves.easeOut,
///   child: Column(
///     children: [
///       Sortable(...),
///       Sortable(...),
///       Sortable(...),
///     ],
///   ),
/// )
/// ```
class SortableLayer extends StatefulWidget {
  /// The child widget tree containing sortable widgets.
  ///
  /// Type: `Widget`. All sortable widgets must be descendants of this child
  /// tree to function properly with the layer.
  final Widget child;
  /// Whether to lock dragging within the layer's bounds.
  ///
  /// Type: `bool`, default: `false`. When true, dragged items cannot be moved
  /// outside the layer's visual bounds, providing spatial constraints.
  final bool lock;
  /// The clipping behavior for the layer.
  ///
  /// Type: `Clip?`. Controls how content is clipped. If null, uses Clip.hardEdge
  /// when [lock] is true, otherwise Clip.none.
  final Clip? clipBehavior;
  /// Duration for drop animations when drag operations complete.
  ///
  /// Type: `Duration?`. If null, uses the default duration. Set to Duration.zero
  /// to disable drop animations entirely.
  final Duration? dropDuration;
  /// Animation curve for drop transitions.
  ///
  /// Type: `Curve?`. If null, uses Curves.easeInOut. Controls the easing
  /// behavior of items animating to their final drop position.
  final Curve? dropCurve;
  /// Creates a [SortableLayer] to manage drag-and-drop operations.
  ///
  /// Configures the layer that coordinates drag sessions between sortable widgets
  /// and provides the rendering context for drag operations.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The widget tree containing sortable widgets
  /// - [lock] (bool, default: false): Whether to constrain dragging within bounds
  /// - [clipBehavior] (Clip?, optional): How to clip the layer content
  /// - [dropDuration] (Duration?, optional): Duration for drop animations
  /// - [dropCurve] (Curve?, optional): Curve for drop animation easing
  ///
  /// Example:
  /// ```dart
  /// SortableLayer(
  ///   lock: true,
  ///   dropDuration: Duration(milliseconds: 250),
  ///   dropCurve: Curves.easeInOutCubic,
  ///   child: ListView(
  ///     children: sortableItems.map((item) => Sortable(...)).toList(),
  ///   ),
  /// )
  /// ```
  const SortableLayer({super.key, this.lock = false, this.clipBehavior, this.dropDuration, this.dropCurve, required this.child});
  State<SortableLayer> createState();
  /// Ensures a pending drop operation is completed and dismisses it.
  ///
  /// Finds the sortable layer in the widget tree and ensures that any pending
  /// drop operation for the specified data is completed and dismissed. This is
  /// useful for programmatically finalizing drop operations.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to find the layer from
  /// - [data] (Object): The data associated with the drop operation to dismiss
  ///
  /// Example:
  /// ```dart
  /// // After programmatic reordering
  /// SortableLayer.ensureAndDismissDrop(context, sortableData);
  /// ```
  static void ensureAndDismissDrop(BuildContext context, Object data);
  /// Dismisses any pending drop operations.
  ///
  /// Finds the sortable layer in the widget tree and dismisses any currently
  /// pending drop operations. This clears any visual feedback or animations
  /// related to incomplete drops.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to find the layer from
  ///
  /// Example:
  /// ```dart
  /// // Clear any pending drops when navigating away
  /// SortableLayer.dismissDrop(context);
  /// ```
  static void dismissDrop(BuildContext context);
}
```
