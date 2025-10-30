---
title: "Mixin: TabChild"
description: "Mixin for widgets that can be used as tab children."
---

```dart
/// Mixin for widgets that can be used as tab children.
///
/// Provides the interface for tab child widgets, indicating whether
/// the child participates in indexed tab selection.
mixin TabChild on Widget {
  /// Whether this tab child uses indexed positioning.
  ///
  /// When `true`, the tab's position in the list determines its index.
  /// When `false`, the tab may use a custom key for identification.
  bool get indexed;
}
```
