import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimePickerExample1 extends StatefulWidget {
  @override
  State<TimePickerExample1> createState() => _TimePickerExample1State();
}

class _TimePickerExample1State extends State<TimePickerExample1> {
  TimeOfDay? _value;
  @override
  Widget build(BuildContext context) {
    return TimePicker(
      value: _value,
      mode: PromptMode.popover,
      use24HourFormat: true,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
