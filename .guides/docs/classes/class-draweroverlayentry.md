---
title: "Class: DrawerOverlayEntry"
description: "Data class representing a drawer overlay entry in the stack."
---

```dart
/// Data class representing a drawer overlay entry in the stack.
///
/// Encapsulates all configuration and state needed to render a single
/// drawer overlay, including builders, animation, theming, and positioning.
class DrawerOverlayEntry<T> {
  /// Key for accessing the drawer entry widget state.
  final GlobalKey<DrawerEntryWidgetState<T>> key;
  /// Builder for backdrop transformations.
  final BackdropBuilder backdropBuilder;
  /// Builder for drawer content.
  final DrawerBuilder builder;
  /// Whether the drawer is modal.
  final bool modal;
  /// Builder for the modal barrier.
  final BarrierBuilder barrierBuilder;
  /// Captured theme data.
  final CapturedThemes? themes;
  /// Captured inherited data.
  final CapturedData? data;
  /// Completer for the drawer result.
  final Completer<T> completer;
  /// Position of the drawer.
  final OverlayPosition position;
  /// Whether tapping the barrier dismisses the drawer.
  final bool barrierDismissible;
  /// Whether to apply safe area insets.
  final bool useSafeArea;
  /// Optional external animation controller.
  final AnimationController? animationController;
  /// Whether to automatically open on mount.
  final bool autoOpen;
  /// Size constraints for the drawer.
  final BoxConstraints? constraints;
  /// Alignment of the drawer content.
  final AlignmentGeometry? alignment;
  /// Creates a drawer overlay entry.
  DrawerOverlayEntry({required this.builder, required this.backdropBuilder, required this.modal, required this.barrierBuilder, required this.themes, required this.completer, required this.position, required this.data, required this.barrierDismissible, required this.useSafeArea, required this.animationController, required this.autoOpen, required this.constraints, required this.alignment});
}
```
