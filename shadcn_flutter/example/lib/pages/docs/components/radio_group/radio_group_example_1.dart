import 'package:shadcn_flutter/shadcn_flutter.dart';

class RadioGroupExample1 extends StatefulWidget {
  @override
  State<RadioGroupExample1> createState() => _RadioGroupExample1State();
}

class _RadioGroupExample1State extends State<RadioGroupExample1> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioGroup<int>(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioItem(
                value: 1,
                trailing: Text('Option 1'),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      selectedValue = 1;
                    });
                  }
                },
              ),
              RadioItem(
                value: 2,
                trailing: Text('Option 2'),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      selectedValue = 2;
                    });
                  }
                },
              ),
              RadioItem(
                value: 3,
                trailing: Text('Option 3'),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      selectedValue = 3;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        gap(16),
        Text('Selected: $selectedValue'),
      ],
    );
  }
}
