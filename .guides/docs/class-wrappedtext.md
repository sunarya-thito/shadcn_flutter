---
title: "Class: WrappedText"
description: "Reference for WrappedText"
---

```dart
class WrappedText extends StatelessWidget implements TextModifier {
  final Widget child;
  final WrappedTextDataBuilder<TextStyle?>? style;
  final WrappedTextDataBuilder<TextAlign?>? textAlign;
  final WrappedTextDataBuilder<bool?>? softWrap;
  final WrappedTextDataBuilder<TextOverflow?>? overflow;
  final WrappedTextDataBuilder<int?>? maxLines;
  final WrappedTextDataBuilder<TextWidthBasis?>? textWidthBasis;
  final WidgetTextWrapper? wrapper;
  const WrappedText({super.key, required this.child, this.style, this.textAlign, this.softWrap, this.overflow, this.maxLines, this.textWidthBasis, this.wrapper});
  Widget call({Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow});
  Widget build(BuildContext context);
  WrappedText copyWith({ValueGetter<WrappedTextDataBuilder<TextStyle>?>? style, ValueGetter<WrappedTextDataBuilder<TextAlign>?>? textAlign, ValueGetter<WrappedTextDataBuilder<bool>?>? softWrap, ValueGetter<WrappedTextDataBuilder<TextOverflow>?>? overflow, ValueGetter<WrappedTextDataBuilder<int>?>? maxLines, ValueGetter<WrappedTextDataBuilder<TextWidthBasis>?>? textWidthBasis, ValueGetter<WidgetTextWrapper?>? wrapper, ValueGetter<Widget>? child});
  WrappedText copyWithStyle(WrappedTextDataBuilder<TextStyle> style);
}
```
