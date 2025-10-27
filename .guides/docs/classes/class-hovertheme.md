---
title: "Class: HoverTheme"
description: "Reference for HoverTheme"
---

```dart
class HoverTheme {
  final Duration? debounceDuration;
  final HitTestBehavior? hitTestBehavior;
  final Duration? waitDuration;
  final Duration? minDuration;
  final Duration? showDuration;
  const HoverTheme({this.debounceDuration, this.hitTestBehavior, this.waitDuration, this.minDuration, this.showDuration});
  HoverTheme copyWith({ValueGetter<Duration?>? debounceDuration, ValueGetter<HitTestBehavior?>? hitTestBehavior, ValueGetter<Duration?>? waitDuration, ValueGetter<Duration?>? minDuration, ValueGetter<Duration?>? showDuration});
  bool operator ==(Object other);
  int get hashCode;
}
```
