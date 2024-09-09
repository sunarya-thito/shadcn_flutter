import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimePickerExample1 extends StatefulWidget {
  const TimePickerExample1({super.key});

  @override
  State<TimePickerExample1> createState() => _TimePickerExample1State();
}

class _TimePickerExample1State extends State<TimePickerExample1> {
  TimeOfDay _value = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimePicker(
          value: _value,
          mode: PromptMode.popover,
          onChanged: (value) {
            setState(() {
              _value = value ?? TimeOfDay.now();
            });
          },
        ),
        const Gap(16),
        TimePicker(
          value: _value,
          mode: PromptMode.dialog,
          dialogTitle: const Text('Select Time'),
          onChanged: (value) {
            setState(() {
              _value = value ?? TimeOfDay.now();
            });
          },
        ),
      ],
    );
  }
}
