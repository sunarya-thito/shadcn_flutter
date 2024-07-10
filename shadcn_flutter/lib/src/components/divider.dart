import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Divider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsets? padding;

  const Divider({
    Key? key,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (child != null) {
      return IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                height: height ?? 1,
                color: color ?? theme.colorScheme.border,
                margin: EdgeInsets.only(left: indent ?? 0),
              ),
            ),
            child!.muted().small().withPadding(padding: padding),
            Expanded(
              child: Container(
                height: height ?? 1,
                color: color ?? theme.colorScheme.border,
                margin: EdgeInsets.only(right: endIndent ?? 0),
              ),
            ),
          ],
        ),
      );
    }
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
  final Widget? child;
  final EdgeInsets? padding;

  const VerticalDivider({
    Key? key,
    this.color,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (child != null) {
      return IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                width: width ?? 1,
                color: color ?? theme.colorScheme.border,
                margin: EdgeInsets.only(top: indent ?? 0),
              ),
            ),
            child!.muted().small().withPadding(padding: padding),
            Expanded(
              child: Container(
                width: width ?? 1,
                color: color ?? theme.colorScheme.border,
                margin: EdgeInsets.only(bottom: endIndent ?? 0),
              ),
            ),
          ],
        ),
      );
    }
    return AnimatedContainer(
      duration: kDefaultDuration,
      width: width ?? 1,
      color: color ?? theme.colorScheme.border,
      margin: EdgeInsets.only(top: indent ?? 0, bottom: endIndent ?? 0),
    );
  }
}
