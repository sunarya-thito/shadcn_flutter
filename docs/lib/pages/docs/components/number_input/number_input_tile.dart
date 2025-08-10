import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberInputTile extends StatelessWidget implements IComponentPage {
  const NumberInputTile({super.key});

  @override
  String get title => 'Number Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'number_input',
      title: 'Number Input',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Enter a number:').bold(),
            const Gap(16),
            TextField(
              initialValue: '42',
              keyboardType: TextInputType.number,
              placeholder: const Text('Enter number'),
            ).sized(width: 200),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
