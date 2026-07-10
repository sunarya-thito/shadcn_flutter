import 'package:shadcn_flutter/shadcn_flutter.dart';

class RadioGroupExample1 extends StatefulWidget {
  const RadioGroupExample1({super.key});

  @override
  State<RadioGroupExample1> createState() => _RadioGroupExample1State();
}

class _RadioGroupExample1State extends State<RadioGroupExample1> {
  // Start with no selection (null). The UI reflects this until the user picks an option.
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // A generic RadioGroup for int values. It controls selection for its RadioItem children.
        RadioGroup<int>(
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              // Save the selected value emitted by the tapped RadioItem.
              selectedValue = value;
            });
          },
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Each RadioItem represents a single choice with an associated integer value.
              RadioItem(
                value: 1,
                trailing: Text('Option 1'),
              ),
              RadioItem(
                value: 2,
                trailing: Text('Option 2'),
              ),
              RadioItem(
                value: 3,
                trailing: Text('Option 3'),
              ),
            ],
          ),
        ),
        const Gap(16),
        // Echo the selection below for demonstration purposes.
        Text('Selected: $selectedValue'),
      ],
    );
  }
}
