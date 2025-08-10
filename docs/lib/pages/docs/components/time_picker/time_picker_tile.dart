import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class TimePickerTile extends StatelessWidget implements IComponentPage {
  const TimePickerTile({super.key});

  @override
  String get title => 'Time Picker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'time_picker',
      title: 'Time Picker',
      scale: 1.2,
      example: Card(
        child: TimePickerDialog(
          use24HourFormat: true,
          initialValue: TimeOfDay.now(),
        ).withAlign(Alignment.topLeft),
      ).sized(height: 300),
    );
  }
}
