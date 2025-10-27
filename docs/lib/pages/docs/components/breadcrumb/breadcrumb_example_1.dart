import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Breadcrumb with arrow separators.
///
/// Demonstrates how to compose a [Breadcrumb] from a series of items,
/// mixing interactive [TextButton]s and static labels. The `separator`
/// controls the visual delimiter between items.
class BreadcrumbExample1 extends StatelessWidget {
  const BreadcrumbExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Breadcrumb(
      // Use a built-in arrow separator for a conventional look.
      separator: Breadcrumb.arrowSeparator,
      children: [
        TextButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Home'),
        ),
        const MoreDots(),
        TextButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Components'),
        ),
        // Final segment as a non-interactive label.
        const Text('Breadcrumb'),
      ],
    );
  }
}
