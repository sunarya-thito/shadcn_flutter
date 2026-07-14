import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample4 extends StatefulWidget {
  const SliderExample4({super.key});

  @override
  State<SliderExample4> createState() => _SliderExample4State();
}

class _SliderExample4State extends State<SliderExample4> {
  // A single-value slider in the 0–1 range (default).
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      valueIndicatorBuilder: (context, value) {
        return SliderValueIndicator(value: value);
      },
      onChanged: (value) {
        setState(() {
          // Update local state when the thumb is dragged.
          this.value = value;
        });
      },
    );
  }
}
