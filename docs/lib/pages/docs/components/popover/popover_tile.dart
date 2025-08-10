import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components/calendar/calendar_example_2.dart';

class PopoverTile extends StatelessWidget implements IComponentPage {
  const PopoverTile({super.key});

  @override
  String get title => 'Popover';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'popover',
      title: 'Popover',
      scale: 1,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePicker(
              value: DateTime.now(),
              mode: PromptMode.popover,
              stateBuilder: (date) {
                if (date.isAfter(DateTime.now())) {
                  return DateState.disabled;
                }
                return DateState.enabled;
              },
              onChanged: (value) {},
            ),
            const Gap(4),
            const CalendarExample2(),
          ],
        ),
      ),
    );
  }
}
