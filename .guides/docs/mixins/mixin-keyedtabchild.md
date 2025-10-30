---
title: "Mixin: KeyedTabChild"
description: "Mixin for keyed tab children that use custom keys for identification."
---

```dart
/// Mixin for keyed tab children that use custom keys for identification.
///
/// Extends [TabChild] to support tab children identified by custom keys
/// of type [T] rather than positional indices.
///
/// Type parameter [T] is the type of the key used to identify this tab.
mixin KeyedTabChild<T> on TabChild {
  /// The unique key identifying this tab.
  ///
  /// Used instead of positional index for tab selection and tracking.
  T get tabKey;
}
```
