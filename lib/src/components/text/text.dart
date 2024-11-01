import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';

extension TextExtension on Widget {
  Widget sans() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.sans,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.sans, child: this);
  }

  Widget mono() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.mono,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.mono, child: this);
  }

  Widget xSmall() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.xSmall,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.xSmall, child: this);
  }

  Widget small() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.small,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.small, child: this);
  }

  Widget base() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.base,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.base, child: this);
  }

  Widget large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.large, child: this);
  }

  Widget xLarge() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.xLarge,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.xLarge, child: this);
  }

  Widget x2Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x2Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x2Large, child: this);
  }

  Widget x3Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x3Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x3Large, child: this);
  }

  Widget x4Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x4Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x4Large, child: this);
  }

  Widget x5Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x5Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x5Large, child: this);
  }

  Widget x6Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x6Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x6Large, child: this);
  }

  Widget x7Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x7Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x7Large, child: this);
  }

  Widget x8Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x8Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x8Large, child: this);
  }

  Widget x9Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.x9Large,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.x9Large, child: this);
  }

  Widget thin() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.thin,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.thin, child: this);
  }

  Widget extraLight() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.extraLight,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.extraLight, child: this);
  }

  Widget light() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.light,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.light, child: this);
  }

  Widget normal() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.normal,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.normal, child: this);
  }

  Widget medium() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.medium,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.medium, child: this);
  }

  Widget semiBold() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.semiBold,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.semiBold, child: this);
  }

  Widget bold() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.bold,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.bold, child: this);
  }

  Widget extraBold() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.extraBold,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.extraBold, child: this);
  }

  Widget black() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.black,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.black, child: this);
  }

  Widget italic() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.italic,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.italic, child: this);
  }

  Widget underline() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => const TextStyle(
          decoration: TextDecoration.underline,
        ),
      );
    }
    return WrappedText(
        style: (context, theme) => const TextStyle(
              decoration: TextDecoration.underline,
            ),
        child: this);
  }

  Widget muted() {
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return DefaultTextStyle.merge(
          child: this,
          style: TextStyle(
            color: themeData.colorScheme.mutedForeground,
          ),
        );
      },
    );
  }

  Widget primaryForeground() {
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return DefaultTextStyle.merge(
          child: this,
          style: TextStyle(
            color: themeData.colorScheme.primaryForeground,
          ),
        );
      },
    );
  }

  Widget secondaryForeground() {
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return DefaultTextStyle.merge(
          child: this,
          style: TextStyle(
            color: themeData.colorScheme.secondaryForeground,
          ),
        );
      },
    );
  }

  Widget h1() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.h1,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.h1, child: this);
  }

  Widget h2() {
    return Builder(builder: (context) {
      Widget child;
      if (this is WrappedText) {
        child = (this as WrappedText).copyWithStyle(
          (context, theme) => theme.typography.h2,
        );
      } else {
        child = WrappedText(
            style: (context, theme) => theme.typography.h2, child: this);
      }
      return Container(
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
      );
    });
  }

  Widget h3() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.h3,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.h3, child: this);
  }

  Widget h4() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.h4,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.h4, child: this);
  }

  Widget p({bool firstChild = false}) {
    Widget child;
    if (this is WrappedText) {
      child = (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.p,
      );
    } else {
      child = WrappedText(
          style: (context, theme) => theme.typography.p, child: this);
    }
    if (firstChild) {
      return child;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: child,
    );
  }

  Widget blockQuote() {
    return Builder(builder: (context) {
      Widget child;
      if (this is WrappedText) {
        child = (this as WrappedText).copyWithStyle(
          (context, theme) => theme.typography.blockQuote,
        );
      } else {
        child = WrappedText(
            style: (context, theme) => theme.typography.blockQuote,
            child: this);
      }
      return Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.border,
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.only(left: 16),
        // child: base().normal().italic(),
        child: child,
      );
    });
  }

  Widget li() {
    return Builder(
      builder: (context) {
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
                    data: UnorderedListData(depth: depth + 1), child: this),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget inlineCode() {
    return Builder(builder: (context) {
      final style = DefaultTextStyle.of(context).style;
      final double paddingVertical = style.fontSize! * 0.2;
      final double paddingHorizontal = style.fontSize! * 0.3;
      final ThemeData themeData = Theme.of(context);
      Widget child;
      if (this is WrappedText) {
        child = (this as WrappedText).copyWithStyle(
          (context, theme) => theme.typography.inlineCode,
        );
      } else {
        child = WrappedText(
            style: (context, theme) => theme.typography.inlineCode,
            child: this);
      }
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
    });
  }

  Widget lead() {
    if (this is WrappedText) {
      return (this as WrappedText)
          .copyWithStyle(
            (context, theme) => theme.typography.lead,
          )
          .muted();
    }
    return WrappedText(
            style: (context, theme) => theme.typography.lead, child: this)
        .muted();
  }

  Widget textLarge() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.textLarge,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.textLarge, child: this);
  }

  Widget textSmall() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        (context, theme) => theme.typography.textSmall,
      );
    }
    return WrappedText(
        style: (context, theme) => theme.typography.textSmall, child: this);
  }

  Widget textMuted() {
    if (this is WrappedText) {
      return (this as WrappedText)
          .copyWithStyle(
            (context, theme) => theme.typography.textMuted,
          )
          .muted();
    }
    return WrappedText(
            style: (context, theme) => theme.typography.textMuted, child: this)
        .muted();
  }

  Widget singleLine() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        softWrap: (context, theme) => false,
        maxLines: (context, theme) => 1,
      );
    }
    return WrappedText(
      softWrap: (context, theme) => false,
      maxLines: (context, theme) => 1,
      child: this,
    );
  }

  Widget ellipsis() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        overflow: (context, theme) => TextOverflow.ellipsis,
      );
    }
    return WrappedText(
      overflow: (context, theme) => TextOverflow.ellipsis,
      child: this,
    );
  }

  Widget textCenter() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        textAlign: (context, theme) => TextAlign.center,
      );
    }
    return WrappedText(
      textAlign: (context, theme) => TextAlign.center,
      child: this,
    );
  }

  Widget textRight() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        textAlign: (context, theme) => TextAlign.right,
      );
    }
    return WrappedText(
      textAlign: (context, theme) => TextAlign.right,
      child: this,
    );
  }

  Widget textLeft() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        textAlign: (context, theme) => TextAlign.left,
      );
    }
    return WrappedText(
      textAlign: (context, theme) => TextAlign.left,
      child: this,
    );
  }

  Widget textJustify() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        textAlign: (context, theme) => TextAlign.justify,
      );
    }
    return WrappedText(
      textAlign: (context, theme) => TextAlign.justify,
      child: this,
    );
  }

  Widget textStart() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        textAlign: (context, theme) => TextAlign.start,
      );
    }
    return WrappedText(
      textAlign: (context, theme) => TextAlign.start,
      child: this,
    );
  }

  Widget textEnd() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        textAlign: (context, theme) => TextAlign.end,
      );
    }
    return WrappedText(
      textAlign: (context, theme) => TextAlign.end,
      child: this,
    );
  }

  Widget foreground() {
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return DefaultTextStyle.merge(
          child: this,
          style: TextStyle(
            color: themeData.colorScheme.foreground,
          ),
        );
      },
    );
  }

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
      textDirection: text
          .textDirection, // RichText uses Directionality.of to obtain a default if this is null.
      locale: text
          .locale, // RichText uses Localizations.localeOf to obtain a default if this is null
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

class WrappedText extends StatelessWidget {
  final Widget child;
  final WrappedTextDataBuilder<TextStyle>? style;
  final WrappedTextDataBuilder<TextAlign>? textAlign;
  final WrappedTextDataBuilder<bool>? softWrap;
  final WrappedTextDataBuilder<TextOverflow>? overflow;
  final WrappedTextDataBuilder<int>? maxLines;
  final WrappedTextDataBuilder<TextWidthBasis>? textWidthBasis;

  const WrappedText({
    super.key,
    required this.child,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      child: child,
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
    Widget? child,
  }) {
    return WrappedText(
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
