import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
            builder: (context) {
              return Button(
                child: Text('Click Here'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: AlertDialog(
                          title: Text('Alert title'),
                          content: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                          actions: [
                            Button(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              type: ButtonType.outline,
                            ),
                            Button(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            code: '''
Center(
  child: AlertDialog(
    title: Text('Alert title'),
    content: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
    actions: [
      Button(
        child: Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
        type: ButtonType.outline,
      ),
      Button(
        child: Text('OK'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  ),
)'''),
      ],
    );
  }
}
