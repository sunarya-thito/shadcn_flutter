---
title: "Class: PhoneNumber"
description: "Reference for PhoneNumber"
---

```dart
class PhoneNumber {
  final Country country;
  final String number;
  const PhoneNumber(this.country, this.number);
  String get fullNumber;
  String? get value;
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
