import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';

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
  Widget call({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  });
}

/// Extension providing text styling modifiers for widgets.
///
/// This extension adds a fluent API for applying text styles to widgets.
/// Each property returns a [TextModifier] that can be further chained.
///
/// Example:
/// ```dart
/// Text('Hello').sans.large.bold.muted
/// ```
extension TextExtension on Widget {
  /// Applies sans-serif font family.
  TextModifier get sans => WrappedText(
        style: (context, theme) => theme.typography.sans,
        child: this,
      );

  /// Applies monospace font family.
  TextModifier get mono => WrappedText(
        style: (context, theme) => theme.typography.mono,
        child: this,
      );

  /// Applies extra-small font size.
  TextModifier get xSmall => WrappedText(
        style: (context, theme) => theme.typography.xSmall,
        child: this,
      );

  /// Applies small font size.
  TextModifier get small => WrappedText(
        style: (context, theme) => theme.typography.small,
        child: this,
      );

  /// Applies base (default) font size.
  TextModifier get base => WrappedText(
        style: (context, theme) => theme.typography.base,
        child: this,
      );

  /// Applies large font size.
  TextModifier get large => WrappedText(
        style: (context, theme) => theme.typography.large,
        child: this,
      );

  /// Applies extra-large font size.
  TextModifier get xLarge => WrappedText(
        style: (context, theme) => theme.typography.xLarge,
        child: this,
      );

  /// Applies 2x large font size.
  TextModifier get x2Large => WrappedText(
        style: (context, theme) => theme.typography.x2Large,
        child: this,
      );

  /// Applies 3x large font size.
  TextModifier get x3Large => WrappedText(
        style: (context, theme) => theme.typography.x3Large,
        child: this,
      );

  /// Applies 4x large font size.
  TextModifier get x4Large => WrappedText(
        style: (context, theme) => theme.typography.x4Large,
        child: this,
      );

  /// Applies 5x large font size.
  TextModifier get x5Large => WrappedText(
        style: (context, theme) => theme.typography.x5Large,
        child: this,
      );

  /// Applies 6x large font size.
  TextModifier get x6Large => WrappedText(
        style: (context, theme) => theme.typography.x6Large,
        child: this,
      );

  /// Applies 7x large font size.
  TextModifier get x7Large => WrappedText(
        style: (context, theme) => theme.typography.x7Large,
        child: this,
      );

  /// Applies 8x large font size.
  TextModifier get x8Large => WrappedText(
        style: (context, theme) => theme.typography.x8Large,
        child: this,
      );

  /// Applies 9x large font size.
  TextModifier get x9Large => WrappedText(
        style: (context, theme) => theme.typography.x9Large,
        child: this,
      );

  /// Applies thin font weight (100).
  TextModifier get thin => WrappedText(
        style: (context, theme) => theme.typography.thin,
        child: this,
      );

  /// Applies extra-light font weight (200).
  TextModifier get extraLight => WrappedText(
        style: (context, theme) => theme.typography.extraLight,
        child: this,
      );

  /// Applies light font weight (300).
  TextModifier get light => WrappedText(
        style: (context, theme) => theme.typography.light,
        child: this,
      );

  /// Applies normal font weight (400).
  TextModifier get normal => WrappedText(
        style: (context, theme) => theme.typography.normal,
        child: this,
      );

  /// Applies medium font weight (500).
  TextModifier get medium => WrappedText(
        style: (context, theme) => theme.typography.medium,
        child: this,
      );

  /// Applies semi-bold font weight (600).
  TextModifier get semiBold => WrappedText(
        style: (context, theme) => theme.typography.semiBold,
        child: this,
      );

  /// Applies bold font weight (700).
  TextModifier get bold => WrappedText(
        style: (context, theme) => theme.typography.bold,
        child: this,
      );

  /// Applies extra-bold font weight (800).
  TextModifier get extraBold => WrappedText(
        style: (context, theme) => theme.typography.extraBold,
        child: this,
      );

  /// Applies black font weight (900).
  TextModifier get black => WrappedText(
        style: (context, theme) => theme.typography.black,
        child: this,
      );

  /// Applies italic font style.
  TextModifier get italic => WrappedText(
        style: (context, theme) => theme.typography.italic,
        child: this,
      );

  /// Applies underline text decoration.
  TextModifier get underline => WrappedText(
        style: (context, theme) => const TextStyle(
          decoration: TextDecoration.underline,
        ),
        child: this,
      );

  /// Applies muted foreground color.
  TextModifier get muted => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.mutedForeground,
        ),
        child: this,
      );

  /// Applies primary foreground color.
  TextModifier get primaryForeground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.primaryForeground,
        ),
        child: this,
      );

  /// Applies secondary foreground color.
  TextModifier get secondaryForeground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.secondaryForeground,
        ),
        child: this,
      );

  /// Applies heading 1 style.
  TextModifier get h1 => WrappedText(
        style: (context, theme) => theme.typography.h1,
        child: this,
      );

  /// Applies heading 2 style with bottom border.
  TextModifier get h2 => WrappedText(
        style: (context, theme) => theme.typography.h2,
        wrapper: (context, child) => Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.border,
                width: 1,
              ),
            ),
          ),
          child: child,
        ),
        child: this,
      );

  /// Applies heading 3 style.
  TextModifier get h3 => WrappedText(
        style: (context, theme) => theme.typography.h3,
        child: this,
      );

  /// Applies heading 4 style.
  TextModifier get h4 => WrappedText(
        style: (context, theme) => theme.typography.h4,
        child: this,
      );

  /// Applies paragraph style with top spacing.
  TextModifier get p => WrappedText(
        style: (context, theme) => theme.typography.p,
        child: this,
        wrapper: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: child,
          );
        },
      );

  /// Applies paragraph style for the first paragraph (no top spacing).
  TextModifier get firstP => WrappedText(
        style: (context, theme) => theme.typography.p,
        child: this,
      );

  /// Applies block quote style with left border.
  TextModifier get blockQuote => WrappedText(
        style: (context, theme) => theme.typography.blockQuote,
        wrapper: (context, child) => Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.border,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 16),
          child: child,
        ),
        child: this,
      );

  /// Applies list item style with bullet point.
  ///
  /// Automatically adds a bullet point and indents nested list items.
  TextModifier get li => WrappedText(
        wrapper: (context, child) {
          UnorderedListData? data = Data.maybeOf(context);
          int depth = data?.depth ?? 0;
          TextStyle style = DefaultTextStyle.of(context).style;
          double size = (style.fontSize ?? 12) / 16 * 6;
          return IntrinsicWidth(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ((style.fontSize ?? 12) * (style.height ?? 1)) * 1.2,
                  child: getBullet(context, depth, size),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Data.inherit(
                      data: UnorderedListData(depth: depth + 1), child: child),
                ),
              ],
            ),
          );
        },
        child: this,
      );

  /// Applies inline code style with background and padding.
  TextModifier get inlineCode => WrappedText(
        style: (context, theme) => theme.typography.inlineCode,
        wrapper: (context, child) {
          final style = DefaultTextStyle.of(context).style;
          final double paddingVertical = style.fontSize! * 0.2;
          final double paddingHorizontal = style.fontSize! * 0.3;
          final ThemeData themeData = Theme.of(context);
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.muted,
              borderRadius: BorderRadius.circular(themeData.radiusSm),
            ),
            child: child,
          );
        },
        child: this,
      );

  /// Applies lead paragraph style with muted color.
  TextModifier get lead => WrappedText(
        style: (context, theme) => theme.typography.lead,
        child: this,
      ).muted;

  /// Applies large text style.
  TextModifier get textLarge => WrappedText(
        style: (context, theme) => theme.typography.textLarge,
        child: this,
      );

  /// Applies small text style.
  TextModifier get textSmall => WrappedText(
        style: (context, theme) => theme.typography.textSmall,
        child: this,
      );

  /// Applies muted text style with muted color.
  TextModifier get textMuted => WrappedText(
        style: (context, theme) => theme.typography.textMuted,
        child: this,
      ).muted;

  /// Constrains text to a single line without wrapping.
  TextModifier get singleLine => WrappedText(
        softWrap: (context, theme) => false,
        maxLines: (context, theme) => 1,
        child: this,
      );

  /// Applies ellipsis overflow to text.
  TextModifier get ellipsis => WrappedText(
        overflow: (context, theme) => TextOverflow.ellipsis,
        child: this,
      );

  /// Centers text horizontally.
  TextModifier get textCenter => WrappedText(
        textAlign: (context, theme) => TextAlign.center,
        child: this,
      );

  /// Right-aligns text.
  TextModifier get textRight => WrappedText(
        textAlign: (context, theme) => TextAlign.right,
        child: this,
      );

  /// Left-aligns text.
  TextModifier get textLeft => WrappedText(
        textAlign: (context, theme) => TextAlign.left,
        child: this,
      );

  /// Justifies text alignment.
  TextModifier get textJustify => WrappedText(
        textAlign: (context, theme) => TextAlign.justify,
        child: this,
      );

  /// Aligns text to the start (left in LTR, right in RTL).
  TextModifier get textStart => WrappedText(
        textAlign: (context, theme) => TextAlign.start,
        child: this,
      );

  /// Aligns text to the end (right in LTR, left in RTL).
  TextModifier get textEnd => WrappedText(
        textAlign: (context, theme) => TextAlign.end,
        child: this,
      );

  /// Applies primary foreground color modifier.
  TextModifier get modify => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.primaryForeground,
        ),
        child: this,
      );

  /// Applies standard foreground color.
  TextModifier get foreground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.foreground,
        ),
        child: this,
      );

  /// Appends an inline span to the current text widget.
  ///
  /// Allows chaining multiple text spans together. Works with [Text],
  /// [SelectableText], and [RichText] widgets.
  ///
  /// Parameters:
  /// - [span] (`InlineSpan`, required): The span to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended span.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello ').then(TextSpan(text: 'World'))
  /// ```
  Widget then(InlineSpan span) {
    if (this is RichText) {
      final text = this as RichText;
      return _RichTextThenWidget(text: text, then: [span]);
    }
    if (this is SelectableText) {
      final text = this as SelectableText;
      return _SelectableTextThenWidget(text: text, then: [span]);
    }
    if (this is Text) {
      final text = this as Text;
      return _TextThenWidget(text: text, then: [span]);
    }
    if (this is _RichTextThenWidget) {
      final text = this as _RichTextThenWidget;
      return _RichTextThenWidget(
        text: text.text,
        then: [...text.then, span],
      );
    }
    if (this is _TextThenWidget) {
      final text = this as _TextThenWidget;
      return _TextThenWidget(
        text: text.text,
        then: [...text.then, span],
      );
    }
    if (this is _SelectableTextThenWidget) {
      final text = this as _SelectableTextThenWidget;
      return _SelectableTextThenWidget(
        text: text.text,
        then: [...text.then, span],
      );
    }
    InlineSpan currentSpan = WidgetSpan(
      child: this,
    );
    return RichText(
      text: TextSpan(
        children: [currentSpan, span],
      ),
    );
  }

  /// Appends a text span to the current text widget.
  ///
  /// Convenience method for appending plain text.
  ///
  /// Parameters:
  /// - [text] (`String`, required): Text to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended text.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello ').thenText('World')
  /// ```
  Widget thenText(String text) {
    return then(TextSpan(text: text));
  }

  /// Appends inline code to the current text widget.
  ///
  /// The appended text is styled as inline code with background.
  ///
  /// Parameters:
  /// - [text] (`String`, required): Code text to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended code.
  ///
  /// Example:
  /// ```dart
  /// Text('Use ').thenInlineCode('myFunction()')
  /// ```
  Widget thenInlineCode(String text) {
    return then(
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Text(text).inlineCode(),
      ),
    );
  }

  /// Appends a button widget to the current text widget.
  ///
  /// Creates an inline button within the text flow.
  ///
  /// Parameters:
  /// - [onPressed] (`VoidCallback`, required): Button press handler.
  /// - [child] (`Widget`, required): Button content.
  ///
  /// Returns: `Widget` — a rich text widget with the appended button.
  ///
  /// Example:
  /// ```dart
  /// Text('Click ').thenButton(
  ///   onPressed: () => print('clicked'),
  ///   child: Text('here'),
  /// )
  /// ```
  Widget thenButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return then(
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Builder(builder: (context) {
          final defaultTextStyle = DefaultTextStyle.of(context);
          return Button(
            style: const ButtonStyle.link(
              density: ButtonDensity.compact,
            ),
            onPressed: onPressed,
            child: Builder(
              builder: (context) {
                final buttonTextStyle = DefaultTextStyle.of(context);
                return DefaultTextStyle(
                  style: defaultTextStyle.style.copyWith(
                    decoration: buttonTextStyle.style.decoration,
                  ),
                  overflow: defaultTextStyle.overflow,
                  maxLines: defaultTextStyle.maxLines,
                  softWrap: defaultTextStyle.softWrap,
                  textAlign: defaultTextStyle.textAlign,
                  textHeightBehavior: defaultTextStyle.textHeightBehavior,
                  textWidthBasis: defaultTextStyle.textWidthBasis,
                  child: child,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class _TextThenWidget extends StatelessWidget {
  final Text text;
  final List<InlineSpan> then;

  const _TextThenWidget({
    required this.text,
    required this.then,
  });

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = text.style;
    if (text.style == null || text.style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(text.style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    final SelectionRegistrar? registrar = SelectionContainer.maybeOf(context);
    Widget result = RichText(
      textAlign:
          text.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: text.textDirection,
      locale: text.locale,
      softWrap: text.softWrap ?? defaultTextStyle.softWrap,
      overflow: text.overflow ??
          effectiveTextStyle?.overflow ??
          defaultTextStyle.overflow,
      textScaler: text.textScaler ?? TextScaler.noScaling,
      maxLines: text.maxLines ?? defaultTextStyle.maxLines,
      strutStyle: text.strutStyle,
      textWidthBasis: text.textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.maybeOf(context),
      selectionRegistrar: registrar,
      selectionColor: text.selectionColor ??
          DefaultSelectionStyle.of(context).selectionColor ??
          DefaultSelectionStyle.defaultColor,
      text: TextSpan(
        style: effectiveTextStyle,
        children: [
          text.data == null ? text.textSpan! : TextSpan(text: text.data),
          ...then,
        ],
      ),
    );
    if (registrar != null) {
      result = MouseRegion(
        cursor: DefaultSelectionStyle.of(context).mouseCursor ??
            SystemMouseCursors.text,
        child: result,
      );
    }
    if (text.semanticsLabel != null) {
      result = Semantics(
        textDirection: text.textDirection,
        label: text.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}

class _RichTextThenWidget extends StatelessWidget {
  final RichText text;
  final List<InlineSpan> then;

  const _RichTextThenWidget({
    required this.text,
    required this.then,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      locale: text.locale,
      softWrap: text.softWrap,
      overflow: text.overflow,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      strutStyle: text.strutStyle,
      selectionColor: text.selectionColor,
      selectionRegistrar: text.selectionRegistrar,
      textScaler: text.textScaler,
      text: TextSpan(
        children: [
          text.text,
          ...then,
        ],
      ),
    );
  }
}

class _SelectableTextThenWidget extends StatelessWidget {
  final SelectableText text;
  final List<InlineSpan> then;

  const _SelectableTextThenWidget({
    required this.text,
    required this.then,
  });

  @override
  Widget build(BuildContext context) {
    String? stringData = text.data;
    TextSpan? textData = text.textSpan;
    return SelectableText.rich(
      TextSpan(
        text: stringData,
        children: [
          if (textData != null) textData,
          ...then,
        ],
      ),
      style: text.style,
      useNativeContextMenu: text.useNativeContextMenu,
      contextMenuBuilder: text.contextMenuBuilder,
      minLines: text.minLines,
      semanticsLabel: text.semanticsLabel,
      textScaler: text.textScaler,
      magnifierConfiguration: text.magnifierConfiguration,
      selectionHeightStyle: text.selectionHeightStyle,
      selectionWidthStyle: text.selectionWidthStyle,
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      strutStyle: text.strutStyle,
      selectionControls: text.selectionControls,
      onTap: text.onTap,
      scrollPhysics: text.scrollPhysics,
      showCursor: text.showCursor,
      cursorWidth: text.cursorWidth,
      cursorHeight: text.cursorHeight,
      cursorRadius: text.cursorRadius,
      cursorColor: text.cursorColor,
      dragStartBehavior: text.dragStartBehavior,
      enableInteractiveSelection: text.enableInteractiveSelection,
      autofocus: text.autofocus,
      focusNode: text.focusNode,
      onSelectionChanged: text.onSelectionChanged,
    );
  }
}

/// Creates a bullet widget for list items based on depth.
///
/// Returns different bullet styles for different nesting levels:
/// - Depth 0: Filled circle
/// - Depth 1: Hollow circle (stroke only)
/// - Depth 2+: Filled square
///
/// Parameters:
/// - [context] (`BuildContext`, required): Build context for theme access.
/// - [depth] (`int`, required): Nesting depth (0 = top level).
/// - [size] (`double`, required): Size of the bullet in logical pixels.
///
/// Returns: `Widget` — a centered bullet widget.
///
/// Example:
/// ```dart
/// getBullet(context, 0, 6.0) // Filled circle bullet
/// ```
Widget getBullet(BuildContext context, int depth, double size) {
  final themeData = Theme.of(context);
  if (depth == 0) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: themeData.colorScheme.foreground,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  if (depth == 1) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: themeData.colorScheme.foreground,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  return Center(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: themeData.colorScheme.foreground,
      ),
    ),
  );
}

/// Data class for tracking unordered list nesting depth.
///
/// Used internally by the list item modifier to handle bullet points
/// and indentation for nested lists.
class UnorderedListData {
  /// The nesting depth of the list (0 = top level).
  final int depth;

  /// Creates an [UnorderedListData].
  ///
  /// Parameters:
  /// - [depth] (`int`, default: 0): Nesting depth.
  const UnorderedListData({this.depth = 0});
}

/// Function signature for building data from context and theme.
///
/// Used by [WrappedText] to compute style properties dynamically.
///
/// Type parameter `T` is the return type of the builder function.
typedef WrappedTextDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);

/// Function signature for wrapping widgets with additional structure.
///
/// Used by [WrappedText] to add container widgets around text content.
typedef WidgetTextWrapper = Widget Function(BuildContext context, Widget child);

/// A widget that wraps text with customizable styling and layout.
///
/// [WrappedText] provides a declarative way to apply text styles and
/// transformations using builder functions. It implements [TextModifier]
/// and is the foundation for the fluent text styling API.
///
/// All style properties are computed dynamically using builder functions
/// that receive the current [BuildContext] and [ThemeData], enabling
/// theme-aware and responsive text styling.
class WrappedText extends StatelessWidget implements TextModifier {
  /// The child widget to wrap with styling.
  final Widget child;

  /// Builder for the text style.
  final WrappedTextDataBuilder<TextStyle?>? style;

  /// Builder for text alignment.
  final WrappedTextDataBuilder<TextAlign?>? textAlign;

  /// Builder for soft wrap behavior.
  final WrappedTextDataBuilder<bool?>? softWrap;

  /// Builder for text overflow handling.
  final WrappedTextDataBuilder<TextOverflow?>? overflow;

  /// Builder for maximum number of lines.
  final WrappedTextDataBuilder<int?>? maxLines;

  /// Builder for text width basis.
  final WrappedTextDataBuilder<TextWidthBasis?>? textWidthBasis;

  /// Optional wrapper function to add container widgets around the child.
  final WidgetTextWrapper? wrapper;

  /// Creates a [WrappedText].
  ///
  /// All styling parameters are optional and use builder functions for
  /// dynamic, theme-aware styling.
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget to apply styling to.
  /// - [style] (`WrappedTextDataBuilder<TextStyle?>?`, optional): Text style builder.
  /// - [textAlign] (`WrappedTextDataBuilder<TextAlign?>?`, optional): Text alignment builder.
  /// - [softWrap] (`WrappedTextDataBuilder<bool?>?`, optional): Soft wrap builder.
  /// - [overflow] (`WrappedTextDataBuilder<TextOverflow?>?`, optional): Overflow handling builder.
  /// - [maxLines] (`WrappedTextDataBuilder<int?>?`, optional): Max lines builder.
  /// - [textWidthBasis] (`WrappedTextDataBuilder<TextWidthBasis?>?`, optional): Text width basis builder.
  /// - [wrapper] (`WidgetTextWrapper?`, optional): Container wrapper function.
  const WrappedText({
    super.key,
    required this.child,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.wrapper,
  });

  @override
  Widget call({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    return copyWithStyle(
      (context, theme) => TextStyle(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      child: wrapper?.call(context, child) ?? child,
      style: style?.call(context, theme),
      textAlign: textAlign?.call(context, theme),
      softWrap: softWrap?.call(context, theme),
      overflow: overflow?.call(context, theme),
      maxLines: maxLines?.call(context, theme),
      textWidthBasis: textWidthBasis?.call(context, theme),
    );
  }

  /// Creates a copy of this [WrappedText] with modified properties.
  ///
  /// Each parameter is a builder function that, if provided, will
  /// replace the corresponding property in the new instance.
  /// If a parameter is `null`, the existing property value is retained.
  ///
  /// Parameters:
  /// - [style] (`ValueGetter<WrappedTextDataBuilder<TextStyle>?>?`, optional): New style builder.
  /// - [textAlign] (`ValueGetter<WrappedTextDataBuilder<TextAlign>?>?`, optional): New text alignment builder.
  /// - [softWrap] (`ValueGetter<WrappedTextDataBuilder<bool>?>?`, optional): New soft wrap builder.
  /// - [overflow] (`ValueGetter<WrappedTextDataBuilder<TextOverflow>?>?`, optional): New overflow handling builder.
  /// - [maxLines] (`ValueGetter<WrappedTextDataBuilder<int>?>?`, optional): New max lines builder.
  /// - [textWidthBasis] (`ValueGetter<WrappedTextDataBuilder<TextWidthBasis>?>?`, optional): New text width basis builder.
  /// - [wrapper] (`ValueGetter<WidgetTextWrapper?>?`, optional): New container wrapper function.
  /// - [child] (`ValueGetter<Widget>?`, optional): New child widget.
  WrappedText copyWith({
    ValueGetter<WrappedTextDataBuilder<TextStyle>?>? style,
    ValueGetter<WrappedTextDataBuilder<TextAlign>?>? textAlign,
    ValueGetter<WrappedTextDataBuilder<bool>?>? softWrap,
    ValueGetter<WrappedTextDataBuilder<TextOverflow>?>? overflow,
    ValueGetter<WrappedTextDataBuilder<int>?>? maxLines,
    ValueGetter<WrappedTextDataBuilder<TextWidthBasis>?>? textWidthBasis,
    ValueGetter<WidgetTextWrapper?>? wrapper,
    ValueGetter<Widget>? child,
  }) {
    return WrappedText(
      wrapper: wrapper == null ? this.wrapper : wrapper(),
      style: style == null ? this.style : style(),
      textAlign: textAlign == null ? this.textAlign : textAlign(),
      softWrap: softWrap == null ? this.softWrap : softWrap(),
      overflow: overflow == null ? this.overflow : overflow(),
      maxLines: maxLines == null ? this.maxLines : maxLines(),
      textWidthBasis:
          textWidthBasis == null ? this.textWidthBasis : textWidthBasis(),
      child: child == null ? this.child : child(),
    );
  }

  /// Creates a copy of this [WrappedText] with an updated style.
  ///
  /// The provided [style] builder is merged with the existing style.
  ///
  /// Parameters:
  /// - [style] (`WrappedTextDataBuilder<TextStyle>`, required): New style builder to merge.
  WrappedText copyWithStyle(WrappedTextDataBuilder<TextStyle> style) {
    return WrappedText(
      wrapper: wrapper,
      style: (context, theme) =>
          style(context, theme).merge(this.style?.call(context, theme)),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: child,
    );
  }
}
