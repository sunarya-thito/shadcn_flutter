---
title: "Class: SeparatedIterator"
description: "Reference for SeparatedIterator"
---

```dart
class SeparatedIterator<T> implements Iterator<T> {
  SeparatedIterator(this._iterator, this._separator);
  T get current;
  bool moveNext();
}
```
