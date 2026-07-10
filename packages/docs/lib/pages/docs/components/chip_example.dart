import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/chip/chip_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipExample extends StatelessWidget {
  const ChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'chip',
      description:
          'A chip is a small, interactive element that represents an attribute, text, entity, or action.',
      displayName: 'Chip',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/chip/chip_example_1.dart',
          child: ChipExample1(),
        ),
      ],
    );
  }
}
