import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Checkbox with three states (unchecked, indeterminate, checked).
///
/// Enabling [tristate] allows the middle "indeterminate" state.
class CheckboxExample2 extends StatefulWidget {
  const CheckboxExample2({super.key});

  @override
  State<CheckboxExample2> createState() => _CheckboxExample2State();
}

class _CheckboxExample2State extends State<CheckboxExample2> {
  CheckboxState _state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      state: _state,
      onChanged: (value) {
        setState(() {
          _state = value;
        });
      },
      trailing: const Text('Remember me'),
      // Allow toggling: unchecked -> indeterminate -> checked -> ...
      tristate: true,
    );
  }
}
