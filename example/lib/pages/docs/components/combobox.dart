import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ComboBoxExample extends StatefulWidget {
  @override
  State<ComboBoxExample> createState() => _ComboBoxExampleState();
}

class _ComboBoxExampleState extends State<ComboBoxExample> {
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'combo_box',
      description:
          'A combobox is a widget that allows the user to select an item from a list of items.',
      displayName: 'ComboBox',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return ComboBox(
              selectedIndex: selectedValue,
              items: const [
                'Red Apple',
                'Green Apple',
                'Yellow Banana',
                'Brown Banana',
                'Yellow Lemon',
                'Green Lemon',
                'Red Tomato',
                'Green Tomato',
                'Yellow Tomato',
                'Brown Tomato',
              ],
              searchFilter: (item, query) {
                return item.toLowerCase().contains(query.toLowerCase()) ? 1 : 0;
              },
              placeholder: const Text('Select a fruit'),
              itemBuilder: (context, item) {
                return Text(item);
              },
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            );
          },
          code: '''
ComboBox(
  selectedIndex: selectedValue,
  items: const [
    'Red Apple',
    'Green Apple',
    'Yellow Banana',
    'Brown Banana',
    'Yellow Lemon',
    'Green Lemon',
    'Red Tomato',
    'Green Tomato',
    'Yellow Tomato',
    'Brown Tomato',
  ],
  searchFilter: (item, query) {
    return item.toLowerCase().contains(query.toLowerCase())
        ? 1
        : 0;
  },
  placeholder: const Text('Select a fruit'),
  itemBuilder: (context, item) {
    return Text(item);
  },
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)''',
        ),
      ],
    );
  }
}
