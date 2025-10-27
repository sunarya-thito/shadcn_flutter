import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Primary badge style.
///
/// Badges are small, attention-grabbing labels. Use `PrimaryBadge` for the
/// default emphasis.
class BadgeExample1 extends StatelessWidget {
  const BadgeExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimaryBadge(
      child: Text('Primary'),
    );
  }
}
