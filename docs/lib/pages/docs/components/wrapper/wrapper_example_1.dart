import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:flutter/material.dart';

// Wrap an existing Material/Cupertino app with ShadcnUI and Theme.
// Useful when you want to adopt Shadcn components and theming without
// replacing your root MaterialApp/CupertinoApp structure.

class WrapperExample1 extends StatelessWidget {
  const WrapperExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // If you are using MaterialApp or CupertinoApp
    // but still want to use Shadcn UI theming and components,
    // you can wrap your app with ShadcnUI and Theme.
    return const shadcn.Theme(
      // Choose a Shadcn theme (dark here), then place ShadcnUI below it so
      // descendants pick up tokens (colors, radius, typography, etc.).
      data: shadcn.ThemeData.dark(),
      child: shadcn.ShadcnUI(
        child: shadcn.Scaffold(
          headers: [
            shadcn.AppBar(
              title: Text('Shadcn UI Wrapper Example'),
            ),
            shadcn.Divider(),
          ],
          child: Center(
            child: shadcn.Text('Hello, Shadcn Flutter!'),
          ),
        ),
      ),
    );
  }
}
