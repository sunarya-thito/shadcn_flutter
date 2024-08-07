import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/menubar/menubar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample extends StatelessWidget {
  const MenubarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'menubar',
      description:
          'A bar of buttons that provies quick access to common actions.',
      displayName: 'Menubar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/menubar/menubar_example_1.dart',
          child: MenubarExample1(),
        ),
      ],
    );
  }
}
