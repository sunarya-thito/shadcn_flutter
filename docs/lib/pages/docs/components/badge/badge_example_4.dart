import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Destructive badge style.
///
/// Use `DestructiveBadge` to call attention to critical or dangerous states.
class BadgeExample4 extends StatelessWidget {
  const BadgeExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return const DestructiveBadge(
      child: Text('Destructive'),
    );
  }
}
