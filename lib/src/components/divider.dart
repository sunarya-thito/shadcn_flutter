import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Divider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const Divider({
    Key? key,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      height: height ?? 1,
      color: color ?? theme.colorScheme.border,
      margin: EdgeInsets.only(left: indent ?? 0, right: endIndent ?? 0),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const VerticalDivider({
    Key? key,
    this.color,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      width: width ?? 1,
      color: color ?? theme.colorScheme.border,
      margin: EdgeInsets.only(top: indent ?? 0, bottom: endIndent ?? 0),
    );
  }
}
