import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationSidebarTile extends StatelessWidget implements IComponentPage {
  const NavigationSidebarTile({super.key});

  @override
  String get title => 'Navigation Sidebar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'navigation_sidebar',
      title: 'Navigation Sidebar',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.menu),
                    const Gap(12),
                    const Text('Navigation').bold(),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: theme.colorScheme.primaryForeground,
                          ),
                          const Gap(12),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: theme.colorScheme.primaryForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(4),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          const Gap(12),
                          const Text('Search'),
                        ],
                      ),
                    ),
                    const Gap(4),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.favorite),
                          const Gap(12),
                          const Text('Favorites'),
                        ],
                      ),
                    ),
                    const Gap(4),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          const Gap(12),
                          const Text('Settings'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
