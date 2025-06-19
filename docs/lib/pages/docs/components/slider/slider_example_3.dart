import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample3 extends StatefulWidget {
  const SliderExample3({super.key});

  @override
  State<SliderExample3> createState() => _SliderExample3State();
}

class _SliderExample3State extends State<SliderExample3> {
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          max: 2,
          divisions: 10,
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        const Gap(16),
        Text('Value: ${value.value}'),
      ],
    );
  }
}
