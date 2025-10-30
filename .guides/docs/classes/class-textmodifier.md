---
title: "Class: TextModifier"
description: "Abstract base class for text modifier widgets."
---

```dart
/// Abstract base class for text modifier widgets.
///
/// Text modifiers provide a fluent API for applying text styles and
/// transformations. They extend [Widget] and can be called as functions
/// to apply additional style properties.
///
/// Use the [TextExtension] methods to create and chain text modifiers.
abstract class TextModifier extends Widget {
  /// Creates a [TextModifier].
  const TextModifier({super.key});
  /// Applies additional text style properties to this modifier.
  ///
  /// All parameters are optional and can be used to override or extend
  /// the current text styling.
  ///
  /// Parameters:
  /// - [color] (`Color?`, optional): Text color.
  /// - [backgroundColor] (`Color?`, optional): Background color for text.
  /// - [fontSize] (`double?`, optional): Font size in logical pixels.
  /// - [fontWeight] (`FontWeight?`, optional): Font weight (e.g., bold, normal).
  /// - [fontStyle] (`FontStyle?`, optional): Font style (e.g., italic, normal).
  /// - [letterSpacing] (`double?`, optional): Space between letters.
  /// - [wordSpacing] (`double?`, optional): Space between words.
  /// - [textBaseline] (`TextBaseline?`, optional): Text baseline alignment.
  /// - [height] (`double?`, optional): Line height multiplier.
  /// - [leadingDistribution] (`TextLeadingDistribution?`, optional): How to distribute line height.
  /// - [locale] (`Locale?`, optional): Locale for font selection.
  /// - [foreground] (`Paint?`, optional): Custom foreground paint.
  /// - [background] (`Paint?`, optional): Custom background paint.
  /// - [shadows] (`List<Shadow>?`, optional): Text shadows.
  /// - [fontFeatures] (`List<FontFeature>?`, optional): OpenType font features.
  /// - [fontVariations] (`List<FontVariation>?`, optional): Font variations.
  /// - [decoration] (`TextDecoration?`, optional): Text decoration (underline, etc.).
  /// - [decorationColor] (`Color?`, optional): Decoration color.
  /// - [decorationStyle] (`TextDecorationStyle?`, optional): Decoration style.
  /// - [decorationThickness] (`double?`, optional): Decoration thickness.
  /// - [debugLabel] (`String?`, optional): Debug label for text style.
  /// - [fontFamily] (`String?`, optional): Font family name.
  /// - [fontFamilyFallback] (`List<String>?`, optional): Fallback font families.
  /// - [package] (`String?`, optional): Package containing the font.
  /// - [overflow] (`TextOverflow?`, optional): How to handle text overflow.
  ///
  /// Returns: `Widget` — the modified text widget.
  Widget call({Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow});
}
```
