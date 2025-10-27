---
title: "Class: ContextCallbackAction"
description: "Reference for ContextCallbackAction"
---

```dart
class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  final OnContextedCallback<T> onInvoke;
  ContextCallbackAction({required this.onInvoke});
  Object? invoke(T intent, [BuildContext? context]);
}
```
