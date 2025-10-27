---
title: "Class: ShadcnLayer"
description: "Reference for ShadcnLayer"
---

```dart
class ShadcnLayer extends StatelessWidget {
  final Widget? child;
  final ThemeData theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final AdaptiveScaling? scaling;
  final List<Color> initialRecentColors;
  final int maxRecentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  final Widget Function(BuildContext context, Widget? child)? builder;
  final bool enableScrollInterception;
  final OverlayHandler? popoverHandler;
  final OverlayHandler? tooltipHandler;
  final OverlayHandler? menuHandler;
  final bool enableThemeAnimation;
  const ShadcnLayer({super.key, required this.theme, this.scaling, this.child, this.initialRecentColors = const [], this.maxRecentColors = 50, this.onRecentColorsChanged, this.builder, this.enableScrollInterception = false, this.darkTheme, this.themeMode = ThemeMode.system, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = true});
  Widget build(BuildContext context);
}
```
