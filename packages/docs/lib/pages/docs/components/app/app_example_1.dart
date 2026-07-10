import 'package:shadcn_flutter/shadcn_flutter.dart';

// Minimal ShadcnApp usage: provides theming and routing scaffolding similar to
// MaterialApp/CupertinoApp, then renders a basic Scaffold with an AppBar.
// This example focuses on the default setup — no custom theme or routing.

class AppExample1 extends StatelessWidget {
  const AppExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadcnApp(
      home: Scaffold(
        headers: [
          // Use Shadcn AppBar in the Scaffold header area.
          AppBar(
            title: Text('Shadcn App Example'),
          ),
          // A divider beneath the AppBar to separate header and body.
          Divider(),
        ],
        child: Center(
          child: Text('Hello, Shadcn Flutter!'),
        ),
      ),
    );
  }
}
