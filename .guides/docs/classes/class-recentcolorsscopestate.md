---
title: "Class: RecentColorsScopeState"
description: "Reference for RecentColorsScopeState"
---

```dart
class RecentColorsScopeState extends State<RecentColorsScope> implements ColorHistoryStorage {
  int get capacity;
  void initState();
  List<Color> get recentColors;
  void addHistory(Color color);
  void dispose();
  void clear();
  void setHistory(List<Color> colors);
  Widget build(BuildContext context);
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
}
```
