---
title: "Class: ContextCallbackAction"
description: "A context action that executes a callback with context."
---

```dart
/// A context action that executes a callback with context.
class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  /// The callback to execute when the action is invoked.
  final OnContextedCallback<T> onInvoke;
  /// Creates a [ContextCallbackAction].
  ///
  /// Parameters:
  /// - [onInvoke] (`OnContextedCallback<T>`, required): Callback function.
  ContextCallbackAction({required this.onInvoke});
  Object? invoke(T intent, [BuildContext? context]);
}
```
