import 'package:shadcn_flutter/shadcn_flutter.dart';

class DatePickerExample2 extends StatefulWidget {
  const DatePickerExample2({super.key});

  @override
  State<DatePickerExample2> createState() => _DatePickerExample2State();
}

class _DatePickerExample2State extends State<DatePickerExample2> {
  DateTimeRange? _value;
  @override
  Widget build(BuildContext context) {
    return DateRangePicker(
      value: _value,
      mode: PromptMode.popover,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
