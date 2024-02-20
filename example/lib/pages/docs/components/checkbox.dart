import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CheckboxExample extends StatefulWidget {
  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  CheckboxState _state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'checkbox',
      description:
          'Checkboxes allow the user to select one or more items from a set.',
      displayName: 'Checkbox',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return Checkbox(
              state: _state,
              onChanged: (value) {
                setState(() {
                  _state = value;
                });
              },
              trailing: Text('Remember me'),
              tristate: true,
            );
          },
          code: '''
Checkbox(
  state: _state,
  onChanged: (value) {
    setState(() {
      _state = value;
    });
  },
  trailing: Text('Remember me'),
  tristate: true,
)''',
        ),
      ],
    );
  }
}
