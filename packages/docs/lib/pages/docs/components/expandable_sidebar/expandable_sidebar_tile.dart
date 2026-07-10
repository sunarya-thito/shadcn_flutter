import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ExpandableSidebarTile extends StatelessWidget implements IComponentPage {
  const ExpandableSidebarTile({super.key});

  @override
  String get title => 'Expandable Sidebar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'expandable_sidebar',
      title: 'Expandable Sidebar',
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
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.menu),
                    const Gap(12),
                    const Text('Menu').bold(),
                    const Spacer(),
                    const Icon(Icons.chevron_left),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Icon(Icons.home),
                          Gap(12),
                          Text('Home'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Icon(Icons.settings),
                          Gap(12),
                          Text('Settings'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Icon(Icons.person),
                          Gap(12),
                          Text('Profile'),
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
