import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class CheckboxTile extends StatelessWidget implements IComponentPage {
  const CheckboxTile({super.key});

  @override
  String get title => 'Checkbox';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'checkbox',
      title: 'Checkbox',
      scale: 1.8,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              state: CheckboxState.checked,
              trailing: const Text('Checked'),
              onChanged: (value) {},
            ),
            Checkbox(
              state: CheckboxState.indeterminate,
              trailing: const Text('Indeterminate'),
              onChanged: (value) {},
            ),
            Checkbox(
              state: CheckboxState.unchecked,
              trailing: const Text('Unchecked'),
              onChanged: (value) {},
            ),
          ],
        ).gap(4).sized(width: 300),
      ),
    );
  }
}
