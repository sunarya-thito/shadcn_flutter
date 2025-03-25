import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';

abstract class TextModifier extends Widget {
  const TextModifier({super.key});

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

extension TextExtension on Widget {
  TextModifier get sans => WrappedText(
        style: (context, theme) => theme.typography.sans,
        child: this,
      );

  TextModifier get mono => WrappedText(
        style: (context, theme) => theme.typography.mono,
        child: this,
      );

  TextModifier get xSmall => WrappedText(
        style: (context, theme) => theme.typography.xSmall,
        child: this,
      );

  TextModifier get small => WrappedText(
        style: (context, theme) => theme.typography.small,
        child: this,
      );

  TextModifier get base => WrappedText(
        style: (context, theme) => theme.typography.base,
        child: this,
      );

  TextModifier get large => WrappedText(
        style: (context, theme) => theme.typography.large,
        child: this,
      );

  TextModifier get xLarge => WrappedText(
        style: (context, theme) => theme.typography.xLarge,
        child: this,
      );

  TextModifier get x2Large => WrappedText(
        style: (context, theme) => theme.typography.x2Large,
        child: this,
      );

  TextModifier get x3Large => WrappedText(
        style: (context, theme) => theme.typography.x3Large,
        child: this,
      );

  TextModifier get x4Large => WrappedText(
        style: (context, theme) => theme.typography.x4Large,
        child: this,
      );

  TextModifier get x5Large => WrappedText(
        style: (context, theme) => theme.typography.x5Large,
        child: this,
      );

  TextModifier get x6Large => WrappedText(
        style: (context, theme) => theme.typography.x6Large,
        child: this,
      );

  TextModifier get x7Large => WrappedText(
        style: (context, theme) => theme.typography.x7Large,
        child: this,
      );

  TextModifier get x8Large => WrappedText(
        style: (context, theme) => theme.typography.x8Large,
        child: this,
      );

  TextModifier get x9Large => WrappedText(
        style: (context, theme) => theme.typography.x9Large,
        child: this,
      );

  TextModifier get thin => WrappedText(
        style: (context, theme) => theme.typography.thin,
        child: this,
      );

  TextModifier get extraLight => WrappedText(
        style: (context, theme) => theme.typography.extraLight,
        child: this,
      );

  TextModifier get light => WrappedText(
        style: (context, theme) => theme.typography.light,
        child: this,
      );

  TextModifier get normal => WrappedText(
        style: (context, theme) => theme.typography.normal,
        child: this,
      );

  TextModifier get medium => WrappedText(
        style: (context, theme) => theme.typography.medium,
        child: this,
      );

  TextModifier get semiBold => WrappedText(
        style: (context, theme) => theme.typography.semiBold,
        child: this,
      );

  TextModifier get bold => WrappedText(
        style: (context, theme) => theme.typography.bold,
        child: this,
      );

  TextModifier get extraBold => WrappedText(
        style: (context, theme) => theme.typography.extraBold,
        child: this,
      );

  TextModifier get black => WrappedText(
        style: (context, theme) => theme.typography.black,
        child: this,
      );

  TextModifier get italic => WrappedText(
        style: (context, theme) => theme.typography.italic,
        child: this,
      );

  TextModifier get underline => WrappedText(
        style: (context, theme) => const TextStyle(
          decoration: TextDecoration.underline,
        ),
        child: this,
      );

  TextModifier get muted => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.mutedForeground,
        ),
        child: this,
      );

  TextModifier get primaryForeground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.primaryForeground,
        ),
        child: this,
      );

  TextModifier get secondaryForeground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.secondaryForeground,
        ),
        child: this,
      );

  TextModifier get h1 => WrappedText(
        style: (context, theme) => theme.typography.h1,
        child: this,
      );

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

  TextModifier get h3 => WrappedText(
        style: (context, theme) => theme.typography.h3,
        child: this,
      );

  TextModifier get h4 => WrappedText(
        style: (context, theme) => theme.typography.h4,
        child: this,
      );

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

  TextModifier get firstP => WrappedText(
        style: (context, theme) => theme.typography.p,
        child: this,
      );

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

  TextModifier get lead => WrappedText(
        style: (context, theme) => theme.typography.lead,
        child: this,
      ).muted;

  TextModifier get textLarge => WrappedText(
        style: (context, theme) => theme.typography.textLarge,
        child: this,
      );

  TextModifier get textSmall => WrappedText(
        style: (context, theme) => theme.typography.textSmall,
        child: this,
      );

  TextModifier get textMuted => WrappedText(
        style: (context, theme) => theme.typography.textMuted,
        child: this,
      ).muted;

  TextModifier get singleLine => WrappedText(
        softWrap: (context, theme) => false,
        maxLines: (context, theme) => 1,
        child: this,
      );

  TextModifier get ellipsis => WrappedText(
        overflow: (context, theme) => TextOverflow.ellipsis,
        child: this,
      );

  TextModifier get textCenter => WrappedText(
        textAlign: (context, theme) => TextAlign.center,
        child: this,
      );

  TextModifier get textRight => WrappedText(
        textAlign: (context, theme) => TextAlign.right,
        child: this,
      );

  TextModifier get textLeft => WrappedText(
        textAlign: (context, theme) => TextAlign.left,
        child: this,
      );

  TextModifier get textJustify => WrappedText(
        textAlign: (context, theme) => TextAlign.justify,
        child: this,
      );

  TextModifier get textStart => WrappedText(
        textAlign: (context, theme) => TextAlign.start,
        child: this,
      );

  TextModifier get textEnd => WrappedText(
        textAlign: (context, theme) => TextAlign.end,
        child: this,
      );

  TextModifier get modify => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.primaryForeground,
        ),
        child: this,
      );

  TextModifier get foreground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.foreground,
        ),
        child: this,
      );

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

  Widget thenText(String text) {
    return then(TextSpan(text: text));
  }

  Widget thenInlineCode(String text) {
    return then(
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Text(text).inlineCode(),
      ),
    );
  }

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

class UnorderedListData {
  final int depth;

  const UnorderedListData({this.depth = 0});
}

typedef WrappedTextDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);
typedef WidgetTextWrapper = Widget Function(BuildContext context, Widget child);

class WrappedText extends StatelessWidget implements TextModifier {
  final Widget child;
  final WrappedTextDataBuilder<TextStyle?>? style;
  final WrappedTextDataBuilder<TextAlign?>? textAlign;
  final WrappedTextDataBuilder<bool?>? softWrap;
  final WrappedTextDataBuilder<TextOverflow?>? overflow;
  final WrappedTextDataBuilder<int?>? maxLines;
  final WrappedTextDataBuilder<TextWidthBasis?>? textWidthBasis;
  final WidgetTextWrapper? wrapper;

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

  WrappedText copyWith({
    WrappedTextDataBuilder<TextStyle>? style,
    WrappedTextDataBuilder<TextAlign>? textAlign,
    WrappedTextDataBuilder<bool>? softWrap,
    WrappedTextDataBuilder<TextOverflow>? overflow,
    WrappedTextDataBuilder<int>? maxLines,
    WrappedTextDataBuilder<TextWidthBasis>? textWidthBasis,
    WidgetTextWrapper? wrapper,
    Widget? child,
  }) {
    return WrappedText(
      wrapper: wrapper ?? this.wrapper,
      style: style ?? this.style,
      textAlign: textAlign ?? this.textAlign,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      child: child ?? this.child,
    );
  }

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
