import 'package:shadcn_flutter/shadcn_flutter.dart';

class SimpleApp extends StatelessWidget {
  final Widget child;
  final bool useScaffold;
  const SimpleApp({super.key, required this.child, this.useScaffold = true});
  const SimpleApp.scaffold({super.key, required this.child})
      : useScaffold = true;
  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      home: useScaffold ? Scaffold(child: child) : child,
    );
  }
}
