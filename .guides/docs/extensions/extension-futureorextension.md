---
title: "Extension: FutureOrExtension"
description: "Reference for extension"
---

```dart
extension FutureOrExtension<T> on FutureOr<T> {
  FutureOr<R> map<R>(R Function(T value) transform);
  FutureOr<R> flatMap<R>(FutureOr<R> Function(T value) transform);
  FutureOr<R> then<R>(FutureOr<R> Function(T value) transform);
}
```
