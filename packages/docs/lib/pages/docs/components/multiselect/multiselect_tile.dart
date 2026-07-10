import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MultiselectTile extends StatelessWidget implements IComponentPage {
  const MultiselectTile({super.key});

  @override
  String get title => 'Multiselect';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'multiselect',
      title: 'Multiselect',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Select multiple options:').bold(),
            const Gap(16),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Checkbox(
                        state: CheckboxState.checked,
                        onChanged: (value) {},
                      ),
                      const Gap(12),
                      const Text('Option 1'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Checkbox(
                        state: CheckboxState.unchecked,
                        onChanged: (value) {},
                      ),
                      const Gap(12),
                      const Text('Option 2'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Checkbox(
                        state: CheckboxState.checked,
                        onChanged: (value) {},
                      ),
                      const Gap(12),
                      const Text('Option 3'),
                    ],
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
