import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'chip_input/chip_input_example_1.dart';

class ChipInputExample extends StatelessWidget {
  const ChipInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'chip_input',
      description:
          'A chip input is a text input that allows users to input multiple chips.',
      displayName: 'Chip Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/chip_input/chip_input_example_1.dart',
          child: ChipInputExample1(),
        ),
      ],
    );
  }
}
