---
title: "Class: ColorHistoryStorage"
description: "Reference for ColorHistoryStorage"
---

```dart
abstract class ColorHistoryStorage implements Listenable {
  void addHistory(Color color);
  void setHistory(List<Color> colors);
  void clear();
  int get capacity;
  List<Color> get recentColors;
  static ColorHistoryStorage of(BuildContext context);
}
```
