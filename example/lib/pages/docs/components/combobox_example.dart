import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'combobox/combobox_example_1.dart';
class ComboboxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'combo_box',
      description: 'A combobox is a widget that allows the user to select an item from a list of items.',
      displayName: 'ComboBox',
      children: [
        WidgetUsageExample(
          child: ComboboxExample1(),
          path: 'lib/pages/docs/components/combobox/combobox_example_1.dart',
        ),
      ],
    );
  }
}
  