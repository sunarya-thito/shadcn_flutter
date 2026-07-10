import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample1 extends StatefulWidget {
  const SliderExample1({super.key});

  @override
  State<SliderExample1> createState() => _SliderExample1State();
}

class _SliderExample1State extends State<SliderExample1> {
  // A single-value slider in the 0–1 range (default).
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: (value) {
        setState(() {
          // Update local state when the thumb is dragged.
          this.value = value;
        });
      },
    );
  }
}
