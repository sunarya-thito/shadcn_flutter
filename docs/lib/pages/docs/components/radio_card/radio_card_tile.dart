import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RadioCardTile extends StatelessWidget implements IComponentPage {
  const RadioCardTile({super.key});

  @override
  String get title => 'Radio Card';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'radio_card',
      title: 'Radio Card',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Select an option:').bold(),
            const Gap(16),
            Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Radio(value: true),
                        const Gap(8),
                        const Text('Option 1'),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Radio(value: false),
                        const Gap(8),
                        const Text('Option 2'),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Radio(value: false),
                        const Gap(8),
                        const Text('Option 3'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
