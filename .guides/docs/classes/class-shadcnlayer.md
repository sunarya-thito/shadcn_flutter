---
title: "Class: ShadcnLayer"
description: "A layer widget that provides shadcn theme and infrastructure."
---

```dart
/// A layer widget that provides shadcn theme and infrastructure.
///
/// This widget sets up the theming, overlay handlers, scroll behavior,
/// and other infrastructure needed for shadcn_flutter widgets to work correctly.
class ShadcnLayer extends StatelessWidget {
  /// The child widget to wrap with shadcn infrastructure.
  final Widget? child;
  /// The light theme data.
  final ThemeData theme;
  /// The dark theme data.
  final ThemeData? darkTheme;
  /// Determines which theme to use.
  final ThemeMode themeMode;
  /// The scaling strategy for adaptive layouts.
  final AdaptiveScaling? scaling;
  /// The initial list of recent colors.
  final List<Color> initialRecentColors;
  /// The maximum number of recent colors to track.
  final int maxRecentColors;
  /// Called when the list of recent colors changes.
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  /// A builder to wrap the child widget.
  final Widget Function(BuildContext context, Widget? child)? builder;
  /// Whether to enable scroll interception.
  final bool enableScrollInterception;
  /// The overlay handler for popovers.
  final OverlayHandler? popoverHandler;
  /// The overlay handler for tooltips.
  final OverlayHandler? tooltipHandler;
  /// The overlay handler for menus.
  final OverlayHandler? menuHandler;
  /// Whether to animate theme changes.
  final bool enableThemeAnimation;
  /// Creates a shadcn layer.
  const ShadcnLayer({super.key, required this.theme, this.scaling, this.child, this.initialRecentColors = const [], this.maxRecentColors = 50, this.onRecentColorsChanged, this.builder, this.enableScrollInterception = false, this.darkTheme, this.themeMode = ThemeMode.system, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = true});
  Widget build(BuildContext context);
}
```
