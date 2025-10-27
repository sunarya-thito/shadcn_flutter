---
title: "Example: components/app/app_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates ShadcnApp with custom light/dark themes.
// Highlights theme knobs like colorScheme, radius, scaling, surfaceOpacity,
// surfaceBlur, and custom typography families.

class AppExample2 extends StatelessWidget {
  const AppExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadcnApp(
      theme: ThemeData(
          // Customize light mode colors and design tokens.
          colorScheme: ColorSchemes.lightGreen,
          // Corner radius scale applied across components.
          radius: 0.25,
          // Global size scale multiplier.
          scaling: 1.2,
          // Semi-translucent surfaces with blur create a glassy look.
          surfaceOpacity: 0.8,
          surfaceBlur: 10,
          // Swap default fonts for sans/mono text styles.
          typography: Typography.geist(
            sans: TextStyle(
              fontFamily: 'Inter',
            ),
            mono: TextStyle(
              fontFamily: 'FiraCode',
            ),
          )),
      darkTheme: ThemeData.dark(
          // Mirror customizations for dark mode.
          colorScheme: ColorSchemes.darkGreen,
          radius: 0.25,
          scaling: 1.2,
          surfaceOpacity: 0.8,
          surfaceBlur: 10,
          typography: Typography.geist(
            sans: TextStyle(
              fontFamily: 'Inter',
            ),
            mono: TextStyle(
              fontFamily: 'FiraCode',
            ),
          )),
      home: Scaffold(
        headers: [
          AppBar(
            title: Text('Shadcn App Example'),
          ),
          Divider(),
        ],
        child: Center(
          child: Text('Hello, Shadcn Flutter!'),
        ),
      ),
    );
  }
}
```
