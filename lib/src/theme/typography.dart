import '../../shadcn_flutter.dart';

class Typography {
  final TextStyle sans;
  final TextStyle mono;
  final TextStyle xSmall;
  final TextStyle small;
  final TextStyle base;
  final TextStyle large;
  final TextStyle xLarge;
  final TextStyle x2Large;
  final TextStyle x3Large;
  final TextStyle x4Large;
  final TextStyle x5Large;
  final TextStyle x6Large;
  final TextStyle x7Large;
  final TextStyle x8Large;
  final TextStyle x9Large;
  final TextStyle thin;
  final TextStyle light;
  final TextStyle extraLight;
  final TextStyle normal;
  final TextStyle medium;
  final TextStyle semiBold;
  final TextStyle bold;
  final TextStyle extraBold;
  final TextStyle black;
  final TextStyle italic;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle p;
  final TextStyle blockQuote;
  final TextStyle inlineCode;
  final TextStyle lead;
  final TextStyle textLarge;
  final TextStyle textSmall;
  final TextStyle textMuted;

  const Typography.geist({
    this.sans = const TextStyle(fontFamily: 'GeistSans'),
    this.mono = const TextStyle(fontFamily: 'GeistMono'),
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

  Typography copyWith({
    TextStyle? sans,
    TextStyle? mono,
    TextStyle? xSmall,
    TextStyle? small,
    TextStyle? base,
    TextStyle? large,
    TextStyle? xLarge,
    TextStyle? x2Large,
    TextStyle? x3Large,
    TextStyle? x4Large,
    TextStyle? x5Large,
    TextStyle? x6Large,
    TextStyle? x7Large,
    TextStyle? x8Large,
    TextStyle? x9Large,
    TextStyle? thin,
    TextStyle? light,
    TextStyle? extraLight,
    TextStyle? normal,
    TextStyle? medium,
    TextStyle? semiBold,
    TextStyle? bold,
    TextStyle? extraBold,
    TextStyle? black,
    TextStyle? italic,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? p,
    TextStyle? blockQuote,
    TextStyle? inlineCode,
    TextStyle? lead,
    TextStyle? textLarge,
    TextStyle? textSmall,
    TextStyle? textMuted,
  }) {
    return Typography(
      sans: sans ?? this.sans,
      mono: mono ?? this.mono,
      xSmall: xSmall ?? this.xSmall,
      small: small ?? this.small,
      base: base ?? this.base,
      large: large ?? this.large,
      xLarge: xLarge ?? this.xLarge,
      x2Large: x2Large ?? this.x2Large,
      x3Large: x3Large ?? this.x3Large,
      x4Large: x4Large ?? this.x4Large,
      x5Large: x5Large ?? this.x5Large,
      x6Large: x6Large ?? this.x6Large,
      x7Large: x7Large ?? this.x7Large,
      x8Large: x8Large ?? this.x8Large,
      x9Large: x9Large ?? this.x9Large,
      thin: thin ?? this.thin,
      light: light ?? this.light,
      extraLight: extraLight ?? this.extraLight,
      normal: normal ?? this.normal,
      medium: medium ?? this.medium,
      semiBold: semiBold ?? this.semiBold,
      bold: bold ?? this.bold,
      extraBold: extraBold ?? this.extraBold,
      black: black ?? this.black,
      italic: italic ?? this.italic,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      p: p ?? this.p,
      blockQuote: blockQuote ?? this.blockQuote,
      inlineCode: inlineCode ?? this.inlineCode,
      lead: lead ?? this.lead,
      textLarge: textLarge ?? this.textLarge,
      textSmall: textSmall ?? this.textSmall,
      textMuted: textMuted ?? this.textMuted,
    );
  }

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
