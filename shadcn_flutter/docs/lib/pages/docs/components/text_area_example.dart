import 'package:docs/pages/docs/components/text_area/text_area_example_1.dart';
import 'package:docs/pages/docs/components/text_area/text_area_example_2.dart';
import 'package:docs/pages/docs/components/text_area/text_area_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TextAreaExample extends StatelessWidget {
  const TextAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'text_area',
      description:
          'TextArea is a component that allows users to enter multiple lines of text.',
      displayName: 'TextArea',
      children: [
        WidgetUsageExample(
          title: 'Resizable Height Example',
          path: 'lib/pages/docs/components/text_area/text_area_example_1.dart',
          child: TextAreaExample1(),
        ),
        WidgetUsageExample(
          title: 'Resizable Width Example',
          path: 'lib/pages/docs/components/text_area/text_area_example_2.dart',
          child: TextAreaExample2(),
        ),
        WidgetUsageExample(
          title: 'Resizable Width and Height Example',
          path: 'lib/pages/docs/components/text_area/text_area_example_3.dart',
          child: TextAreaExample3(),
        ),
      ],
    );
  }
}
