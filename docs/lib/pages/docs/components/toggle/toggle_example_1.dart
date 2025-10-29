import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a basic boolean Toggle that flips its value when pressed.

class ToggleExample1 extends StatefulWidget {
  const ToggleExample1({super.key});

  @override
  ToggleExample1State createState() => ToggleExample1State();
}

class ToggleExample1State extends State<ToggleExample1> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Toggle(
      // Simple boolean toggle; style/semantics similar to a ToggleButton.
      value: value,
      onChanged: (v) {
        setState(() {
          value = v;
        });
      },
      child: const Text('Toggle'),
    );
  }
}
