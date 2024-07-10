import 'package:example/pages/docs/components/date_picker/date_picker_example_1.dart';
import 'package:example/pages/docs/components/date_picker/date_picker_example_2.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class DatePickerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'date_picker',
      description: 'A widget that lets users select dates and date ranges.',
      displayName: 'Date Picker',
      children: [
        WidgetUsageExample(
          title: 'Date Picker Example',
          child: DatePickerExample1(),
          path:
              'lib/pages/docs/components/date_picker/date_picker_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Date Range Picker Example',
          child: DatePickerExample2(),
          path:
              'lib/pages/docs/components/date_picker/date_picker_example_2.dart',
        ),
      ],
    );
  }
}
