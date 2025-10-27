---
title: "Class: ScaffoldBoxConstraints"
description: "Reference for ScaffoldBoxConstraints"
---

```dart
class ScaffoldBoxConstraints extends BoxConstraints {
  final double headerHeight;
  final double footerHeight;
  const ScaffoldBoxConstraints({required this.headerHeight, required this.footerHeight, super.minWidth, super.maxWidth, super.minHeight, super.maxHeight});
  factory ScaffoldBoxConstraints.fromBoxConstraints({required BoxConstraints constraints, required double headerHeight, required double footerHeight});
  ScaffoldBoxConstraints copyWith({double? headerHeight, double? footerHeight, double? minWidth, double? maxWidth, double? minHeight, double? maxHeight});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
