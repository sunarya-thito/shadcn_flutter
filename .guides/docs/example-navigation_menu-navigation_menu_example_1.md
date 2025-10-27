---
title: "Example: components/navigation_menu/navigation_menu_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample1 extends StatelessWidget {
  const NavigationMenuExample1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // NavigationMenu displays a horizontal menu with items that can reveal
    // rich content on hover/press. Each NavigationMenuItem below demonstrates
    // different kinds of content lists and grid layouts.
    return NavigationMenu(
      children: [
        NavigationMenuItem(
          content: NavigationMenuContentList(
            // Reverse places the text/content list before the hero card.
            reverse: true,
            children: [
              NavigationMenuContent(
                title: const Text('Introduction'),
                content: const Text(
                    'Component library for Flutter based on Shadcn/UI design.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Installation'),
                content: const Text(
                    'How to install this package in your Flutter project.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Typography'),
                content: const Text(
                    'Styles and usage of typography in this package.'),
                onPressed: () {},
              ),
              Clickable(
                mouseCursor:
                    const WidgetStatePropertyAll(SystemMouseCursors.click),
                child: Card(
                  borderRadius: theme.borderRadiusMd,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const FlutterLogo(
                        size: 32,
                      ),
                      const Gap(16),
                      const Text('shadcn_flutter').mono().semiBold().large(),
                      const Gap(8),
                      const Text(
                              'Beautifully designed components from Shadcn/UI is now available for Flutter')
                          .muted(),
                    ],
                  ),
                ).constrained(maxWidth: 192),
              ),
            ],
```
