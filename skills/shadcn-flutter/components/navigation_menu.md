# NavigationMenuTheme

Theme configuration for [NavigationMenu] components.

## Usage

### Navigation Menu Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/navigation_menu/navigation_menu_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample extends StatelessWidget {
  const NavigationMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'navigation_menu',
      description:
          'Navigation menu is a component that provides a list of navigation items.',
      displayName: 'Navigation Menu',
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 600,
          ),
          child: const WidgetUsageExample(
            title: 'Example',
            path:
                'lib/pages/docs/components/navigation_menu/navigation_menu_example_1.dart',
            child: NavigationMenuExample1(),
          ),
        ),
      ],
    );
  }
}

```

### Navigation Menu Example 1
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
          ),
          child: const Text('Getting started'),
        ),
        NavigationMenuItem(
          content: NavigationMenuContentList(
            children: [
              NavigationMenuContent(
                title: const Text('Accordion'),
                content: const Text('Accordion component for Flutter.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Alert'),
                content: const Text('Alert component for Flutter.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Alert Dialog'),
                content: const Text('Alert Dialog component for Flutter.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Animation'),
                content: const Text('Animation component for Flutter.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Avatar'),
                content: const Text('Avatar component for Flutter.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Badge'),
                content: const Text('Badge component for Flutter.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Components'),
        ),
        NavigationMenuItem(
          content: NavigationMenuContentList(
            // Use a simple 2-column grid for a more "news board" feel.
            crossAxisCount: 2,
            children: [
              // latest news
              NavigationMenuContent(
                title: const Text('Latest news'),
                content: const Text('Stay updated with the latest news.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Change log'),
                content: const Text('View the change log of this package.'),
                onPressed: () {},
              ),
              NavigationMenuContent(
                title: const Text('Contributors'),
                content: const Text('List of contributors to this package.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Blog'),
        ),
        NavigationMenuItem(
          onPressed: () {},
          child: const Text('Documentation'),
        ),
      ],
    );
  }
}

```

### Navigation Menu Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuTile extends StatelessWidget implements IComponentPage {
  const NavigationMenuTile({super.key});

  @override
  String get title => 'Navigation Menu';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Navigation Menu',
      name: 'navigation_menu',
      scale: 1,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            NavigationMenu(
              children: [
                Button(
                  onPressed: () {},
                  style: const ButtonStyle.ghost().copyWith(
                    decoration: (context, states, value) {
                      return (value as BoxDecoration).copyWith(
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        color: theme.colorScheme.muted.scaleAlpha(0.8),
                      );
                    },
                  ),
                  trailing: const Icon(
                    RadixIcons.chevronUp,
                    size: 12,
                  ),
                  child: const Text('Getting Started'),
                ),
                const NavigationMenuItem(
                  content: SizedBox(),
                  child: Text('Components'),
                ),
              ],
            ),
            const Gap(8),
            OutlinedContainer(
              borderRadius: theme.borderRadiusMd,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: NavigationMenuContentList(
                  children: [
                    Button(
                      style: ButtonVariance.ghost.copyWith(
                        padding: (context, states, value) {
                          return const EdgeInsets.all(12);
                        },
                        decoration: (context, states, value) {
                          return (value as BoxDecoration).copyWith(
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                            color: theme.colorScheme.muted.scaleAlpha(0.8),
                          );
                        },
                      ),
                      onPressed: () {},
                      alignment: Alignment.topLeft,
                      child: Basic(
                        title: const Text('Installation').medium(),
                        content:
                            const Text('How to install Shadcn/UI for Flutter')
                                .muted(),
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ).constrained(maxWidth: 16 * 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `surfaceOpacity` | `double?` | Opacity of the popover surface. |
| `surfaceBlur` | `double?` | Blur amount of the popover surface. |
| `margin` | `EdgeInsetsGeometry?` | Margin applied to the popover. |
| `offset` | `Offset?` | Offset for the popover relative to the trigger. |
