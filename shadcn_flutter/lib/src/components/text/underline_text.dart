import '../../../shadcn_flutter.dart';

class UnderlineInterceptor extends StatelessWidget {
  final Widget child;

  const UnderlineInterceptor({
    Key? key,
    required this.child,
  }) : super(key: key);

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

  const UnderlineText({
    Key? key,
    required this.child,
    this.underline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? underlineColor;
    TextStyle textStyle = DefaultTextStyle.of(context).style;
    underlineColor = textStyle.decorationColor ?? textStyle.color;
    underlineColor ??= Theme.of(context).colorScheme.foreground;
    return DefaultTextStyle.merge(
      style: underline
          ? textStyle.copyWith(
              color: Colors.transparent,
              decorationColor: underlineColor,
              decoration: TextDecoration.underline,
              decorationThickness: textStyle.decorationThickness,
              decorationStyle: textStyle.decorationStyle,
              height: 0,
              shadows: [
                  Shadow(
                    color: textStyle.color ?? underlineColor,
                    offset: const Offset(0, -2),
                    blurRadius: 0,
                  ),
                ])
          : textStyle,
      child: Transform.translate(
        offset: underline ? const Offset(0, 2) : Offset.zero,
        child: child,
      ),
    );
  }
}
