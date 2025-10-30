---
title: "Class: Sortable"
description: "A draggable widget that supports drag-and-drop reordering with directional drop zones."
---

```dart
/// A draggable widget that supports drag-and-drop reordering with directional drop zones.
///
/// The Sortable widget enables drag-and-drop interactions with support for four directional
/// drop zones (top, left, right, bottom). It provides customizable callbacks for handling
/// drop events, visual feedback during dragging, and placeholder widgets for smooth
/// reordering animations.
///
/// Features:
/// - Four directional drop zones with individual accept/reject logic
/// - Customizable ghost and placeholder widgets during drag operations
/// - Automatic scroll support when wrapped in ScrollableSortableLayer
/// - Visual feedback with animated placeholders and fallback widgets
/// - Robust drag session management with proper cleanup
///
/// The widget must be wrapped in a [SortableLayer] to function properly. Use
/// [ScrollableSortableLayer] for automatic scrolling during drag operations.
///
/// Example:
/// ```dart
/// SortableLayer(
///   child: Column(
///     children: [
///       Sortable<String>(
///         data: SortableData('Item 1'),
///         onAcceptTop: (data) => reorderAbove(data.data),
///         onAcceptBottom: (data) => reorderBelow(data.data),
///         child: Card(child: Text('Item 1')),
///       ),
///       Sortable<String>(
///         data: SortableData('Item 2'),
///         onAcceptTop: (data) => reorderAbove(data.data),
///         onAcceptBottom: (data) => reorderBelow(data.data),
///         child: Card(child: Text('Item 2')),
///       ),
///     ],
///   ),
/// )
/// ```
class Sortable<T> extends StatefulWidget {
  /// Predicate to determine if data can be accepted when dropped above this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the top are not accepted.
  /// Called before [onAcceptTop] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptTop;
  /// Predicate to determine if data can be accepted when dropped to the left of this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the left are not accepted.
  /// Called before [onAcceptLeft] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptLeft;
  /// Predicate to determine if data can be accepted when dropped to the right of this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the right are not accepted.
  /// Called before [onAcceptRight] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptRight;
  /// Predicate to determine if data can be accepted when dropped below this widget.
  ///
  /// Type: `Predicate<SortableData<T>>?`. If null, drops from the bottom are not accepted.
  /// Called before [onAcceptBottom] to validate the drop operation.
  final Predicate<SortableData<T>>? canAcceptBottom;
  /// Callback invoked when data is successfully dropped above this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptTop]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptTop;
  /// Callback invoked when data is successfully dropped to the left of this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptLeft]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptLeft;
  /// Callback invoked when data is successfully dropped to the right of this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptRight]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptRight;
  /// Callback invoked when data is successfully dropped below this widget.
  ///
  /// Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped
  /// data and should handle the reordering logic. Only called after [canAcceptBottom]
  /// validation passes.
  final ValueChanged<SortableData<T>>? onAcceptBottom;
  /// Callback invoked when a drag operation starts on this widget.
  ///
  /// Type: `VoidCallback?`. Called immediately when the user begins dragging
  /// this sortable item. Useful for providing haptic feedback or updating UI state.
  final VoidCallback? onDragStart;
  /// Callback invoked when a drag operation ends successfully.
  ///
  /// Type: `VoidCallback?`. Called when the drag completes with a successful drop.
  /// This is called before the appropriate accept callback.
  final VoidCallback? onDragEnd;
  /// Callback invoked when a drag operation is cancelled.
  ///
  /// Type: `VoidCallback?`. Called when the drag is cancelled without a successful
  /// drop, such as when the user releases outside valid drop zones.
  final VoidCallback? onDragCancel;
  /// The main child widget that will be made sortable.
  ///
  /// Type: `Widget`. This widget is displayed normally and becomes draggable
  /// when drag interactions are initiated.
  final Widget child;
  /// The data associated with this sortable item.
  ///
  /// Type: `SortableData<T>`. Contains the actual data being sorted and provides
  /// identity for the drag-and-drop operations.
  final SortableData<T> data;
  /// Widget displayed in drop zones when this item is being dragged over them.
  ///
  /// Type: `Widget?`. If null, uses [SizedBox.shrink]. This creates visual
  /// space in potential drop locations, providing clear feedback about where
  /// the item will be placed if dropped.
  final Widget? placeholder;
  /// Widget displayed while dragging instead of the original child.
  ///
  /// Type: `Widget?`. If null, uses [child]. Typically a semi-transparent
  /// or styled version of the child to provide visual feedback during dragging.
  final Widget? ghost;
  /// Widget displayed in place of the child while it's being dragged.
  ///
  /// Type: `Widget?`. If null, the original child becomes invisible but maintains
  /// its space. Used to show an alternative representation at the original location.
  final Widget? fallback;
  /// Widget displayed when the item is a candidate for dropping.
  ///
  /// Type: `Widget?`. Shows alternative styling when the dragged item hovers
  /// over this sortable as a potential drop target.
  final Widget? candidateFallback;
  /// Whether drag interactions are enabled for this sortable.
  ///
  /// Type: `bool`, default: `true`. When false, the widget cannot be dragged
  /// and will not respond to drag gestures.
  final bool enabled;
  /// How hit-testing behaves for drag gesture recognition.
  ///
  /// Type: `HitTestBehavior`, default: `HitTestBehavior.deferToChild`.
  /// Controls how the gesture detector participates in hit testing.
  final HitTestBehavior behavior;
  /// Callback invoked when a drop operation fails.
  ///
  /// Type: `VoidCallback?`. Called when the user drops outside of any valid
  /// drop zones or when drop validation fails.
  final VoidCallback? onDropFailed;
  /// Creates a [Sortable] widget with drag-and-drop functionality.
  ///
  /// Configures a widget that can be dragged and accepts drops from other
  /// sortable items. The widget supports directional drop zones and provides
  /// extensive customization for drag interactions and visual feedback.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [data] (`SortableData<T>`, required): Data associated with this sortable item
  /// - [child] (Widget, required): The main widget to make sortable
  /// - [enabled] (bool, default: true): Whether drag interactions are enabled
  /// - [canAcceptTop] (`Predicate<SortableData<T>>?`, optional): Validation for top drops
  /// - [canAcceptLeft] (`Predicate<SortableData<T>>?`, optional): Validation for left drops
  /// - [canAcceptRight] (`Predicate<SortableData<T>>?`, optional): Validation for right drops
  /// - [canAcceptBottom] (`Predicate<SortableData<T>>?`, optional): Validation for bottom drops
  /// - [onAcceptTop] (`ValueChanged<SortableData<T>>?`, optional): Handler for top drops
  /// - [onAcceptLeft] (`ValueChanged<SortableData<T>>?`, optional): Handler for left drops
  /// - [onAcceptRight] (`ValueChanged<SortableData<T>>?`, optional): Handler for right drops
  /// - [onAcceptBottom] (`ValueChanged<SortableData<T>>?`, optional): Handler for bottom drops
  /// - [placeholder] (Widget?, default: SizedBox()): Widget shown in drop zones
  /// - [ghost] (Widget?, optional): Widget displayed while dragging
  /// - [fallback] (Widget?, optional): Widget shown at original position during drag
  /// - [candidateFallback] (Widget?, optional): Widget shown when item is drop candidate
  /// - [onDragStart] (VoidCallback?, optional): Called when drag starts
  /// - [onDragEnd] (VoidCallback?, optional): Called when drag ends successfully
  /// - [onDragCancel] (VoidCallback?, optional): Called when drag is cancelled
  /// - [behavior] (HitTestBehavior, default: HitTestBehavior.deferToChild): Hit test behavior
  /// - [onDropFailed] (VoidCallback?, optional): Called when drop fails
  ///
  /// Example:
  /// ```dart
  /// Sortable<String>(
  ///   data: SortableData('item_1'),
  ///   onAcceptTop: (data) => moveAbove(data.data),
  ///   onAcceptBottom: (data) => moveBelow(data.data),
  ///   placeholder: Container(height: 2, color: Colors.blue),
  ///   child: ListTile(title: Text('Draggable Item')),
  /// )
  /// ```
  const Sortable({super.key, this.enabled = true, required this.data, this.canAcceptTop, this.canAcceptLeft, this.canAcceptRight, this.canAcceptBottom, this.onAcceptTop, this.onAcceptLeft, this.onAcceptRight, this.onAcceptBottom, this.placeholder = const SizedBox(), this.ghost, this.fallback, this.candidateFallback, this.onDragStart, this.onDragEnd, this.onDragCancel, this.behavior = HitTestBehavior.deferToChild, this.onDropFailed, required this.child});
  State<Sortable<T>> createState();
}
```
