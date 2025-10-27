---
title: "Class: BiDirectionalConvert"
description: "Reference for BiDirectionalConvert"
---

```dart
class BiDirectionalConvert<A, B> {
  final Convert<A, B> aToB;
  final Convert<B, A> bToA;
  const BiDirectionalConvert(this.aToB, this.bToA);
  B convertA(A value);
  A convertB(B value);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
