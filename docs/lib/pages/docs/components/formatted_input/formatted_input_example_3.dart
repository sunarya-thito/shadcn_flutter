import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample3 extends StatefulWidget {
  const FormattedInputExample3({super.key});

  @override
  State<FormattedInputExample3> createState() => _FormattedInputExample3State();
}

class _FormattedInputExample3State extends State<FormattedInputExample3> {
  TimeOfDay? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeInput(
          onChanged: (value) => setState(() => _selected = value),
        ),
        const Gap(16),
        if (_selected != null) Text('Selected time: $_selected'),
      ],
    );
  }
}
