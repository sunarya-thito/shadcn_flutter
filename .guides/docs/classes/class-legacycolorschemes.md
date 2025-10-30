---
title: "Class: LegacyColorSchemes"
description: "Legacy color schemes using HSL color definitions."
---

```dart
/// Legacy color schemes using HSL color definitions.
///
/// These color schemes use HSL (Hue, Saturation, Lightness) for color definition
/// and are provided for backward compatibility. New code should prefer
/// using the RGB-based [ColorSchemes] class.
class LegacyColorSchemes {
  /// Returns light zinc color scheme.
  static ColorScheme lightZinc();
  /// Returns dark zinc color scheme.
  static ColorScheme darkZinc();
  /// Returns zinc color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme zinc(ThemeMode mode);
  /// Returns light slate color scheme.
  static ColorScheme lightSlate();
  /// Returns dark slate color scheme.
  static ColorScheme darkSlate();
  /// Returns slate color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme slate(ThemeMode mode);
  /// Returns light stone color scheme.
  static ColorScheme lightStone();
  /// Returns dark stone color scheme.
  static ColorScheme darkStone();
  /// Returns stone color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme stone(ThemeMode mode);
  /// Returns light gray color scheme.
  static ColorScheme lightGray();
  /// Returns dark gray color scheme.
  static ColorScheme darkGray();
  /// Returns gray color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme gray(ThemeMode mode);
  /// Returns light neutral color scheme.
  static ColorScheme lightNeutral();
  /// Returns dark neutral color scheme.
  static ColorScheme darkNeutral();
  /// Returns neutral color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme neutral(ThemeMode mode);
  /// Returns light red color scheme.
  static ColorScheme lightRed();
  /// Returns dark red color scheme.
  static ColorScheme darkRed();
  /// Returns red color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme red(ThemeMode mode);
  /// Returns light rose color scheme.
  static ColorScheme lightRose();
  /// Returns dark rose color scheme.
  static ColorScheme darkRose();
  /// Returns rose color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme rose(ThemeMode mode);
  /// Returns light orange color scheme.
  static ColorScheme lightOrange();
  /// Returns dark orange color scheme.
  static ColorScheme darkOrange();
  /// Returns orange color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme orange(ThemeMode mode);
  /// Returns light green color scheme.
  static ColorScheme lightGreen();
  /// Returns dark green color scheme.
  static ColorScheme darkGreen();
  /// Returns green color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme green(ThemeMode mode);
  /// Returns light blue color scheme.
  static ColorScheme lightBlue();
  /// Returns dark blue color scheme.
  static ColorScheme darkBlue();
  /// Returns blue color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme blue(ThemeMode mode);
  /// Returns light yellow color scheme.
  static ColorScheme lightYellow();
  /// Returns dark yellow color scheme.
  static ColorScheme darkYellow();
  /// Returns yellow color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme yellow(ThemeMode mode);
  /// Returns light violet color scheme.
  static ColorScheme lightViolet();
  /// Returns dark violet color scheme.
  static ColorScheme darkViolet();
  /// Returns violet color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme violet(ThemeMode mode);
}
```
