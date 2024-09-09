import '../../../shadcn_flutter.dart';

class UnderlineInterceptor extends StatelessWidget {
  final Widget child;

  const UnderlineInterceptor({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var def = DefaultTextStyle.of(context);
    if (def.style.decoration == TextDecoration.underline) {
      return DefaultTextStyle.merge(
        style: def.style.copyWith(decoration: TextDecoration.none),
        child: UnderlineText(child: child),
      );
    }
    return child;
  }
}

class UnderlineText extends StatelessWidget {
  final Widget child;
  final bool underline;
  final bool translate;

  const UnderlineText({
    super.key,
    required this.child,
    this.underline = true,
    this.translate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    Color? underlineColor;
    TextStyle textStyle = DefaultTextStyle.of(context).style;
    underlineColor = textStyle.decorationColor ?? textStyle.color;
    underlineColor ??= theme.colorScheme.foreground;
    return DefaultTextStyle.merge(
      style: underline
          ? textStyle.copyWith(
              color: (textStyle.color ?? underlineColor).withOpacity(0),
              decorationColor: underlineColor,
              decoration: TextDecoration.underline,
              shadows: [
                  Shadow(
                    color: textStyle.color ?? underlineColor,
                    offset: const Offset(0, -2) * scaling,
                    blurRadius: 0,
                  ),
                ])
          : textStyle,
      child: Transform.translate(
        offset:
            underline && translate ? const Offset(0, 2) * scaling : Offset.zero,
        child: child,
      ),
    );
  }
}
