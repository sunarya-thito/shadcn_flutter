import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Breadcrumb extends StatelessWidget {
  static final Widget arrowSeparator = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Icon(
          Icons.arrow_forward_ios,
          size: 10,
          color: theme.colorScheme.mutedForeground,
        );
      },
    ),
  );
  static const Widget slashSeparator = Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Text('/'),
  );
  final List<Widget> children;
  final Widget separator;

  const Breadcrumb({
    Key? key,
    required this.children,
    required this.separator,
  }) : super(key: key);

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
