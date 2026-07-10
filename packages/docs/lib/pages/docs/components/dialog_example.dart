import 'package:docs/pages/docs/components/dialog/dialog_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'dialog',
      description:
          'A window overlaid on either the primary window or another dialog window, rendering the content underneath inert.',
      displayName: 'Dialog',
      children: [
        WidgetUsageExample(
          title: 'Dialog Example',
          path: 'lib/pages/docs/components/dialog/dialog_example_1.dart',
          child: DialogExample1(),
        ),
      ],
    );
  }
}
