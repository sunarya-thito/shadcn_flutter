---
title: "Class: RecentColorsScope"
description: "Reference for RecentColorsScope"
---

```dart
class RecentColorsScope extends StatefulWidget {
  final List<Color> initialRecentColors;
  final int maxRecentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  final Widget child;
  const RecentColorsScope({super.key, this.initialRecentColors = const [], this.maxRecentColors = 50, this.onRecentColorsChanged, required this.child});
  State<RecentColorsScope> createState();
}
```
