import 'package:shadcn_flutter/shadcn_flutter.dart';

class DatePickerExample3 extends StatefulWidget {
  const DatePickerExample3({super.key});

  @override
  State<DatePickerExample3> createState() => _DatePickerExample3State();
}

class _DatePickerExample3State extends State<DatePickerExample3> {
  DateTime? _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DateInput(
          initialValue: DateTime.now(),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        Gap(20),
        Text('Selected date: $_value'),
      ],
    );
  }
}
