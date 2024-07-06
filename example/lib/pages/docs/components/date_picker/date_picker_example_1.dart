import 'package:shadcn_flutter/shadcn_flutter.dart';

class DatePickerExample1 extends StatefulWidget {
  @override
  State<DatePickerExample1> createState() => _DatePickerExample1State();
}

class _DatePickerExample1State extends State<DatePickerExample1> {
  DateTime? _value;
  @override
  Widget build(BuildContext context) {
    return DatePicker(
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
