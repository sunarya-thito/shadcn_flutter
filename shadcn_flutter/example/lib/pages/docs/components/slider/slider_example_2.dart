import 'package:shadcn_flutter/shadcn_flutter.dart';

class SliderExample2 extends StatefulWidget {
  @override
  State<SliderExample2> createState() => _SliderExample2State();
}

class _SliderExample2State extends State<SliderExample2> {
  SliderValue value = const SliderValue.ranged(0.5, 0.75);
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
      },
    );
  }
}
