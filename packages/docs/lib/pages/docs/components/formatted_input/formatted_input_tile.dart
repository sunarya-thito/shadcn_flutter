import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputTile extends StatelessWidget implements IComponentPage {
  const FormattedInputTile({super.key});

  @override
  String get title => 'Formatted Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'formatted_input',
      title: 'Formatted Input',
      scale: 1.2,
      example: Card(
        child: const Column(
          children: [
            TextField(
              placeholder: Text('(123) 456-7890'),
              initialValue: '1234567890',
            ),
            Gap(16),
            TextField(
              placeholder: Text('1234 5678 9012 3456'),
              initialValue: '1234567890123456',
            ),
            Gap(16),
            TextField(
              placeholder: Text('MM/DD/YYYY'),
              initialValue: '12/25/2024',
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
