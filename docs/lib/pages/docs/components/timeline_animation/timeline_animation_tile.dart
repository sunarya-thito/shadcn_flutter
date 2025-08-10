import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimelineAnimationTile extends StatelessWidget implements IComponentPage {
  const TimelineAnimationTile({super.key});

  @override
  String get title => 'Timeline Animation';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'timeline_animation',
      title: 'Timeline Animation',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Animated Timeline:').bold(),
              const Gap(16),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: theme.colorScheme.primary,
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: theme.colorScheme.muted,
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.muted,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Step 1 Completed').bold(),
                        const Gap(4),
                        const Text('Task finished successfully').muted(),
                        const Gap(32),
                        const Text('Step 2 In Progress').bold(),
                        const Gap(4),
                        const Text('Currently working on this task').muted(),
                        const Gap(32),
                        const Text('Step 3 Pending').muted(),
                        const Gap(4),
                        const Text('Waiting to be started').muted(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
