---
title: "Example: components/wrapper/wrapper_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

// Wrap part of an existing Material/Cupertino app with ShadcnLayer.
// Useful when you want to adopt shadcn_flutter components and theming without
// replacing your root MaterialApp/CupertinoApp structure.
//
// This is the mirror image of MaterialLayer/CupertinoLayer from
// shadcn_flutter_material and shadcn_flutter_cupertino: those bring Material or
// Cupertino into a shadcn app, this brings shadcn into a Material or Cupertino
// app. Neither requires shadcn_flutter itself to depend on Material.

class WrapperExample1 extends StatelessWidget {
  const WrapperExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // If you are using MaterialApp or CupertinoApp
    // but still want to use shadcn_flutter theming and components,
    // wrap that subtree with ShadcnLayer.
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

```
