import 'package:docs/pages/docs/components/resizable/resizable_example_1.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_2.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_3.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_4.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_5.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_6.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class ResizableExample extends StatelessWidget {
  const ResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'resizable',
      description: 'A resizable pane widget, support resize child widget.',
      displayName: 'Resizable',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_1.dart',
          child: ResizableExample1(),
        ),
        WidgetUsageExample(
          title: 'Vertical Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_2.dart',
          child: ResizableExample2(),
        ),
        WidgetUsageExample(
          title: 'Horizontal Example with Dragger',
          path: 'lib/pages/docs/components/resizable/resizable_example_3.dart',
          child: ResizableExample3(),
        ),
        WidgetUsageExample(
          title: 'Controller Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_4.dart',
          child: ResizableExample4(),
        ),
        WidgetUsageExample(
          title: 'Collapsible Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_5.dart',
          child: ResizableExample5(),
        ),
        WidgetUsageExample(
          title: 'Nested Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_6.dart',
          child: ResizableExample6(),
        ),
      ],
    );
  }
}
