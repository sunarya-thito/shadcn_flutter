import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'alert_dialog/alert_dialog_example_1.dart';

class AlertDialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'alert_dialog',
      description:
          'An alert dialog informs the user about situations that require acknowledgement.',
      displayName: 'Alert Dialog',
      children: [
        WidgetUsageExample(
          title: 'Alert Dialog Example',
          child: AlertDialogExample1(),
          path:
              'lib/pages/docs/components/alert_dialog/alert_dialog_example_1.dart',
        ),
      ],
    );
  }
}
