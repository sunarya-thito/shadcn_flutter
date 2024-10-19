import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample1 extends StatelessWidget {
  const NavigationMenuExample1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavigationMenu(
      children: [
        NavigationItem(
          content: NavigationContentList(
            reverse: true,
            children: [
              NavigationContent(
                title: const Text('Introduction'),
                content: const Text(
                    'Component library for Flutter based on Shadcn/UI design.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Installation'),
                content: const Text(
                    'How to install this package in your Flutter project.'),
                onPressed: () {},
              ),
              NavigationContent(
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
        NavigationItem(
          content: NavigationContentList(
            children: [
              NavigationContent(
                title: const Text('Accordion'),
                content: const Text('Accordion component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Alert'),
                content: const Text('Alert component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Alert Dialog'),
                content: const Text('Alert Dialog component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Animation'),
                content: const Text('Animation component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Avatar'),
                content: const Text('Avatar component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Badge'),
                content: const Text('Badge component for Flutter.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Components'),
        ),
        NavigationItem(
          content: NavigationContentList(
            crossAxisCount: 2,
            children: [
              // latest news
              NavigationContent(
                title: const Text('Latest news'),
                content: const Text('Stay updated with the latest news.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Change log'),
                content: const Text('View the change log of this package.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: const Text('Contributors'),
                content: const Text('List of contributors to this package.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Blog'),
        ),
        NavigationItem(
          onPressed: () {},
          child: const Text('Documentation'),
        ),
      ],
    );
  }
}
