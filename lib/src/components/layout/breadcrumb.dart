import 'package:flutter/gestures.dart';

import '../../../shadcn_flutter.dart';

class _ArrowSeparator extends StatelessWidget {
  const _ArrowSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * scaling),
      child: const Icon(
        RadixIcons.chevronRight,
      ).iconXSmall().muted(),
    );
  }
}

class _SlashSeparator extends StatelessWidget {
  const _SlashSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 * scaling),
      child: const Text('/').small().muted(),
    );
  }
}

class Breadcrumb extends StatelessWidget {
  static const Widget arrowSeparator = _ArrowSeparator();
  static const Widget slashSeparator = _SlashSeparator();
  final List<Widget> children;
  final Widget separator;

  const Breadcrumb({
    super.key,
    required this.children,
    required this.separator,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context)
          .copyWith(scrollbars: false, dragDevices: {PointerDeviceKind.touch}),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (children.length == 1) children[0].medium().foreground(),
            if (children.length > 1)
              for (var i = 0; i < children.length; i++)
                if (i == children.length - 1)
                  children[i].medium().foreground()
                else
                  Row(
                    children: [
                      children[i].medium(),
                      separator,
                    ],
                  ),
          ],
        ).small().muted(),
      ),
    );
  }
}
