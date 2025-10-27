---
title: "Class: DrawerOverlayEntry"
description: "Reference for DrawerOverlayEntry"
---

```dart
class DrawerOverlayEntry<T> {
  final GlobalKey<DrawerEntryWidgetState<T>> key;
  final BackdropBuilder backdropBuilder;
  final DrawerBuilder builder;
  final bool modal;
  final BarrierBuilder barrierBuilder;
  final CapturedThemes? themes;
  final CapturedData? data;
  final Completer<T> completer;
  final OverlayPosition position;
  final bool barrierDismissible;
  final bool useSafeArea;
  final AnimationController? animationController;
  final bool autoOpen;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  DrawerOverlayEntry({required this.builder, required this.backdropBuilder, required this.modal, required this.barrierBuilder, required this.themes, required this.completer, required this.position, required this.data, required this.barrierDismissible, required this.useSafeArea, required this.animationController, required this.autoOpen, required this.constraints, required this.alignment});
}
```
