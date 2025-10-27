// Wrapper example page: lists and renders the Wrapper component demos.
//
// This is a docs wrapper page (not the demo unit). It composes a ComponentPage
// with one or more WidgetUsageExample entries that point to the actual demo
// files under components/wrapper/*. Behavior unchanged; comments only.
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/wrapper/wrapper_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WrapperExample extends StatelessWidget {
  const WrapperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'wrapper',
      description:
          'ShadcnUI widget is a component that allows you to use Shadcn/UI components '
          'within your MaterialApp or CupertinoApp, providing consistent theming and styling.',
      displayName: 'Wrapper',
      children: [
        WidgetUsageExample(
          title: 'Wrapper Example',
          path: 'lib/pages/docs/components/wrapper/wrapper_example_1.dart',
          child: const WrapperExample1().sized(height: 300),
        ),
      ],
    );
  }
}
