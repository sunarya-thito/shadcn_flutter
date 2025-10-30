---
title: "Class: KeyedTabChildWidget"
description: "A keyed tab child widget identified by a custom key value."
---

```dart
/// A keyed tab child widget identified by a custom key value.
///
/// Extends [TabChildWidget] with [KeyedTabChild] to support tab identification
/// via custom keys rather than positional indices. The key value determines
/// tab selection and tracking.
///
/// Type parameter [T] is the type of the key value.
class KeyedTabChildWidget<T> extends TabChildWidget with KeyedTabChild<T> {
  /// Creates a keyed tab child widget.
  ///
  /// Parameters:
  /// - [key]: The unique key value for this tab (required)
  /// - [child]: The widget to wrap (required)
  /// - [indexed]: Whether to use indexed positioning (optional)
  KeyedTabChildWidget({required T key, required super.child, super.indexed});
  ValueKey<T> get key;
  T get tabKey;
}
```
