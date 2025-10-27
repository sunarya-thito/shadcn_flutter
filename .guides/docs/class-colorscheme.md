---
title: "Class: ColorScheme"
description: "Reference for ColorScheme"
---

```dart
class ColorScheme implements ChartColorScheme {
  static const Set<String> colorKeys = {'background', 'foreground', 'card', 'cardForeground', 'popover', 'popoverForeground', 'primary', 'primaryForeground', 'secondary', 'secondaryForeground', 'muted', 'mutedForeground', 'accent', 'accentForeground', 'destructive', 'destructiveForeground', 'border', 'input', 'ring', 'chart1', 'chart2', 'chart3', 'chart4', 'chart5'};
  final Brightness brightness;
  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color popover;
  final Color popoverForeground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color sidebar;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;
  const ColorScheme({required this.brightness, required this.background, required this.foreground, required this.card, required this.cardForeground, required this.popover, required this.popoverForeground, required this.primary, required this.primaryForeground, required this.secondary, required this.secondaryForeground, required this.muted, required this.mutedForeground, required this.accent, required this.accentForeground, required this.destructive, this.destructiveForeground = Colors.transparent, required this.border, required this.input, required this.ring, required this.chart1, required this.chart2, required this.chart3, required this.chart4, required this.chart5, required this.sidebar, required this.sidebarForeground, required this.sidebarPrimary, required this.sidebarPrimaryForeground, required this.sidebarAccent, required this.sidebarAccentForeground, required this.sidebarBorder, required this.sidebarRing});
  ColorScheme.fromMap(Map<String, dynamic> map);
  Map<String, String> toMap();
  Map<String, Color> toColorMap();
  ColorScheme.fromColors({required Map<String, Color> colors, required Brightness brightness});
  ColorScheme copyWith({ValueGetter<Brightness>? brightness, ValueGetter<Color>? background, ValueGetter<Color>? foreground, ValueGetter<Color>? card, ValueGetter<Color>? cardForeground, ValueGetter<Color>? popover, ValueGetter<Color>? popoverForeground, ValueGetter<Color>? primary, ValueGetter<Color>? primaryForeground, ValueGetter<Color>? secondary, ValueGetter<Color>? secondaryForeground, ValueGetter<Color>? muted, ValueGetter<Color>? mutedForeground, ValueGetter<Color>? accent, ValueGetter<Color>? accentForeground, ValueGetter<Color>? destructive, ValueGetter<Color>? destructiveForeground, ValueGetter<Color>? border, ValueGetter<Color>? input, ValueGetter<Color>? ring, ValueGetter<Color>? chart1, ValueGetter<Color>? chart2, ValueGetter<Color>? chart3, ValueGetter<Color>? chart4, ValueGetter<Color>? chart5, ValueGetter<Color>? sidebar, ValueGetter<Color>? sidebarForeground, ValueGetter<Color>? sidebarPrimary, ValueGetter<Color>? sidebarPrimaryForeground, ValueGetter<Color>? sidebarAccent, ValueGetter<Color>? sidebarAccentForeground, ValueGetter<Color>? sidebarBorder, ValueGetter<Color>? sidebarRing});
  List<Color> get chartColors;
  static ColorScheme lerp(ColorScheme a, ColorScheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
