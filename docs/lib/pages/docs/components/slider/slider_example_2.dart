import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample2 extends StatefulWidget {
  const SliderExample2({super.key});

  @override
  State<SliderExample2> createState() => _SliderExample2State();
}

class _SliderExample2State extends State<SliderExample2> {
  // A ranged slider has a start and end thumb/value.
  SliderValue value = const SliderValue.ranged(0.5, 0.75);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        const Gap(16),
        // Display the current ranged values below the slider.
        Text('Value: ${value.start} - ${value.end}'),
      ],
    );
  }
}
