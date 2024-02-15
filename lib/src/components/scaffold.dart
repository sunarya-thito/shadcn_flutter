import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Scaffold extends StatefulWidget {
  final Widget? body;
  final bool scrollable;

  const Scaffold({Key? key, this.body, this.scrollable = true})
      : super(key: key);

  @override
  _ScaffoldState createState() => _ScaffoldState();
}

class _ScaffoldState extends State<Scaffold> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      child: AnimatedIconTheme(
        data: IconThemeData(
          color: theme.colorScheme.foreground,
          weight: 100,
        ),
        duration: kDefaultDuration,
        child: AnimatedContainer(
          duration: kDefaultDuration,
          color: theme.colorScheme.background,
          // child: SingleChildScrollView(
          //   child: widget.body,
          // ),
          child: widget.scrollable
              ? SingleChildScrollView(
                  child: widget.body,
                )
              : widget.body,
        ),
      ),
    );
  }
}
