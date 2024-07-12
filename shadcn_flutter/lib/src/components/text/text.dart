import '../../../shadcn_flutter.dart';

extension TextExtension on Widget {
  Widget sans() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontFamily: 'GeistSans'),
      );
    }
    return WrappedText(
        style: const TextStyle(fontFamily: 'GeistSans'), child: this);
  }

  Widget mono() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontFamily: 'GeistMono'),
      );
    }
    return WrappedText(
        style: const TextStyle(fontFamily: 'GeistMono'), child: this);
  }

  Widget xSmall() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 12, height: 16 / 12),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 12, height: 16 / 12), child: this);
  }

  Widget small() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 14, height: 20.0 / 14),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 14, height: 20.0 / 14), child: this);
  }

  Widget base() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 16, height: 24 / 16),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 16, height: 24 / 16), child: this);
  }

  Widget large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 18, height: 28 / 18),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 18, height: 28 / 18), child: this);
  }

  Widget xLarge() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 20, height: 28 / 20),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 20, height: 28 / 20), child: this);
  }

  Widget x2Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 24, height: 32 / 24),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 24, height: 32 / 24), child: this);
  }

  Widget x3Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 30, height: 36 / 30),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 30, height: 36 / 30), child: this);
  }

  Widget x4Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 36, height: 40 / 36),
      );
    }
    return WrappedText(
        style: const TextStyle(fontSize: 36, height: 40 / 36), child: this);
  }

  Widget x5Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 48),
      );
    }
    return WrappedText(style: const TextStyle(fontSize: 48), child: this);
  }

  Widget x6Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 60),
      );
    }
    return WrappedText(style: const TextStyle(fontSize: 60), child: this);
  }

  Widget x7Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 72),
      );
    }
    return WrappedText(style: const TextStyle(fontSize: 72), child: this);
  }

  Widget x8Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 96),
      );
    }
    return WrappedText(style: const TextStyle(fontSize: 96), child: this);
  }

  Widget x9Large() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontSize: 128),
      );
    }
    return WrappedText(style: const TextStyle(fontSize: 144), child: this);
  }

  Widget thin() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w100),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w100), child: this);
  }

  Widget extraLight() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w200),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w200), child: this);
  }

  Widget light() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w300),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w300), child: this);
  }

  Widget normal() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.normal),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.normal), child: this);
  }

  Widget medium() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w500),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w500), child: this);
  }

  Widget semiBold() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w600),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w600), child: this);
  }

  Widget bold() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.bold),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.bold), child: this);
  }

  Widget extraBold() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w800),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w800), child: this);
  }

  Widget black() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontWeight: FontWeight.w900),
      );
    }
    return WrappedText(
        style: const TextStyle(fontWeight: FontWeight.w900), child: this);
  }

  Widget italic() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWithStyle(
        const TextStyle(fontStyle: FontStyle.italic),
      );
    }
    return WrappedText(
        style: const TextStyle(fontStyle: FontStyle.italic), child: this);
  }

  Widget underline() {
    if (this is UnderlineText) {
      return this;
    }
    return UnderlineText(child: this);
  }

  Widget muted() {
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return mergeAnimatedTextStyle(
          child: this,
          duration: kDefaultDuration,
          style: TextStyle(
            color: themeData.colorScheme.mutedForeground,
          ),
        );
      },
    );
  }

  Widget h1() {
    return x4Large().extraBold();
  }

  Widget h2() {
    return Builder(builder: (context) {
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
        child: x3Large().semiBold(),
      );
    });
  }

  Widget h3() {
    return x2Large().semiBold();
  }

  Widget h4() {
    return xLarge().semiBold();
  }

  Widget p({bool firstChild = false}) {
    if (firstChild) {
      return base().normal();
    }
    return base().normal().withPadding(top: 24);
  }

  Widget blockQuote() {
    return Builder(builder: (context) {
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
        child: base().normal().italic(),
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
                height: (style.fontSize ?? 12) * (style.height ?? 1.5),
                child: getBullet(context, depth, size),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Data(
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
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.muted,
          borderRadius: BorderRadius.circular(themeData.radiusSm),
        ),
        child: mono().small().semiBold(),
      );
    });
  }

  Widget lead() {
    return xLarge().muted();
  }

  Widget textLarge() {
    return large().semiBold();
  }

  Widget textSmall() {
    return small().medium();
  }

  Widget textMuted() {
    return small().muted();
  }

  Widget singleLine() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        softWrap: false,
        maxLines: 1,
      );
    }
    return WrappedText(
      softWrap: false,
      maxLines: 1,
      child: this,
    );
  }

  Widget ellipsis() {
    if (this is WrappedText) {
      return (this as WrappedText).copyWith(
        overflow: TextOverflow.ellipsis,
      );
    }
    return WrappedText(
      overflow: TextOverflow.ellipsis,
      child: this,
    );
  }

  Widget foreground() {
    return Builder(
      builder: (context) {
        final themeData = Theme.of(context);
        return mergeAnimatedTextStyle(
          child: this,
          duration: kDefaultDuration,
          style: TextStyle(
            color: themeData.colorScheme.foreground,
          ),
        );
      },
    );
  }

  Widget then(InlineSpan span) {
    if (this is RichText) {
      return RichText(
        text: TextSpan(children: [
          (this as RichText).text,
          span,
        ]),
      );
    }
    InlineSpan currentSpan = WidgetSpan(child: this);
    return RichText(
      text: TextSpan(
        children: [currentSpan, span],
      ),
    );
  }

  Widget thenText(String text) {
    return then(TextSpan(text: text));
  }

  Widget thenButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return then(
      WidgetSpan(
        child: Builder(builder: (context) {
          final textStyle = DefaultTextStyle.of(context);
          return Button(
            style: ButtonStyle.link(
              density: ButtonDensity.compact,
            ),
            onPressed: onPressed,
            child: DefaultTextStyle(style: textStyle.style, child: child),
          );
        }),
      ),
    );
  }
}

Widget getBullet(BuildContext context, int depth, double size) {
  final themeData = Theme.of(context);
  final TextStyle style = DefaultTextStyle.of(context).style;
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

class WrappedText extends StatelessWidget {
  final Widget child;
  final TextStyle? style;

  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;

  const WrappedText({
    Key? key,
    required this.child,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      child: child,
      duration: kDefaultDuration,
      style: style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
    );
  }

  WrappedText copyWith({
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
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

  WrappedText copyWithStyle(TextStyle style) {
    return WrappedText(
      style: this.style?.merge(style) ?? style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: child,
    );
  }
}
