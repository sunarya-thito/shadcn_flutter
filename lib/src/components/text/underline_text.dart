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
    if (textStyle.color != null) {
      underlineColor = textStyle.decorationColor ?? textStyle.color;
    }
    underlineColor ??= Theme.of(context).colorScheme.foreground;
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          Transform.translate(
            offset: const Offset(0, -3),
            child: Container(
              height: 1,
              margin: const EdgeInsets.only(top: 1),
              color: underline ? underlineColor : const Color(0x00000000),
            ),
          )
        ],
      ),
    );
  }
}
