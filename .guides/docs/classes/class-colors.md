---
title: "Class: Colors"
description: "A collection of color constants and shades for shadcn_flutter."
---

```dart
/// A collection of color constants and shades for shadcn_flutter.
///
/// This class provides predefined colors and color shades that can be used
/// throughout the application. All colors follow the shadcn design system.
class Colors {
  /// Pure black color.
  static const Color black = Color(0xff000000);
  /// Pure white color.
  static const Color white = Color(0xffffffff);
  /// Slate color shades (50-950).
  static const ColorShades slate = ColorShades.raw({50 : Color(0xfff8fafc), 100 : Color(0xfff1f5f9), 200 : Color(0xffe2e8f0), 300 : Color(0xffcbd5e1), 400 : Color(0xff94a3b8), 500 : Color(0xff64748b), 600 : Color(0xff475569), 700 : Color(0xff334155), 800 : Color(0xff1e293b), 900 : Color(0xff0f172a), 950 : Color(0xff020617)});
  /// Gray color shades (50-950).
  static const ColorShades gray = ColorShades.raw({50 : Color(0xfff9fafb), 100 : Color(0xfff3f4f6), 200 : Color(0xffe5e7eb), 300 : Color(0xffd1d5db), 400 : Color(0xff9ca3af), 500 : Color(0xff6b7280), 600 : Color(0xff4b5563), 700 : Color(0xff374151), 800 : Color(0xff1f2937), 900 : Color(0xff111827), 950 : Color(0xff030712)});
  /// Zinc color shades (50-950).
  static const ColorShades zinc = ColorShades.raw({50 : Color(0xfffafafa), 100 : Color(0xfff4f4f5), 200 : Color(0xffe4e4e7), 300 : Color(0xffd4d4d8), 400 : Color(0xffa1a1aa), 500 : Color(0xff71717a), 600 : Color(0xff52525b), 700 : Color(0xff3f3f46), 800 : Color(0xff27272a), 900 : Color(0xff18181b), 950 : Color(0xff09090b)});
  /// Neutral color shades (50-950).
  static const ColorShades neutral = ColorShades.raw({50 : Color(0xfffafafa), 100 : Color(0xfff5f5f5), 200 : Color(0xffe5e5e5), 300 : Color(0xffd4d4d4), 400 : Color(0xffa3a3a3), 500 : Color(0xff737373), 600 : Color(0xff525252), 700 : Color(0xff404040), 800 : Color(0xff262626), 900 : Color(0xff171717), 950 : Color(0xff0a0a0a)});
  /// Stone color shades (50-950).
  static const ColorShades stone = ColorShades.raw({50 : Color(0xfffafaf9), 100 : Color(0xfff5f5f4), 200 : Color(0xffe7e5e4), 300 : Color(0xffd6d3d1), 400 : Color(0xffa8a29e), 500 : Color(0xff78716c), 600 : Color(0xff57534e), 700 : Color(0xff44403c), 800 : Color(0xff292524), 900 : Color(0xff1c1917), 950 : Color(0xff0c0a09)});
  /// Red color shades (50-950).
  static const ColorShades red = ColorShades.raw({50 : Color(0xfffef2f2), 100 : Color(0xfffee2e2), 200 : Color(0xfffecaca), 300 : Color(0xfffca5a5), 400 : Color(0xfff87171), 500 : Color(0xffef4444), 600 : Color(0xffdc2626), 700 : Color(0xffb91c1c), 800 : Color(0xff991b1b), 900 : Color(0xff7f1d1d), 950 : Color(0xff450a0a)});
  /// Orange color shades (50-950).
  static const ColorShades orange = ColorShades.raw({50 : Color(0xfffff7ed), 100 : Color(0xffffedd5), 200 : Color(0xfffed7aa), 300 : Color(0xfffdba74), 400 : Color(0xfffb923c), 500 : Color(0xfff97316), 600 : Color(0xffea580c), 700 : Color(0xffc2410c), 800 : Color(0xff9a3412), 900 : Color(0xff7c2d12), 950 : Color(0xff431407)});
  /// Amber color shades (50-950).
  static const ColorShades amber = ColorShades.raw({50 : Color(0xfffffbeb), 100 : Color(0xfffef3c7), 200 : Color(0xfffde68a), 300 : Color(0xfffcd34d), 400 : Color(0xfffbbf24), 500 : Color(0xfff59e0b), 600 : Color(0xffd97706), 700 : Color(0xffb45309), 800 : Color(0xff92400e), 900 : Color(0xff78350f), 950 : Color(0xff451a03)});
  /// Yellow color shades (50-950).
  static const ColorShades yellow = ColorShades.raw({50 : Color(0xfffefce8), 100 : Color(0xfffef9c3), 200 : Color(0xfffef08a), 300 : Color(0xfffde047), 400 : Color(0xfffacc15), 500 : Color(0xffeab308), 600 : Color(0xffca8a04), 700 : Color(0xffa16207), 800 : Color(0xff854d0e), 900 : Color(0xff713f12), 950 : Color(0xff422006)});
  /// Lime color shades (50-950).
  static const ColorShades lime = ColorShades.raw({50 : Color(0xfff7fee7), 100 : Color(0xffecfccb), 200 : Color(0xffd9f99d), 300 : Color(0xffbef264), 400 : Color(0xffa3e635), 500 : Color(0xff84cc16), 600 : Color(0xff65a30d), 700 : Color(0xff4d7c0f), 800 : Color(0xff3f6212), 900 : Color(0xff365314), 950 : Color(0xff1a2e05)});
  /// Green color shades (50-950).
  static const ColorShades green = ColorShades.raw({50 : Color(0xfff0fdf4), 100 : Color(0xffdcfce7), 200 : Color(0xffbbf7d0), 300 : Color(0xff86efac), 400 : Color(0xff4ade80), 500 : Color(0xff22c55e), 600 : Color(0xff16a34a), 700 : Color(0xff15803d), 800 : Color(0xff166534), 900 : Color(0xff14532d), 950 : Color(0xff052e16)});
  /// Emerald color shades (50-950).
  static const ColorShades emerald = ColorShades.raw({50 : Color(0xffecfdf5), 100 : Color(0xffd1fae5), 200 : Color(0xffa7f3d0), 300 : Color(0xff6ee7b7), 400 : Color(0xff34d399), 500 : Color(0xff10b981), 600 : Color(0xff059669), 700 : Color(0xff047857), 800 : Color(0xff065f46), 900 : Color(0xff064e3b), 950 : Color(0xff022c22)});
  /// Teal color shades (50-950).
  static const ColorShades teal = ColorShades.raw({50 : Color(0xfff0fdfa), 100 : Color(0xffccfbf1), 200 : Color(0xff99f6e4), 300 : Color(0xff5eead4), 400 : Color(0xff2dd4bf), 500 : Color(0xff14b8a6), 600 : Color(0xff0d9488), 700 : Color(0xff0f766e), 800 : Color(0xff115e59), 900 : Color(0xff134e4a), 950 : Color(0xff042f2e)});
  /// Cyan color shades (50-950).
  static const ColorShades cyan = ColorShades.raw({50 : Color(0xffecfeff), 100 : Color(0xffcffafe), 200 : Color(0xffa5f3fc), 300 : Color(0xff67e8f9), 400 : Color(0xff22d3ee), 500 : Color(0xff06b6d4), 600 : Color(0xff0891b2), 700 : Color(0xff0e7490), 800 : Color(0xff155e75), 900 : Color(0xff164e63), 950 : Color(0xff083344)});
  /// Sky color shades (50-950).
  static const ColorShades sky = ColorShades.raw({50 : Color(0xfff0f9ff), 100 : Color(0xffe0f2fe), 200 : Color(0xffbae6fd), 300 : Color(0xff7dd3fc), 400 : Color(0xff38bdf8), 500 : Color(0xff0ea5e9), 600 : Color(0xff0284c7), 700 : Color(0xff0369a1), 800 : Color(0xff075985), 900 : Color(0xff0c4a6e), 950 : Color(0xff082f49)});
  /// Blue color shades (50-950).
  static const ColorShades blue = ColorShades.raw({50 : Color(0xffeff6ff), 100 : Color(0xffdbeafe), 200 : Color(0xffbfdbfe), 300 : Color(0xff93c5fd), 400 : Color(0xff60a5fa), 500 : Color(0xff3b82f6), 600 : Color(0xff2563eb), 700 : Color(0xff1d4ed8), 800 : Color(0xff1e40af), 900 : Color(0xff1e3a8a), 950 : Color(0xff172554)});
  /// Indigo color shades (50-950).
  static const ColorShades indigo = ColorShades.raw({50 : Color(0xffeef2ff), 100 : Color(0xffe0e7ff), 200 : Color(0xffc7d2fe), 300 : Color(0xffa5b4fc), 400 : Color(0xff818cf8), 500 : Color(0xff6366f1), 600 : Color(0xff4f46e5), 700 : Color(0xff4338ca), 800 : Color(0xff3730a3), 900 : Color(0xff312e81), 950 : Color(0xff1e1b4b)});
  /// Violet color shades (50-950).
  static const ColorShades violet = ColorShades.raw({50 : Color(0xfff5f3ff), 100 : Color(0xffede9fe), 200 : Color(0xffddd6fe), 300 : Color(0xffc4b5fd), 400 : Color(0xffa78bfa), 500 : Color(0xff8b5cf6), 600 : Color(0xff7c3aed), 700 : Color(0xff6d28d9), 800 : Color(0xff5b21b6), 900 : Color(0xff4c1d95), 950 : Color(0xff1e1b4b)});
  /// Purple color shades (50-950).
  static const ColorShades purple = ColorShades.raw({50 : Color(0xfffaf5ff), 100 : Color(0xfff3e8ff), 200 : Color(0xffe9d5ff), 300 : Color(0xffd8b4fe), 400 : Color(0xffc084fc), 500 : Color(0xffa855f7), 600 : Color(0xff9333ea), 700 : Color(0xff7e22ce), 800 : Color(0xff6b21a8), 900 : Color(0xff581c87), 950 : Color(0xff3b0764)});
  /// Fuchsia color shades (50-950).
  static const ColorShades fuchsia = ColorShades.raw({50 : Color(0xfffdf4ff), 100 : Color(0xfffae8ff), 200 : Color(0xfff5d0fe), 300 : Color(0xfff0abfc), 400 : Color(0xffe879f9), 500 : Color(0xffd946ef), 600 : Color(0xffc026d3), 700 : Color(0xffa21caf), 800 : Color(0xff86198f), 900 : Color(0xff701a75), 950 : Color(0xff4a044e)});
  /// Pink color shades (50-950).
  static const ColorShades pink = ColorShades.raw({50 : Color(0xfffdf2f8), 100 : Color(0xfffce7f3), 200 : Color(0xfffbcfe8), 300 : Color(0xfff9a8d4), 400 : Color(0xfff472b6), 500 : Color(0xffec4899), 600 : Color(0xffdb2777), 700 : Color(0xffbe185d), 800 : Color(0xff9d174d), 900 : Color(0xff831843), 950 : Color(0xff500724)});
  /// Rose color shades (50-950).
  static const ColorShades rose = ColorShades.raw({50 : Color(0xfffff1f2), 100 : Color(0xffffe4e6), 200 : Color(0xfffecdd3), 300 : Color(0xfffda4af), 400 : Color(0xfffb7185), 500 : Color(0xfff43f5e), 600 : Color(0xffe11d48), 700 : Color(0xffbe123c), 800 : Color(0xff9f1239), 900 : Color(0xff881337), 950 : Color(0xff4c0519)});
  /// Fully transparent color.
  static const Color transparent = Color(0x00000000);
  /// List of primary color swatches from the Material color palette.
  ///
  /// Contains all standard Material Design color shades (slate, gray, zinc,
  /// neutral, stone, red, orange, amber, yellow, lime, green, emerald, etc.).
  static final List<Color> primaries;
}
```
