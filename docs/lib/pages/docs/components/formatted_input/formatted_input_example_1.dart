import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      parts: [
        InputPart.editable(length: 2, width: 40),
        InputPart.static('/'),
        InputPart.editable(length: 2, width: 40),
        InputPart.static('/'),
        InputPart.editable(length: 4, width: 60),
      ],
      trailing: IconButton.text(
        density: ButtonDensity.compact,
        icon: Icon(Icons.calendar_month),
        onPressed: () {},
      ),
      initialValue: FormattedValue(
        [
          '12',
          '/',
          '34',
          '/',
          '5678',
        ],
      ),
    );
  }
}
