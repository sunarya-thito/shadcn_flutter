import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeExample2 extends StatelessWidget {
  const BadgeExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      padding: Button.badgePadding,
      child: Text('Secondary'),
    );
  }
}
