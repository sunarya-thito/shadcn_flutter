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
            const Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Radio(value: true),
                        Gap(8),
                        Text('Option 1'),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Radio(value: false),
                        Gap(8),
                        Text('Option 2'),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Radio(value: false),
                        Gap(8),
                        Text('Option 3'),
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
