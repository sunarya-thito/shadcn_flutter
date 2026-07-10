import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/window/window_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WindowExample extends StatelessWidget {
  const WindowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'window',
      description:
          'A window manager that allows you to create and manage windows.',
      displayName: 'Window',
      children: [
        WidgetUsageExample(
          title: 'Window Example',
          path: 'lib/pages/docs/components/window/window_example_1.dart',
          child: WindowExample1(),
        ),
      ],
    );
  }
}
