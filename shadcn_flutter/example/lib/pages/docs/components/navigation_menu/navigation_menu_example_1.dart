import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample1 extends StatelessWidget {
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
                title: Text('Introduction'),
                content: Text(
                    'Component library for Flutter based on Shadcn/UI design.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Installation'),
                content: Text(
                    'How to install this package in your Flutter project.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Typography'),
                content:
                    Text('Styles and usage of typography in this package.'),
                onPressed: () {},
              ),
              Clickable(
                mouseCursor:
                    const WidgetStatePropertyAll(SystemMouseCursors.click),
                child: Card(
                  borderRadius: theme.radiusMd,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const FlutterLogo(
                        size: 32,
                      ),
                      gap(16),
                      Text('shadcn_flutter').mono().semiBold().large(),
                      gap(8),
                      Text('Beautifully designed components from Shadcn/UI is now available for Flutter')
                          .muted(),
                    ],
                  ),
                ).constrained(maxWidth: 192),
              ),
            ],
          ),
          child: Text('Getting started'),
        ),
        NavigationItem(
          child: Text('Components'),
          content: NavigationContentList(
            children: [
              NavigationContent(
                title: Text('Accordion'),
                content: Text('Accordion component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Alert'),
                content: Text('Alert component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Alert Dialog'),
                content: Text('Alert Dialog component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Animation'),
                content: Text('Animation component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Avatar'),
                content: Text('Avatar component for Flutter.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Badge'),
                content: Text('Badge component for Flutter.'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        NavigationItem(
          content: NavigationContentList(
            crossAxisCount: 2,
            children: [
              // latest news
              NavigationContent(
                title: Text('Latest news'),
                content: Text('Stay updated with the latest news.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Change log'),
                content: Text('View the change log of this package.'),
                onPressed: () {},
              ),
              NavigationContent(
                title: Text('Contributors'),
                content: Text('List of contributors to this package.'),
                onPressed: () {},
              ),
            ],
          ),
          child: Text('Blog'),
        ),
        NavigationItem(
          onPressed: () {},
          child: Text('Documentation'),
        ),
      ],
    );
  }
}
