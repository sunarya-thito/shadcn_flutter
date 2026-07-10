import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_1.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_2.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_3.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_4.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_5.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerExample extends StatelessWidget {
  const ItemPickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'item_picker',
      description:
          'Item picker is a widget that allows you to pick an item from a list of items.',
      displayName: 'Item Picker',
      children: [
        WidgetUsageExample(
          title: 'Item Picker Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_1.dart',
          child: ItemPickerExample1(),
        ),
        WidgetUsageExample(
          title: 'Dialog Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_2.dart',
          child: ItemPickerExample2(),
        ),
        WidgetUsageExample(
          title: 'Fixed List Item Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_3.dart',
          child: ItemPickerExample3(),
        ),
        WidgetUsageExample(
          title: 'List Layout Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_4.dart',
          child: ItemPickerExample4(),
        ),
        WidgetUsageExample(
          title: 'Form Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_5.dart',
          child: ItemPickerExample5(),
        ),
      ],
    );
  }
}
