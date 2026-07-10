import '../../shadcn_flutter.dart';

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
  const Typography.geist({
    this.sans =
        const TextStyle(fontFamily: 'GeistSans', package: 'shadcn_flutter'),
    this.mono =
        const TextStyle(fontFamily: 'GeistMono', package: 'shadcn_flutter'),
    this.xSmall = const TextStyle(fontSize: 12),
    this.small = const TextStyle(fontSize: 14),
    this.base = const TextStyle(fontSize: 16),
    this.large = const TextStyle(fontSize: 18),
    this.xLarge = const TextStyle(fontSize: 20),
    this.x2Large = const TextStyle(fontSize: 24),
    this.x3Large = const TextStyle(fontSize: 30),
    this.x4Large = const TextStyle(fontSize: 36),
    this.x5Large = const TextStyle(fontSize: 48),
    this.x6Large = const TextStyle(fontSize: 60),
    this.x7Large = const TextStyle(fontSize: 72),
    this.x8Large = const TextStyle(fontSize: 96),
    this.x9Large = const TextStyle(fontSize: 144),
    this.thin = const TextStyle(fontWeight: FontWeight.w100),
    this.light = const TextStyle(fontWeight: FontWeight.w300),
    this.extraLight = const TextStyle(fontWeight: FontWeight.w200),
    this.normal = const TextStyle(fontWeight: FontWeight.w400),
    this.medium = const TextStyle(fontWeight: FontWeight.w500),
    this.semiBold = const TextStyle(fontWeight: FontWeight.w600),
    this.bold = const TextStyle(fontWeight: FontWeight.w700),
    this.extraBold = const TextStyle(fontWeight: FontWeight.w800),
    this.black = const TextStyle(fontWeight: FontWeight.w900),
    this.italic = const TextStyle(fontStyle: FontStyle.italic),
    this.h1 = const TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
    this.h2 = const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
    this.h3 = const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    this.h4 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    this.p = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    this.blockQuote = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
    this.inlineCode = const TextStyle(
        fontFamily: 'GeistMono', fontSize: 14, fontWeight: FontWeight.w600),
    this.lead = const TextStyle(fontSize: 20),
    this.textLarge = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    this.textSmall = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    this.textMuted = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  });

  /// Creates a custom typography with all required text styles.
  const Typography({
    required this.sans,
    required this.mono,
    required this.xSmall,
    required this.small,
    required this.base,
    required this.large,
    required this.xLarge,
    required this.x2Large,
    required this.x3Large,
    required this.x4Large,
    required this.x5Large,
    required this.x6Large,
    required this.x7Large,
    required this.x8Large,
    required this.x9Large,
    required this.thin,
    required this.light,
    required this.extraLight,
    required this.normal,
    required this.medium,
    required this.semiBold,
    required this.bold,
    required this.extraBold,
    required this.black,
    required this.italic,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.p,
    required this.blockQuote,
    required this.inlineCode,
    required this.lead,
    required this.textLarge,
    required this.textSmall,
    required this.textMuted,
  });

  /// Creates a copy of this typography with the given fields replaced.
  Typography copyWith({
    ValueGetter<TextStyle>? sans,
    ValueGetter<TextStyle>? mono,
    ValueGetter<TextStyle>? xSmall,
    ValueGetter<TextStyle>? small,
    ValueGetter<TextStyle>? base,
    ValueGetter<TextStyle>? large,
    ValueGetter<TextStyle>? xLarge,
    ValueGetter<TextStyle>? x2Large,
    ValueGetter<TextStyle>? x3Large,
    ValueGetter<TextStyle>? x4Large,
    ValueGetter<TextStyle>? x5Large,
    ValueGetter<TextStyle>? x6Large,
    ValueGetter<TextStyle>? x7Large,
    ValueGetter<TextStyle>? x8Large,
    ValueGetter<TextStyle>? x9Large,
    ValueGetter<TextStyle>? thin,
    ValueGetter<TextStyle>? light,
    ValueGetter<TextStyle>? extraLight,
    ValueGetter<TextStyle>? normal,
    ValueGetter<TextStyle>? medium,
    ValueGetter<TextStyle>? semiBold,
    ValueGetter<TextStyle>? bold,
    ValueGetter<TextStyle>? extraBold,
    ValueGetter<TextStyle>? black,
    ValueGetter<TextStyle>? italic,
    ValueGetter<TextStyle>? h1,
    ValueGetter<TextStyle>? h2,
    ValueGetter<TextStyle>? h3,
    ValueGetter<TextStyle>? h4,
    ValueGetter<TextStyle>? p,
    ValueGetter<TextStyle>? blockQuote,
    ValueGetter<TextStyle>? inlineCode,
    ValueGetter<TextStyle>? lead,
    ValueGetter<TextStyle>? textLarge,
    ValueGetter<TextStyle>? textSmall,
    ValueGetter<TextStyle>? textMuted,
  }) {
    return Typography(
      sans: sans == null ? this.sans : sans(),
      mono: mono == null ? this.mono : mono(),
      xSmall: xSmall == null ? this.xSmall : xSmall(),
      small: small == null ? this.small : small(),
      base: base == null ? this.base : base(),
      large: large == null ? this.large : large(),
      xLarge: xLarge == null ? this.xLarge : xLarge(),
      x2Large: x2Large == null ? this.x2Large : x2Large(),
      x3Large: x3Large == null ? this.x3Large : x3Large(),
      x4Large: x4Large == null ? this.x4Large : x4Large(),
      x5Large: x5Large == null ? this.x5Large : x5Large(),
      x6Large: x6Large == null ? this.x6Large : x6Large(),
      x7Large: x7Large == null ? this.x7Large : x7Large(),
      x8Large: x8Large == null ? this.x8Large : x8Large(),
      x9Large: x9Large == null ? this.x9Large : x9Large(),
      thin: thin == null ? this.thin : thin(),
      light: light == null ? this.light : light(),
      extraLight: extraLight == null ? this.extraLight : extraLight(),
      normal: normal == null ? this.normal : normal(),
      medium: medium == null ? this.medium : medium(),
      semiBold: semiBold == null ? this.semiBold : semiBold(),
      bold: bold == null ? this.bold : bold(),
      extraBold: extraBold == null ? this.extraBold : extraBold(),
      black: black == null ? this.black : black(),
      italic: italic == null ? this.italic : italic(),
      h1: h1 == null ? this.h1 : h1(),
      h2: h2 == null ? this.h2 : h2(),
      h3: h3 == null ? this.h3 : h3(),
      h4: h4 == null ? this.h4 : h4(),
      p: p == null ? this.p : p(),
      blockQuote: blockQuote == null ? this.blockQuote : blockQuote(),
      inlineCode: inlineCode == null ? this.inlineCode : inlineCode(),
      lead: lead == null ? this.lead : lead(),
      textLarge: textLarge == null ? this.textLarge : textLarge(),
      textSmall: textSmall == null ? this.textSmall : textSmall(),
      textMuted: textMuted == null ? this.textMuted : textMuted(),
    );
  }

  /// Scales all typography font sizes by the given factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Scaling factor to apply.
  ///
  /// Returns: `Typography` — scaled typography.
  Typography scale(double factor) {
    return Typography(
      sans: sans.fontSize == null
          ? sans
          : sans.copyWith(fontSize: sans.fontSize! * factor),
      mono: mono.fontSize == null
          ? mono
          : mono.copyWith(fontSize: mono.fontSize! * factor),
      xSmall: xSmall.fontSize == null
          ? xSmall
          : xSmall.copyWith(fontSize: xSmall.fontSize! * factor),
      small: small.fontSize == null
          ? small
          : small.copyWith(fontSize: small.fontSize! * factor),
      base: base.fontSize == null
          ? base
          : base.copyWith(fontSize: base.fontSize! * factor),
      large: large.fontSize == null
          ? large
          : large.copyWith(fontSize: large.fontSize! * factor),
      xLarge: xLarge.fontSize == null
          ? xLarge
          : xLarge.copyWith(fontSize: xLarge.fontSize! * factor),
      x2Large: x2Large.fontSize == null
          ? x2Large
          : x2Large.copyWith(fontSize: x2Large.fontSize! * factor),
      x3Large: x3Large.fontSize == null
          ? x3Large
          : x3Large.copyWith(fontSize: x3Large.fontSize! * factor),
      x4Large: x4Large.fontSize == null
          ? x4Large
          : x4Large.copyWith(fontSize: x4Large.fontSize! * factor),
      x5Large: x5Large.fontSize == null
          ? x5Large
          : x5Large.copyWith(fontSize: x5Large.fontSize! * factor),
      x6Large: x6Large.fontSize == null
          ? x6Large
          : x6Large.copyWith(fontSize: x6Large.fontSize! * factor),
      x7Large: x7Large.fontSize == null
          ? x7Large
          : x7Large.copyWith(fontSize: x7Large.fontSize! * factor),
      x8Large: x8Large.fontSize == null
          ? x8Large
          : x8Large.copyWith(fontSize: x8Large.fontSize! * factor),
      x9Large: x9Large.fontSize == null
          ? x9Large
          : x9Large.copyWith(fontSize: x9Large.fontSize! * factor),
      thin: thin.fontSize == null
          ? thin
          : thin.copyWith(fontSize: thin.fontSize! * factor),
      light: light.fontSize == null
          ? light
          : light.copyWith(fontSize: light.fontSize! * factor),
      extraLight: extraLight.fontSize == null
          ? extraLight
          : extraLight.copyWith(fontSize: extraLight.fontSize! * factor),
      normal: normal.fontSize == null
          ? normal
          : normal.copyWith(fontSize: normal.fontSize! * factor),
      medium: medium.fontSize == null
          ? medium
          : medium.copyWith(fontSize: medium.fontSize! * factor),
      semiBold: semiBold.fontSize == null
          ? semiBold
          : semiBold.copyWith(fontSize: semiBold.fontSize! * factor),
      bold: bold.fontSize == null
          ? bold
          : bold.copyWith(fontSize: bold.fontSize! * factor),
      extraBold: extraBold.fontSize == null
          ? extraBold
          : extraBold.copyWith(fontSize: extraBold.fontSize! * factor),
      black: black.fontSize == null
          ? black
          : black.copyWith(fontSize: black.fontSize! * factor),
      italic: italic.fontSize == null
          ? italic
          : italic.copyWith(fontSize: italic.fontSize! * factor),
      h1: h1.fontSize == null
          ? h1
          : h1.copyWith(fontSize: h1.fontSize! * factor),
      h2: h2.fontSize == null
          ? h2
          : h2.copyWith(fontSize: h2.fontSize! * factor),
      h3: h3.fontSize == null
          ? h3
          : h3.copyWith(fontSize: h3.fontSize! * factor),
      h4: h4.fontSize == null
          ? h4
          : h4.copyWith(fontSize: h4.fontSize! * factor),
      p: p.fontSize == null ? p : p.copyWith(fontSize: p.fontSize! * factor),
      blockQuote: blockQuote.fontSize == null
          ? blockQuote
          : blockQuote.copyWith(fontSize: blockQuote.fontSize! * factor),
      inlineCode: inlineCode.fontSize == null
          ? inlineCode
          : inlineCode.copyWith(fontSize: inlineCode.fontSize! * factor),
      lead: lead.fontSize == null
          ? lead
          : lead.copyWith(fontSize: lead.fontSize! * factor),
      textLarge: textLarge.fontSize == null
          ? textLarge
          : textLarge.copyWith(fontSize: textLarge.fontSize! * factor),
      textSmall: textSmall.fontSize == null
          ? textSmall
          : textSmall.copyWith(fontSize: textSmall.fontSize! * factor),
      textMuted: textMuted.fontSize == null
          ? textMuted
          : textMuted.copyWith(fontSize: textMuted.fontSize! * factor),
    );
  }

  /// Linearly interpolates between two typographies.
  ///
  /// Parameters:
  /// - [a] (`Typography`, required): Start typography.
  /// - [b] (`Typography`, required): End typography.
  /// - [t] (`double`, required): Interpolation position (0.0 to 1.0).
  ///
  /// Returns: `Typography` — interpolated typography.
  static Typography lerp(Typography a, Typography b, double t) {
    return Typography(
      sans: TextStyle.lerp(a.sans, b.sans, t)!,
      mono: TextStyle.lerp(a.mono, b.mono, t)!,
      xSmall: TextStyle.lerp(a.xSmall, b.xSmall, t)!,
      small: TextStyle.lerp(a.small, b.small, t)!,
      base: TextStyle.lerp(a.base, b.base, t)!,
      large: TextStyle.lerp(a.large, b.large, t)!,
      xLarge: TextStyle.lerp(a.xLarge, b.xLarge, t)!,
      x2Large: TextStyle.lerp(a.x2Large, b.x2Large, t)!,
      x3Large: TextStyle.lerp(a.x3Large, b.x3Large, t)!,
      x4Large: TextStyle.lerp(a.x4Large, b.x4Large, t)!,
      x5Large: TextStyle.lerp(a.x5Large, b.x5Large, t)!,
      x6Large: TextStyle.lerp(a.x6Large, b.x6Large, t)!,
      x7Large: TextStyle.lerp(a.x7Large, b.x7Large, t)!,
      x8Large: TextStyle.lerp(a.x8Large, b.x8Large, t)!,
      x9Large: TextStyle.lerp(a.x9Large, b.x9Large, t)!,
      thin: TextStyle.lerp(a.thin, b.thin, t)!,
      light: TextStyle.lerp(a.light, b.light, t)!,
      extraLight: TextStyle.lerp(a.extraLight, b.extraLight, t)!,
      normal: TextStyle.lerp(a.normal, b.normal, t)!,
      medium: TextStyle.lerp(a.medium, b.medium, t)!,
      semiBold: TextStyle.lerp(a.semiBold, b.semiBold, t)!,
      bold: TextStyle.lerp(a.bold, b.bold, t)!,
      extraBold: TextStyle.lerp(a.extraBold, b.extraBold, t)!,
      black: TextStyle.lerp(a.black, b.black, t)!,
      italic: TextStyle.lerp(a.italic, b.italic, t)!,
      h1: TextStyle.lerp(a.h1, b.h1, t)!,
      h2: TextStyle.lerp(a.h2, b.h2, t)!,
      h3: TextStyle.lerp(a.h3, b.h3, t)!,
      h4: TextStyle.lerp(a.h4, b.h4, t)!,
      p: TextStyle.lerp(a.p, b.p, t)!,
      blockQuote: TextStyle.lerp(a.blockQuote, b.blockQuote, t)!,
      inlineCode: TextStyle.lerp(a.inlineCode, b.inlineCode, t)!,
      lead: TextStyle.lerp(a.lead, b.lead, t)!,
      textLarge: TextStyle.lerp(a.textLarge, b.textLarge, t)!,
      textSmall: TextStyle.lerp(a.textSmall, b.textSmall, t)!,
      textMuted: TextStyle.lerp(a.textMuted, b.textMuted, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Typography &&
          sans == other.sans &&
          mono == other.mono &&
          xSmall == other.xSmall &&
          small == other.small &&
          base == other.base &&
          large == other.large &&
          xLarge == other.xLarge &&
          x2Large == other.x2Large &&
          x3Large == other.x3Large &&
          x4Large == other.x4Large &&
          x5Large == other.x5Large &&
          x6Large == other.x6Large &&
          x7Large == other.x7Large &&
          x8Large == other.x8Large &&
          x9Large == other.x9Large &&
          thin == other.thin &&
          light == other.light &&
          extraLight == other.extraLight &&
          normal == other.normal &&
          medium == other.medium &&
          semiBold == other.semiBold &&
          bold == other.bold &&
          extraBold == other.extraBold &&
          black == other.black &&
          italic == other.italic &&
          h1 == other.h1 &&
          h2 == other.h2 &&
          h3 == other.h3 &&
          h4 == other.h4 &&
          p == other.p &&
          blockQuote == other.blockQuote &&
          inlineCode == other.inlineCode &&
          lead == other.lead &&
          textLarge == other.textLarge &&
          textSmall == other.textSmall &&
          textMuted == other.textMuted;

  @override
  int get hashCode =>
      sans.hashCode ^
      mono.hashCode ^
      xSmall.hashCode ^
      small.hashCode ^
      base.hashCode ^
      large.hashCode ^
      xLarge.hashCode ^
      x2Large.hashCode ^
      x3Large.hashCode ^
      x4Large.hashCode ^
      x5Large.hashCode ^
      x6Large.hashCode ^
      x7Large.hashCode ^
      x8Large.hashCode ^
      x9Large.hashCode ^
      thin.hashCode ^
      light.hashCode ^
      extraLight.hashCode ^
      normal.hashCode ^
      medium.hashCode ^
      semiBold.hashCode ^
      bold.hashCode ^
      extraBold.hashCode ^
      black.hashCode ^
      italic.hashCode ^
      h1.hashCode ^
      h2.hashCode ^
      h3.hashCode ^
      h4.hashCode ^
      p.hashCode ^
      blockQuote.hashCode ^
      inlineCode.hashCode ^
      lead.hashCode ^
      textLarge.hashCode ^
      textSmall.hashCode ^
      textMuted.hashCode;

  @override
  String toString() {
    return 'Typography(sans: $sans, mono: $mono, xSmall: $xSmall, small: $small, base: $base, large: $large, xLarge: $xLarge, x2Large: $x2Large, x3Large: $x3Large, x4Large: $x4Large, x5Large: $x5Large, x6Large: $x6Large, x7Large: $x7Large, x8Large: $x8Large, x9Large: $x9Large, thin: $thin, light: $light, extraLight: $extraLight, normal: $normal, medium: $medium, semiBold: $semiBold, bold: $bold, extraBold: $extraBold, black: $black, italic: $italic, h1: $h1, h2: $h2, h3: $h3, h4: $h4, p: $p, blockQuote: $blockQuote, inlineCode: $inlineCode, lead: $lead, textLarge: $textLarge, textSmall: $textSmall, textMuted: $textMuted)';
  }
}
