import 'package:shadcn_flutter/shadcn_flutter.dart';

class RadioCardExample1 extends StatefulWidget {
  const RadioCardExample1({super.key});

  @override
  State<RadioCardExample1> createState() => _RadioCardExample1State();
}

class _RadioCardExample1State extends State<RadioCardExample1> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      value: value,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioCard(
            value: 1,
            child: Basic(
              title: Text('8-core CPU'),
              content: Text('32 GB RAM'),
            ),
          ),
          RadioCard(
            value: 2,
            child: Basic(
              title: Text('6-core CPU'),
              content: Text('24 GB RAM'),
            ),
          ),
          RadioCard(
            value: 3,
            child: Basic(
              title: Text('4-core CPU'),
              content: Text('16 GB RAM'),
            ),
          ),
        ],
      ).gap(12),
    );
  }
}
