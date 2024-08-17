class ShadcnFont {
  final String asset;
  final int? weight;
  const ShadcnFont({required this.asset, this.weight});
}

class ShadcnFontFamily {
  final String family;
  final List<ShadcnFont> fonts;
  const ShadcnFontFamily({required this.family, required this.fonts});
}

const kRadixIcons = ShadcnFontFamily(
  family: 'RadixIcons',
  fonts: [
    ShadcnFont(asset: 'packages/shadcn_flutter/icons/RadixIcons.otf'),
  ],
);

const kBootstrapIcons = ShadcnFontFamily(
  family: 'BootstrapIcons',
  fonts: [
    ShadcnFont(asset: 'packages/shadcn_flutter/icons/BootstrapIcons.otf'),
  ],
);

const kGeistSansFont = ShadcnFontFamily(
  family: 'GeistSans',
  fonts: [
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-Black.otf', weight: 800),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-Bold.otf', weight: 700),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-Light.otf', weight: 300),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-Medium.otf', weight: 500),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-SemiBold.otf', weight: 600),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-Thin.otf', weight: 100),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-UltraBlack.otf',
        weight: 900),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-UltraLight.otf',
        weight: 200),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/Geist-Regular.otf', weight: 400),
  ],
);

const kGeistMonoFont = ShadcnFontFamily(
  family: 'GeistMono',
  fonts: [
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-Black.otf',
        weight: 800),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-Bold.otf', weight: 700),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-Light.otf',
        weight: 300),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-Medium.otf',
        weight: 500),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-Regular.otf',
        weight: 400),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-SemiBold.otf',
        weight: 600),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-Thin.otf', weight: 100),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-UltraBlack.otf',
        weight: 900),
    ShadcnFont(
        asset: 'packages/shadcn_flutter/fonts/GeistMono-UltraLight.otf',
        weight: 200),
  ],
);
