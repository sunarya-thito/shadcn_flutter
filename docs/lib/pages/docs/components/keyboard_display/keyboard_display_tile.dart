import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class KeyboardDisplayTile extends StatelessWidget implements IComponentPage {
  const KeyboardDisplayTile({super.key});

  @override
  String get title => 'Keyboard Display';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'keyboard_display',
      title: 'Keyboard Display',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Keyboard Shortcuts:').bold(),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: theme.colorScheme.border),
                  ),
                  child: const Text('Ctrl', style: TextStyle(fontSize: 12)),
                ),
                const Gap(4),
                const Text('+'),
                const Gap(4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: theme.colorScheme.border),
                  ),
                  child: const Text('C', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const Gap(8),
            const Text('Copy').muted(),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: theme.colorScheme.border),
                  ),
                  child: const Text('Ctrl', style: TextStyle(fontSize: 12)),
                ),
                const Gap(4),
                const Text('+'),
                const Gap(4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: theme.colorScheme.border),
                  ),
                  child: const Text('V', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const Gap(8),
            const Text('Paste').muted(),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
