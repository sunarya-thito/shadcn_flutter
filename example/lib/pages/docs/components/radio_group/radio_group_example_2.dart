import 'package:shadcn_flutter/shadcn_flutter.dart';

class RadioGroupExample2 extends StatefulWidget {
  @override
  State<RadioGroupExample2> createState() => _RadioGroupExample2State();
}

class _RadioGroupExample2State extends State<RadioGroupExample2> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioGroup<int>(
          initialValue: 2,
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
