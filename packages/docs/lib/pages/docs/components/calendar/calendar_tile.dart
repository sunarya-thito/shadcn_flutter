import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CalendarTile extends StatelessWidget implements IComponentPage {
  const CalendarTile({super.key});

  @override
  String get title => 'Calendar';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'calendar',
      title: 'Calendar',
      scale: 1,
      example: Calendar(
          view: CalendarView.now(), selectionMode: CalendarSelectionMode.none),
    );
  }
}
