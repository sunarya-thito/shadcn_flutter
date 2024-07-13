import 'package:example/pages/docs/components/resizable/resizable_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class ResizableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'resizable',
      description: 'A resizable pane widget, support resize child widget.',
      displayName: 'Resizable',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Example',
          child: ResizableExample1(),
          path: 'lib/pages/docs/components/resizable/resizable_example_1.dart',
        ),
      ],
    );
  }
}
