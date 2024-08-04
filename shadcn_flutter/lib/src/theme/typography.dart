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
}
