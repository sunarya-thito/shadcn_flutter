---
title: "Class: DesktopPointerScrollEvent"
description: "A custom pointer scroll event for desktop platforms."
---

```dart
/// A custom pointer scroll event for desktop platforms.
///
/// Extends [PointerScrollEvent] with desktop-specific scroll event handling.
class DesktopPointerScrollEvent extends PointerScrollEvent {
  /// Creates a desktop pointer scroll event.
  const DesktopPointerScrollEvent({required super.position, required super.device, required super.embedderId, required super.kind, required super.timeStamp, required super.viewId, required super.scrollDelta});
}
```
