import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Secondary badge style.
///
/// Use `SecondaryBadge` for a lighter emphasis compared to primary.
class BadgeExample2 extends StatelessWidget {
  const BadgeExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SecondaryBadge(
      child: Text('Secondary'),
    );
  }
}
