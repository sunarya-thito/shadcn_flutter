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
    return Stack(
      children: [
        child,
        Positioned(
          bottom: -0.2,
          left: 0,
          right: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            height: underline ? 1 : 0,
            color: underlineColor,
          ),
        ),
      ],
    );
  }
}
