---
title: "Class: ToastEntry"
description: "Reference for ToastEntry"
---

```dart
class ToastEntry {
  final ToastBuilder builder;
  final ToastLocation location;
  final bool dismissible;
  final Curve curve;
  final Duration duration;
  final CapturedThemes? themes;
  final CapturedData? data;
  final VoidCallback? onClosed;
  final Duration? showDuration;
  ToastEntry({required this.builder, required this.location, this.dismissible = true, this.curve = Curves.easeInOut, this.duration = kDefaultDuration, required this.themes, required this.data, this.onClosed, this.showDuration = const Duration(seconds: 5)});
}
```
