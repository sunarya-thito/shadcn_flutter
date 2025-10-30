---
title: "Class: CallbackContextAction"
description: "A context action that executes a callback."
---

```dart
/// A context action that executes a callback.
class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  /// Callback to execute when action is invoked.
  final OnContextInvokeCallback onInvoke;
  /// Creates a [CallbackContextAction] with the given callback.
  /// Parameters:
  /// - [onInvoke] (OnContextInvokeCallback, required): Callback to execute
  CallbackContextAction({required this.onInvoke});
  Object? invoke(T intent, [BuildContext? context]);
}
```
