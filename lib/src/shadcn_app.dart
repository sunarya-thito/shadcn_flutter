import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ShadcnApp extends StatefulWidget {
  final Widget child;
  final ThemeData theme;

  const ShadcnApp({
    Key? key,
    required this.child,
    required this.theme,
  }) : super(key: key);

  @override
  _ShadcnAppState createState() => _ShadcnAppState();
}

class _ShadcnAppState extends State<ShadcnApp> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedContainer(
          duration: kDefaultDuration,
          color: widget.theme.colorScheme.background,
          child: AnimatedDefaultTextStyle(
            duration: kDefaultDuration,
            style: widget.theme.typography.paragraph.copyWith(
              color: widget.theme.colorScheme.foreground,
              decorationColor: widget.theme.colorScheme.foreground,
            ),
            child: AnimatedIconTheme(
              duration: kDefaultDuration,
              data: IconThemeData(
                color: widget.theme.colorScheme.foreground,
              ),
              child: Navigator(
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return MaterialPageRoute(
                      builder: (context) => widget.child,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
