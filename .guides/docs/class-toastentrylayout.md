---
title: "Class: ToastEntryLayout"
description: "Reference for ToastEntryLayout"
---

```dart
class ToastEntryLayout extends StatefulWidget {
  final ToastEntry entry;
  final bool expanded;
  final bool visible;
  final bool dismissible;
  final AlignmentGeometry previousAlignment;
  final Curve curve;
  final Duration duration;
  final CapturedThemes? themes;
  final CapturedData? data;
  final ValueListenable<bool> closing;
  final VoidCallback onClosed;
  final Offset collapsedOffset;
  final double collapsedScale;
  final Curve expandingCurve;
  final Duration expandingDuration;
  final double collapsedOpacity;
  final double entryOpacity;
  final Widget child;
  final Offset entryOffset;
  final AlignmentGeometry entryAlignment;
  final double spacing;
  final int index;
  final int actualIndex;
  final VoidCallback? onClosing;
  const ToastEntryLayout({super.key, required this.entry, required this.expanded, this.visible = true, this.dismissible = true, this.previousAlignment = Alignment.center, this.curve = Curves.easeInOut, this.duration = kDefaultDuration, required this.themes, required this.data, required this.closing, required this.onClosed, required this.collapsedOffset, required this.collapsedScale, this.expandingCurve = Curves.easeInOut, this.expandingDuration = kDefaultDuration, this.collapsedOpacity = 0.8, this.entryOpacity = 0.0, required this.entryOffset, required this.child, required this.entryAlignment, required this.spacing, required this.index, required this.actualIndex, required this.onClosing});
  State<ToastEntryLayout> createState();
}
```
