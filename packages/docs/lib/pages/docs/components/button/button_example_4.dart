import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Ghost button.
///
/// Very subtle styling for least-emphasis or inline actions.
class ButtonExample4 extends StatelessWidget {
  const ButtonExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return GhostButton(
      onPressed: () {},
      child: const Text('Ghost'),
    );
  }
}
