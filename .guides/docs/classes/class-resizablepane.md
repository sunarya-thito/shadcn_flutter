---
title: "Class: ResizablePane"
description: "A resizable panel that can be part of a [ResizablePanel] layout."
---

```dart
/// A resizable panel that can be part of a [ResizablePanel] layout.
///
/// Represents a single pane in a resizable layout that can be resized by
/// dragging handles between panes. Supports absolute sizing, flex-based sizing,
/// and external controller management.
///
/// Three constructor variants:
/// - Default: Fixed absolute size in pixels
/// - [ResizablePane.flex]: Proportional flex-based sizing
/// - [ResizablePane.controlled]: Externally controlled via [ResizablePaneController]
///
/// Example:
/// ```dart
/// ResizablePanel(
///   children: [
///     ResizablePane(
///       initialSize: 200,
///       minSize: 100,
///       child: Container(color: Colors.blue),
///     ),
///     ResizablePane.flex(
///       initialFlex: 2,
///       child: Container(color: Colors.red),
///     ),
///   ],
/// )
/// ```
class ResizablePane extends StatefulWidget {
  /// Optional external controller for managing this pane's size.
  final ResizablePaneController? controller;
  /// Initial size in pixels (for absolute sizing).
  final double? initialSize;
  /// Initial flex factor (for flexible sizing).
  final double? initialFlex;
  /// Minimum size constraint in pixels.
  final double? minSize;
  /// Maximum size constraint in pixels.
  final double? maxSize;
  /// Size when collapsed (defaults to 0).
  final double? collapsedSize;
  /// Child widget to display in this pane.
  final Widget child;
  /// Callback when resize drag starts.
  final ValueChanged<double>? onSizeChangeStart;
  /// Callback during resize drag.
  final ValueChanged<double>? onSizeChange;
  /// Callback when resize drag ends.
  final ValueChanged<double>? onSizeChangeEnd;
  /// Callback when resize drag is cancelled.
  final ValueChanged<double>? onSizeChangeCancel;
  /// Whether the pane starts collapsed.
  final bool? initialCollapsed;
  /// Creates a [ResizablePane] with absolute pixel sizing.
  const ResizablePane({super.key, required double this.initialSize, this.minSize, this.maxSize, this.collapsedSize, required this.child, this.onSizeChangeStart, this.onSizeChange, this.onSizeChangeEnd, this.onSizeChangeCancel, bool this.initialCollapsed = false});
  /// Creates a [ResizablePane] with flex-based proportional sizing.
  const ResizablePane.flex({super.key, double this.initialFlex = 1, this.minSize, this.maxSize, this.collapsedSize, required this.child, this.onSizeChangeStart, this.onSizeChange, this.onSizeChangeEnd, this.onSizeChangeCancel, bool this.initialCollapsed = false});
  /// Creates a [ResizablePane] controlled by an external [controller].
  const ResizablePane.controlled({super.key, required ResizablePaneController this.controller, this.minSize, this.maxSize, this.collapsedSize, required this.child, this.onSizeChangeStart, this.onSizeChange, this.onSizeChangeEnd, this.onSizeChangeCancel});
  State<ResizablePane> createState();
}
```
