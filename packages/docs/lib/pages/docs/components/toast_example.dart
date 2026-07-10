import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/toast/toast_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToastExample extends StatelessWidget {
  const ToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'toast',
      description:
          'A toast is a non-modal, unobtrusive window element used to display brief, auto-expiring information to the user.',
      displayName: 'Toast',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/toast/toast_example_1.dart',
          child: ToastExample1(),
        ),
      ],
    );
  }
}
