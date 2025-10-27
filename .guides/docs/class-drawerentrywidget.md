---
title: "Class: DrawerEntryWidget"
description: "Reference for DrawerEntryWidget"
---

```dart
class DrawerEntryWidget<T> extends StatefulWidget {
  final DrawerBuilder builder;
  final Widget backdrop;
  final BackdropBuilder backdropBuilder;
  final BarrierBuilder barrierBuilder;
  final bool modal;
  final CapturedThemes? themes;
  final CapturedData? data;
  final Completer<T> completer;
  final OverlayPosition position;
  final int stackIndex;
  final int totalStack;
  final bool useSafeArea;
  final AnimationController? animationController;
  final bool autoOpen;
  const DrawerEntryWidget({super.key, required this.builder, required this.backdrop, required this.backdropBuilder, required this.barrierBuilder, required this.modal, required this.themes, required this.completer, required this.position, required this.stackIndex, required this.totalStack, required this.data, required this.useSafeArea, required this.animationController, required this.autoOpen});
  State<DrawerEntryWidget<T>> createState();
}
```
