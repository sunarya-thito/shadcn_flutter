import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/time_picker/time_picker_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimePickerExample extends StatelessWidget {
  const TimePickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'time_picker',
      description:
          'Time picker is a component that allows users to pick a time.',
      displayName: 'Time Picker',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/time_picker/time_picker_example_1.dart',
          child: TimePickerExample1(),
        ),
      ],
    );
  }
}
