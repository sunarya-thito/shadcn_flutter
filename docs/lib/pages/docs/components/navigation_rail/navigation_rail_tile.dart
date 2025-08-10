import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationRailTile extends StatelessWidget implements IComponentPage {
  const NavigationRailTile({super.key});

  @override
  String get title => 'Navigation Rail';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'navigation_rail',
      title: 'Navigation Rail',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 80,
          height: 300,
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Gap(16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.home,
                  color: theme.colorScheme.primaryForeground,
                ),
              ),
              const Gap(16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.search),
              ),
              const Gap(16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.favorite),
              ),
              const Gap(16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.settings),
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.person),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
