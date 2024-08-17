import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'dropdown_menu/dropdown_menu_example_1.dart';

class DropdownMenuExample extends StatelessWidget {
  const DropdownMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'dropdown_menu',
      description:
          'Dropdown menu is a menu that appears when you click a button or other control.',
      displayName: 'Dropdown Menu',
      children: [
        WidgetUsageExample(
          title: 'Dropdown Menu Example',
          path:
              'lib/pages/docs/components/dropdown_menu/dropdown_menu_example_1.dart',
          child: DropdownMenuExample1(),
        ),
      ],
    );
  }
}
