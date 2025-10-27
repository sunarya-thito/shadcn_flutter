---
title: "Example: components/app/app_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// ShadcnApp.router example using GoRouter for declarative navigation.
// Defines two routes ('/' and '/about') and renders a simple Scaffold for each.

class AppExample3 extends StatelessWidget {
  const AppExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      routerConfig: GoRouter(routes: [
        GoRoute(
          path: '/',
          // Home page with AppBar and greeting text.
          builder: (context, state) => const Scaffold(
            headers: [
              AppBar(
                title: Text('Shadcn App Example with GoRouter'),
              ),
              Divider(),
            ],
            child: Center(
              child: Text('Hello, Shadcn Flutter with GoRouter!'),
            ),
          ),
        ),
        GoRoute(
          path: '/about',
          // About page demonstrates a second route.
          builder: (context, state) => const Scaffold(
            headers: [
              AppBar(
                title: Text('About Page'),
              ),
              Divider(),
            ],
            child: Center(
              child: Text('This is the about page.'),
            ),
          ),
        ),
      ]),
    );
  }
}

```
