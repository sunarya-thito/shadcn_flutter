import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppBarTile extends StatelessWidget implements IComponentPage {
  const AppBarTile({super.key});

  @override
  String get title => 'App Bar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'app_bar',
      title: 'App Bar',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 300,
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Gap(16),
              Icon(
                Icons.menu,
                color: theme.colorScheme.primaryForeground,
              ),
              const Gap(16),
              Text(
                'App Title',
                style: TextStyle(
                  color: theme.colorScheme.primaryForeground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.search,
                color: theme.colorScheme.primaryForeground,
              ),
              const Gap(8),
              Icon(
                Icons.more_vert,
                color: theme.colorScheme.primaryForeground,
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
