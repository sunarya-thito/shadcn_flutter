---
title: "Class: SortableDragHandle"
description: "A dedicated drag handle for initiating sortable drag operations."
---

```dart
/// A dedicated drag handle for initiating sortable drag operations.
///
/// SortableDragHandle provides a specific area within a sortable widget that
/// can be used to initiate drag operations. This is useful when you want to
/// restrict drag initiation to a specific handle area rather than the entire
/// sortable widget.
///
/// The handle automatically detects its parent Sortable widget and delegates
/// drag operations to it. It provides visual feedback with appropriate mouse
/// cursors and can be enabled/disabled independently.
///
/// Features:
/// - Dedicated drag initiation area within sortable widgets
/// - Automatic mouse cursor management (grab/grabbing states)
/// - Independent enable/disable control
/// - Automatic cleanup and lifecycle management
///
/// Example:
/// ```dart
/// Sortable<String>(
///   data: SortableData('item'),
///   child: Row(
///     children: [
///       SortableDragHandle(
///         child: Icon(Icons.drag_handle),
///       ),
///       Expanded(child: Text('Drag me by the handle')),
///     ],
///   ),
/// )
/// ```
class SortableDragHandle extends StatefulWidget {
  /// The child widget that serves as the drag handle.
  ///
  /// Type: `Widget`. This widget defines the visual appearance of the drag handle
  /// and responds to drag gestures. Commonly an icon like Icons.drag_handle.
  final Widget child;
  /// Whether the drag handle is enabled for drag operations.
  ///
  /// Type: `bool`, default: `true`. When false, the handle will not respond to
  /// drag gestures and shows the default cursor instead of grab cursors.
  final bool enabled;
  /// How hit-testing behaves for this drag handle.
  ///
  /// Type: `HitTestBehavior?`. Controls how the gesture detector and mouse region
  /// participate in hit testing. If null, uses default behavior.
  final HitTestBehavior? behavior;
  /// The mouse cursor displayed when hovering over the drag handle.
  ///
  /// Type: `MouseCursor?`. If null, uses SystemMouseCursors.grab when enabled,
  /// or MouseCursor.defer when disabled. Changes to SystemMouseCursors.grabbing
  /// during active drag operations.
  final MouseCursor? cursor;
  /// Creates a [SortableDragHandle] for initiating drag operations.
  ///
  /// Configures a dedicated drag handle that can initiate drag operations for
  /// its parent sortable widget. The handle provides visual feedback and can
  /// be independently enabled or disabled.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [child] (Widget, required): The widget that serves as the drag handle
  /// - [enabled] (bool, default: true): Whether drag operations are enabled
  /// - [behavior] (HitTestBehavior?, optional): Hit test behavior for gestures
  /// - [cursor] (MouseCursor?, optional): Mouse cursor when hovering
  ///
  /// Example:
  /// ```dart
  /// SortableDragHandle(
  ///   enabled: isDragEnabled,
  ///   cursor: SystemMouseCursors.move,
  ///   child: Container(
  ///     padding: EdgeInsets.all(8),
  ///     child: Icon(Icons.drag_indicator),
  ///   ),
  /// )
  /// ```
  const SortableDragHandle({super.key, required this.child, this.enabled = true, this.behavior, this.cursor});
  State<SortableDragHandle> createState();
}
```
