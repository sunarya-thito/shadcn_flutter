import 'package:shadcn_flutter/shadcn_flutter.dart';

class Scaffold extends StatelessWidget {
  final Widget child;

  const Scaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DrawerOverlay(
      child: AnimatedContainer(
        duration: kDefaultDuration,
        color: theme.colorScheme.background,
        child: child,
      ),
    );
  }
}
