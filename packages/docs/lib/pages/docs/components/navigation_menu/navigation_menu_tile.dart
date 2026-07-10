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
