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
    return const shadcn.ShadcnLayer(
      theme: shadcn.ThemeData(),
      darkTheme: shadcn.ThemeData.dark(),
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
    );
  }
}
