---
title: "Class: IconThemeProperties"
description: "Reference for IconThemeProperties"
---

```dart
class IconThemeProperties {
  final IconThemeData x4Small;
  final IconThemeData x3Small;
  final IconThemeData x2Small;
  final IconThemeData xSmall;
  final IconThemeData small;
  final IconThemeData medium;
  final IconThemeData large;
  final IconThemeData xLarge;
  final IconThemeData x2Large;
  final IconThemeData x3Large;
  final IconThemeData x4Large;
  const IconThemeProperties({this.x4Small = const IconThemeData(size: 6), this.x3Small = const IconThemeData(size: 8), this.x2Small = const IconThemeData(size: 10), this.xSmall = const IconThemeData(size: 12), this.small = const IconThemeData(size: 16), this.medium = const IconThemeData(size: 20), this.large = const IconThemeData(size: 24), this.xLarge = const IconThemeData(size: 32), this.x2Large = const IconThemeData(size: 40), this.x3Large = const IconThemeData(size: 48), this.x4Large = const IconThemeData(size: 56)});
  IconThemeProperties copyWith({ValueGetter<IconThemeData>? x4Small, ValueGetter<IconThemeData>? x3Small, ValueGetter<IconThemeData>? x2Small, ValueGetter<IconThemeData>? xSmall, ValueGetter<IconThemeData>? small, ValueGetter<IconThemeData>? medium, ValueGetter<IconThemeData>? large, ValueGetter<IconThemeData>? xLarge, ValueGetter<IconThemeData>? x2Large, ValueGetter<IconThemeData>? x3Large, ValueGetter<IconThemeData>? x4Large});
  IconThemeProperties scale(double factor);
  static IconThemeProperties lerp(IconThemeProperties a, IconThemeProperties b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
