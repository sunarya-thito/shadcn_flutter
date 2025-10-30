---
title: "Class: DrawerEntryWidget"
description: "Widget representing a single drawer entry in the overlay stack."
---

```dart
/// Widget representing a single drawer entry in the overlay stack.
///
/// Manages the lifecycle and rendering of an individual drawer overlay,
/// including its backdrop, barrier, and animated transitions.
class DrawerEntryWidget<T> extends StatefulWidget {
  /// Builder function for the drawer content.
  final DrawerBuilder builder;
  /// Backdrop widget (content behind the drawer).
  final Widget backdrop;
  /// Builder for transforming the backdrop.
  final BackdropBuilder backdropBuilder;
  /// Builder for the modal barrier.
  final BarrierBuilder barrierBuilder;
  /// Whether the drawer is modal (blocks interaction with backdrop).
  final bool modal;
  /// Captured theme data to apply within the drawer.
  final CapturedThemes? themes;
  /// Captured inherited data to propagate.
  final CapturedData? data;
  /// Completer for the drawer's result value.
  final Completer<T> completer;
  /// Position of the drawer (left, right, top, bottom, start, end).
  final OverlayPosition position;
  /// Index of this drawer in the stack.
  final int stackIndex;
  /// Total number of drawers in the stack.
  final int totalStack;
  /// Whether to apply safe area insets.
  final bool useSafeArea;
  /// Optional external animation controller.
  final AnimationController? animationController;
  /// Whether to automatically open on mount.
  final bool autoOpen;
  /// Creates a drawer entry widget.
  const DrawerEntryWidget({super.key, required this.builder, required this.backdrop, required this.backdropBuilder, required this.barrierBuilder, required this.modal, required this.themes, required this.completer, required this.position, required this.stackIndex, required this.totalStack, required this.data, required this.useSafeArea, required this.animationController, required this.autoOpen});
  State<DrawerEntryWidget<T>> createState();
}
```
