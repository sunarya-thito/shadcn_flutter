---
title: "Class: ToastEntryLayout"
description: "Internal widget for managing toast entry layout and animations."
---

```dart
/// Internal widget for managing toast entry layout and animations.
///
/// Handles the positioning, transitions, and lifecycle of individual toast
/// notifications. Manages expansion/collapse animations, entry/exit transitions,
/// and stacking behavior for multiple toasts.
///
/// This is an internal implementation class used by the toast system and
/// should not be used directly in application code.
class ToastEntryLayout extends StatefulWidget {
  /// The toast entry data containing the notification content.
  final ToastEntry entry;
  /// Whether the toast is in expanded state.
  final bool expanded;
  /// Whether the toast is currently visible.
  final bool visible;
  /// Whether the toast can be dismissed by user interaction.
  final bool dismissible;
  /// Alignment used before the current animation.
  final AlignmentGeometry previousAlignment;
  /// Animation curve for transitions.
  final Curve curve;
  /// Duration of transition animations.
  final Duration duration;
  /// Captured theme data to apply to the toast content.
  final CapturedThemes? themes;
  /// Captured inherited data to apply to the toast content.
  final CapturedData? data;
  /// Notifies when the toast is closing.
  final ValueListenable<bool> closing;
  /// Callback invoked when the toast has completely closed.
  final VoidCallback onClosed;
  /// Offset applied when toast is in collapsed state.
  final Offset collapsedOffset;
  /// Scale factor applied when toast is in collapsed state.
  final double collapsedScale;
  /// Curve used for expansion animations.
  final Curve expandingCurve;
  /// Duration of expansion animations.
  final Duration expandingDuration;
  /// Opacity when toast is collapsed.
  final double collapsedOpacity;
  /// Initial opacity when toast enters.
  final double entryOpacity;
  /// The toast content widget.
  final Widget child;
  /// Initial offset when toast enters.
  final Offset entryOffset;
  /// Alignment of the toast entry.
  final AlignmentGeometry entryAlignment;
  /// Spacing between stacked toasts.
  final double spacing;
  /// Visual index in the toast stack.
  final int index;
  /// Actual index in the internal list.
  final int actualIndex;
  /// Callback invoked when toast starts closing.
  final VoidCallback? onClosing;
  /// Creates a [ToastEntryLayout].
  ///
  /// Most parameters control animation and positioning behavior. This is
  /// an internal widget used by the toast system.
  const ToastEntryLayout({super.key, required this.entry, required this.expanded, this.visible = true, this.dismissible = true, this.previousAlignment = Alignment.center, this.curve = Curves.easeInOut, this.duration = kDefaultDuration, required this.themes, required this.data, required this.closing, required this.onClosed, required this.collapsedOffset, required this.collapsedScale, this.expandingCurve = Curves.easeInOut, this.expandingDuration = kDefaultDuration, this.collapsedOpacity = 0.8, this.entryOpacity = 0.0, required this.entryOffset, required this.child, required this.entryAlignment, required this.spacing, required this.index, required this.actualIndex, required this.onClosing});
  State<ToastEntryLayout> createState();
}
```
