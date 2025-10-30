---
title: "Class: RecentColorsScopeState"
description: "State class for [RecentColorsScope] implementing color history storage."
---

```dart
/// State class for [RecentColorsScope] implementing color history storage.
///
/// Manages the list of recently used colors and provides storage functionality
/// for color history tracking.
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
