---
title: "Class: CallbackContextAction"
description: "Reference for CallbackContextAction"
---

```dart
class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  final OnContextInvokeCallback onInvoke;
  CallbackContextAction({required this.onInvoke});
  Object? invoke(T intent, [BuildContext? context]);
}
```
