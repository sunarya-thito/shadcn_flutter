import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitchExample1 extends StatefulWidget {
  const SwitchExample1({super.key});

  @override
  State<SwitchExample1> createState() => _SwitchExample1State();
}

class _SwitchExample1State extends State<SwitchExample1> {
  // Simple on/off state bound to the Switch.
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (value) {
        setState(() {
          // Flip the switch.
          this.value = value;
        });
      },
    );
  }
}
