import 'package:docs/pages/docs/components/sheet/sheet_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SheetExample extends StatelessWidget {
  const SheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'sheet',
      description:
          'A sheet is a panel that slides in from the edge of a screen.',
      displayName: 'Sheet',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/sheet/sheet_example_1.dart',
          child: SheetExample1(),
        ),
      ],
    );
  }
}
