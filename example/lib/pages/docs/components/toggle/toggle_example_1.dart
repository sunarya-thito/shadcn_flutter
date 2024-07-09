import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToggleExample1 extends StatefulWidget {
  @override
  _ToggleExample1State createState() => _ToggleExample1State();
}

class _ToggleExample1State extends State<ToggleExample1> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Toggle(
      child: Text('Toggle'),
      value: value,
      onChanged: (v) {
        setState(() {
          value = v;
        });
      },
    );
  }
}
