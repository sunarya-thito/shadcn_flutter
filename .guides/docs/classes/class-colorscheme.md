---
title: "Class: ColorScheme"
description: "The color scheme for shadcn_flutter applications."
---

```dart
/// The color scheme for shadcn_flutter applications.
///
/// Defines all the semantic colors used throughout the app including
/// background, foreground, primary, secondary, destructive colors, etc.
/// Also includes sidebar and chart colors.
class ColorScheme implements ChartColorScheme {
  /// Set of recognized color key names for the color scheme.
  ///
  /// Contains all valid color property names that can be used when
  /// constructing or serializing a ColorScheme.
  static const Set<String> colorKeys = {'background', 'foreground', 'card', 'cardForeground', 'popover', 'popoverForeground', 'primary', 'primaryForeground', 'secondary', 'secondaryForeground', 'muted', 'mutedForeground', 'accent', 'accentForeground', 'destructive', 'destructiveForeground', 'border', 'input', 'ring', 'chart1', 'chart2', 'chart3', 'chart4', 'chart5'};
  /// The brightness of this color scheme (light or dark).
  final Brightness brightness;
  /// The background color.
  final Color background;
  /// The foreground color (typically text).
  final Color foreground;
  /// The card background color.
  final Color card;
  /// The card foreground color.
  final Color cardForeground;
  /// The popover background color.
  final Color popover;
  /// The popover foreground color.
  final Color popoverForeground;
  /// The primary brand color.
  final Color primary;
  /// The foreground color for primary elements.
  final Color primaryForeground;
  /// The secondary color.
  final Color secondary;
  /// The foreground color for secondary elements.
  final Color secondaryForeground;
  /// The muted background color.
  final Color muted;
  /// The muted foreground color.
  final Color mutedForeground;
  /// The accent color.
  final Color accent;
  /// The foreground color for accented elements.
  final Color accentForeground;
  /// The destructive action color (typically red).
  final Color destructive;
  /// The foreground color for destructive elements.
  final Color destructiveForeground;
  /// The border color.
  final Color border;
  /// The input field border color.
  final Color input;
  /// The focus ring color.
  final Color ring;
  /// The sidebar background color.
  final Color sidebar;
  /// The sidebar foreground color.
  final Color sidebarForeground;
  /// The sidebar primary color.
  final Color sidebarPrimary;
  /// The sidebar primary foreground color.
  final Color sidebarPrimaryForeground;
  /// The sidebar accent color.
  final Color sidebarAccent;
  /// The sidebar accent foreground color.
  final Color sidebarAccentForeground;
  /// The sidebar border color.
  final Color sidebarBorder;
  /// The sidebar ring color.
  final Color sidebarRing;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;
  /// Creates a color scheme with all required colors.
  const ColorScheme({required this.brightness, required this.background, required this.foreground, required this.card, required this.cardForeground, required this.popover, required this.popoverForeground, required this.primary, required this.primaryForeground, required this.secondary, required this.secondaryForeground, required this.muted, required this.mutedForeground, required this.accent, required this.accentForeground, required this.destructive, this.destructiveForeground = Colors.transparent, required this.border, required this.input, required this.ring, required this.chart1, required this.chart2, required this.chart3, required this.chart4, required this.chart5, required this.sidebar, required this.sidebarForeground, required this.sidebarPrimary, required this.sidebarPrimaryForeground, required this.sidebarAccent, required this.sidebarAccentForeground, required this.sidebarBorder, required this.sidebarRing});
  /// Creates a color scheme from a map of color names to values.
  ColorScheme.fromMap(Map<String, dynamic> map);
  /// Converts the color scheme to a map of hex color strings.
  ///
  /// Returns a map where keys are color property names and values are
  /// hex-encoded color strings (e.g., "#RRGGBB").
  ///
  /// Useful for serialization or CSS generation.
  Map<String, String> toMap();
  /// Converts the color scheme to a map of Color objects.
  ///
  /// Returns a map where keys are color property names and values are
  /// Flutter Color objects.
  ///
  /// Useful for programmatic color access.
  Map<String, Color> toColorMap();
  /// Creates a ColorScheme from a map of colors.
  ///
  /// Constructs a ColorScheme by looking up color values from a map.
  ///
  /// Parameters:
  /// - [colors] (`Map<String, Color>`, required): Map of color name to Color
  /// - [brightness] (Brightness, required): Theme brightness (light or dark)
  ///
  /// Example:
  /// ```dart
  /// ColorScheme.fromColors(
  ///   colors: {'background': Colors.white, 'foreground': Colors.black, ...},
  ///   brightness: Brightness.light,
  /// )
  /// ```
  ColorScheme.fromColors({required Map<String, Color> colors, required Brightness brightness});
  /// Creates a copy of this ColorScheme with specified properties replaced.
  ///
  /// Returns a new ColorScheme with any provided properties replaced.
  /// Uses ValueGetter for each property to allow lazy evaluation.
  ///
  /// Parameters are ValueGetters for all color scheme properties. Only
  /// provided parameters will be replaced in the copy.
  ///
  /// Example:
  /// ```dart
  /// scheme.copyWith(
  ///   background: () => Colors.white,
  ///   foreground: () => Colors.black,
  /// )
  /// ```
  ColorScheme copyWith({ValueGetter<Brightness>? brightness, ValueGetter<Color>? background, ValueGetter<Color>? foreground, ValueGetter<Color>? card, ValueGetter<Color>? cardForeground, ValueGetter<Color>? popover, ValueGetter<Color>? popoverForeground, ValueGetter<Color>? primary, ValueGetter<Color>? primaryForeground, ValueGetter<Color>? secondary, ValueGetter<Color>? secondaryForeground, ValueGetter<Color>? muted, ValueGetter<Color>? mutedForeground, ValueGetter<Color>? accent, ValueGetter<Color>? accentForeground, ValueGetter<Color>? destructive, ValueGetter<Color>? destructiveForeground, ValueGetter<Color>? border, ValueGetter<Color>? input, ValueGetter<Color>? ring, ValueGetter<Color>? chart1, ValueGetter<Color>? chart2, ValueGetter<Color>? chart3, ValueGetter<Color>? chart4, ValueGetter<Color>? chart5, ValueGetter<Color>? sidebar, ValueGetter<Color>? sidebarForeground, ValueGetter<Color>? sidebarPrimary, ValueGetter<Color>? sidebarPrimaryForeground, ValueGetter<Color>? sidebarAccent, ValueGetter<Color>? sidebarAccentForeground, ValueGetter<Color>? sidebarBorder, ValueGetter<Color>? sidebarRing});
  List<Color> get chartColors;
  /// Linearly interpolates between two ColorSchemes.
  ///
  /// Creates a new ColorScheme that represents a transition between [a] and [b]
  /// at position [t]. When t=0, returns [a]; when t=1, returns [b].
  ///
  /// Parameters:
  /// - [a] (ColorScheme, required): Start color scheme
  /// - [b] (ColorScheme, required): End color scheme
  /// - [t] (double, required): Interpolation position (0.0 to 1.0)
  ///
  /// Returns interpolated ColorScheme.
  static ColorScheme lerp(ColorScheme a, ColorScheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
