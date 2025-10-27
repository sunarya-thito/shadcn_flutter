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
