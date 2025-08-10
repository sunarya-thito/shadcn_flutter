import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../calendar/calendar_example_2.dart';

class DatePickerTile extends StatelessWidget implements IComponentPage {
  const DatePickerTile({super.key});

  @override
  String get title => 'Date Picker';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'date_picker',
      title: 'Date Picker',
      horizontalOffset: 70,
      example: CalendarExample2(),
    );
  }
}
