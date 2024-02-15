import 'package:flutter/widgets.dart';

import '../../../shadcn_flutter.dart';

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
