---
title: "Class: Popover"
description: "A comprehensive popover overlay system for displaying contextual content."
---

```dart
/// A comprehensive popover overlay system for displaying contextual content.
///
/// [Popover] provides a flexible foundation for creating overlay widgets that appear
/// relative to anchor elements. It handles positioning, layering, and lifecycle
/// management for temporary content displays such as dropdowns, menus, tooltips,
/// and dialogs. The system automatically manages positioning constraints and
/// viewport boundaries.
///
/// The popover system consists of:
/// - [Popover]: Individual popover instances with control methods
/// - [PopoverController]: Manager for multiple popovers with lifecycle control
/// - [PopoverLayout]: Positioning and constraint resolution
/// - Overlay integration for proper z-ordering and event handling
///
/// Key features:
/// - Intelligent positioning with automatic viewport constraint handling
/// - Multiple attachment points and alignment options
/// - Modal and non-modal display modes
/// - Animation and transition support
/// - Barrier dismissal with configurable behavior
/// - Follow-anchor behavior for responsive positioning
/// - Multi-popover management with close coordination
///
/// Positioning capabilities:
/// - Flexible alignment relative to anchor widgets
/// - Automatic inversion when space is constrained
/// - Custom offset adjustments
/// - Margin and padding controls
/// - Width and height constraint options
///
/// Example usage:
/// ```dart
/// final controller = PopoverController();
///
/// // Show a popover
/// final popover = await controller.show<String>(
///   context: context,
///   alignment: Alignment.bottomStart,
///   anchorAlignment: Alignment.topStart,
///   builder: (context) => PopoverMenu(
///     children: [
///       PopoverMenuItem(child: Text('Option 1')),
///       PopoverMenuItem(child: Text('Option 2')),
///     ],
///   ),
/// );
/// ```
class Popover {
  /// Global key for accessing the overlay handler state.
  final GlobalKey<OverlayHandlerStateMixin> key;
  /// The overlay completer that manages this popover's lifecycle.
  final OverlayCompleter entry;
  /// Closes this popover with optional immediate dismissal.
  ///
  /// If [immediate] is true, skips closing animations and removes the popover
  /// immediately. Otherwise, plays the closing animation before removal.
  ///
  /// Returns a Future that completes when the popover is fully dismissed.
  ///
  /// Parameters:
  /// - [immediate] (bool, default: false): Whether to skip closing animations
  ///
  /// Example:
  /// ```dart
  /// await popover.close(); // Animated close
  /// await popover.close(true); // Immediate close
  /// ```
  Future<void> close([bool immediate = false]);
  /// Schedules this popover to close after the current frame.
  ///
  /// This method queues the close operation for the next frame, allowing
  /// any current operations to complete before dismissing the popover.
  void closeLater();
  /// Immediately removes this popover from the overlay without animations.
  ///
  /// This method bypasses all closing animations and state management,
  /// directly removing the popover from the overlay stack. Use with caution
  /// as it may interrupt ongoing operations.
  void remove();
  /// Gets the current overlay handler state if the popover is mounted.
  ///
  /// Returns null if the popover has been disposed or is not currently
  /// in the widget tree. Useful for checking popover status and accessing
  /// advanced control methods.
  OverlayHandlerStateMixin? get currentState;
}
```
