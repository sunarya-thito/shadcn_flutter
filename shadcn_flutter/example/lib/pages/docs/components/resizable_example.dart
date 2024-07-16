import 'package:example/pages/docs/components/resizable/resizable_example_1.dart';
import 'package:example/pages/docs/components/resizable/resizable_example_2.dart';
import 'package:example/pages/docs/components/resizable/resizable_example_3.dart';
import 'package:example/pages/docs/components/resizable/resizable_example_4.dart';
import 'package:example/pages/docs/components/resizable/resizable_example_5.dart';
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
        WidgetUsageExample(
          title: 'Vertical Example',
          child: ResizableExample2(),
          path: 'lib/pages/docs/components/resizable/resizable_example_2.dart',
        ),
        WidgetUsageExample(
          title: 'Horizontal Example with Dragger',
          child: ResizableExample3(),
          path: 'lib/pages/docs/components/resizable/resizable_example_3.dart',
        ),
        WidgetUsageExample(
          title: 'Controller Example',
          child: ResizableExample4(),
          path: 'lib/pages/docs/components/resizable/resizable_example_4.dart',
        ),
        WidgetUsageExample(
          title: 'Collapsible Example',
          child: ResizableExample5(),
          path: 'lib/pages/docs/components/resizable/resizable_example_5.dart',
        ),
      ],
    );
  }
}
