---
title: "Class: SizeUnitLocale"
description: "Reference for SizeUnitLocale"
---

```dart
class SizeUnitLocale {
  final int base;
  final List<String> units;
  final String separator;
  const SizeUnitLocale(this.base, this.units, {this.separator = ','});
  static const SizeUnitLocale fileBytes = _fileByteUnits;
  static const SizeUnitLocale fileBits = _fileBitUnits;
  String getUnit(int value);
}
```
