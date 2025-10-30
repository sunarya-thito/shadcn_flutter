---
title: "Class: Typography"
description: "Typography definitions for shadcn_flutter."
---

```dart
/// Typography definitions for shadcn_flutter.
///
/// Provides predefined text styles for different purposes including
/// sizes, weights, and semantic styles like headings and paragraphs.
class Typography {
  /// Sans-serif font style.
  final TextStyle sans;
  /// Monospace font style.
  final TextStyle mono;
  /// Extra small text (12px).
  final TextStyle xSmall;
  /// Small text (14px).
  final TextStyle small;
  /// Base text size (16px).
  final TextStyle base;
  /// Large text (18px).
  final TextStyle large;
  /// Extra large text (20px).
  final TextStyle xLarge;
  /// 2x large text (24px).
  final TextStyle x2Large;
  /// 3x large text (30px).
  final TextStyle x3Large;
  /// 4x large text (36px).
  final TextStyle x4Large;
  /// 5x large text (48px).
  final TextStyle x5Large;
  /// 6x large text (60px).
  final TextStyle x6Large;
  /// 7x large text (72px).
  final TextStyle x7Large;
  /// 8x large text (96px).
  final TextStyle x8Large;
  /// 9x large text (144px).
  final TextStyle x9Large;
  /// Thin font weight (100).
  final TextStyle thin;
  /// Light font weight (300).
  final TextStyle light;
  /// Extra light font weight (200).
  final TextStyle extraLight;
  /// Normal font weight (400).
  final TextStyle normal;
  /// Medium font weight (500).
  final TextStyle medium;
  /// Semi-bold font weight (600).
  final TextStyle semiBold;
  /// Bold font weight (700).
  final TextStyle bold;
  /// Extra bold font weight (800).
  final TextStyle extraBold;
  /// Black font weight (900).
  final TextStyle black;
  /// Italic text style.
  final TextStyle italic;
  /// Heading 1 style.
  final TextStyle h1;
  /// Heading 2 style.
  final TextStyle h2;
  /// Heading 3 style.
  final TextStyle h3;
  /// Heading 4 style.
  final TextStyle h4;
  /// Paragraph style.
  final TextStyle p;
  /// Block quote style.
  final TextStyle blockQuote;
  /// Inline code style.
  final TextStyle inlineCode;
  /// Lead text style.
  final TextStyle lead;
  /// Large text style.
  final TextStyle textLarge;
  /// Small text style.
  final TextStyle textSmall;
  /// Muted text style.
  final TextStyle textMuted;
  /// Creates a typography with Geist font family.
  const Typography.geist({this.sans = const TextStyle(fontFamily: 'GeistSans', package: 'shadcn_flutter'), this.mono = const TextStyle(fontFamily: 'GeistMono', package: 'shadcn_flutter'), this.xSmall = const TextStyle(fontSize: 12), this.small = const TextStyle(fontSize: 14), this.base = const TextStyle(fontSize: 16), this.large = const TextStyle(fontSize: 18), this.xLarge = const TextStyle(fontSize: 20), this.x2Large = const TextStyle(fontSize: 24), this.x3Large = const TextStyle(fontSize: 30), this.x4Large = const TextStyle(fontSize: 36), this.x5Large = const TextStyle(fontSize: 48), this.x6Large = const TextStyle(fontSize: 60), this.x7Large = const TextStyle(fontSize: 72), this.x8Large = const TextStyle(fontSize: 96), this.x9Large = const TextStyle(fontSize: 144), this.thin = const TextStyle(fontWeight: FontWeight.w100), this.light = const TextStyle(fontWeight: FontWeight.w300), this.extraLight = const TextStyle(fontWeight: FontWeight.w200), this.normal = const TextStyle(fontWeight: FontWeight.w400), this.medium = const TextStyle(fontWeight: FontWeight.w500), this.semiBold = const TextStyle(fontWeight: FontWeight.w600), this.bold = const TextStyle(fontWeight: FontWeight.w700), this.extraBold = const TextStyle(fontWeight: FontWeight.w800), this.black = const TextStyle(fontWeight: FontWeight.w900), this.italic = const TextStyle(fontStyle: FontStyle.italic), this.h1 = const TextStyle(fontSize: 36, fontWeight: FontWeight.w800), this.h2 = const TextStyle(fontSize: 30, fontWeight: FontWeight.w600), this.h3 = const TextStyle(fontSize: 24, fontWeight: FontWeight.w600), this.h4 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), this.p = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), this.blockQuote = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), this.inlineCode = const TextStyle(fontFamily: 'GeistMono', fontSize: 14, fontWeight: FontWeight.w600), this.lead = const TextStyle(fontSize: 20), this.textLarge = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600), this.textSmall = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500), this.textMuted = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)});
  /// Creates a custom typography with all required text styles.
  const Typography({required this.sans, required this.mono, required this.xSmall, required this.small, required this.base, required this.large, required this.xLarge, required this.x2Large, required this.x3Large, required this.x4Large, required this.x5Large, required this.x6Large, required this.x7Large, required this.x8Large, required this.x9Large, required this.thin, required this.light, required this.extraLight, required this.normal, required this.medium, required this.semiBold, required this.bold, required this.extraBold, required this.black, required this.italic, required this.h1, required this.h2, required this.h3, required this.h4, required this.p, required this.blockQuote, required this.inlineCode, required this.lead, required this.textLarge, required this.textSmall, required this.textMuted});
  /// Creates a copy of this typography with the given fields replaced.
  Typography copyWith({ValueGetter<TextStyle>? sans, ValueGetter<TextStyle>? mono, ValueGetter<TextStyle>? xSmall, ValueGetter<TextStyle>? small, ValueGetter<TextStyle>? base, ValueGetter<TextStyle>? large, ValueGetter<TextStyle>? xLarge, ValueGetter<TextStyle>? x2Large, ValueGetter<TextStyle>? x3Large, ValueGetter<TextStyle>? x4Large, ValueGetter<TextStyle>? x5Large, ValueGetter<TextStyle>? x6Large, ValueGetter<TextStyle>? x7Large, ValueGetter<TextStyle>? x8Large, ValueGetter<TextStyle>? x9Large, ValueGetter<TextStyle>? thin, ValueGetter<TextStyle>? light, ValueGetter<TextStyle>? extraLight, ValueGetter<TextStyle>? normal, ValueGetter<TextStyle>? medium, ValueGetter<TextStyle>? semiBold, ValueGetter<TextStyle>? bold, ValueGetter<TextStyle>? extraBold, ValueGetter<TextStyle>? black, ValueGetter<TextStyle>? italic, ValueGetter<TextStyle>? h1, ValueGetter<TextStyle>? h2, ValueGetter<TextStyle>? h3, ValueGetter<TextStyle>? h4, ValueGetter<TextStyle>? p, ValueGetter<TextStyle>? blockQuote, ValueGetter<TextStyle>? inlineCode, ValueGetter<TextStyle>? lead, ValueGetter<TextStyle>? textLarge, ValueGetter<TextStyle>? textSmall, ValueGetter<TextStyle>? textMuted});
  /// Scales all typography font sizes by the given factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Scaling factor to apply.
  ///
  /// Returns: `Typography` — scaled typography.
  Typography scale(double factor);
  /// Linearly interpolates between two typographies.
  ///
  /// Parameters:
  /// - [a] (`Typography`, required): Start typography.
  /// - [b] (`Typography`, required): End typography.
  /// - [t] (`double`, required): Interpolation position (0.0 to 1.0).
  ///
  /// Returns: `Typography` — interpolated typography.
  static Typography lerp(Typography a, Typography b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
