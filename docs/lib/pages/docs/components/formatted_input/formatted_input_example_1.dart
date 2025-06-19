import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      onChanged: (value) {
        List<String> parts = [];
        for (FormattedValuePart part in value.values) {
          parts.add(part.value ?? '');
        }
        print(parts.join('/'));
      },
      initialValue: FormattedValue([
        const InputPart.editable(length: 2, width: 40, placeholder: Text('MM'))
            .withValue('01'),
        const InputPart.static('/'),
        const InputPart.editable(length: 2, width: 40, placeholder: Text('DD'))
            .withValue('02'),
        const InputPart.static('/'),
        const InputPart.editable(length: 4, width: 60, placeholder: Text('YYYY'))
            .withValue('2021'),
      ]),
    );
  }
}
