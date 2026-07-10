import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class CollapsibleTile extends StatelessWidget implements IComponentPage {
  const CollapsibleTile({super.key});

  @override
  String get title => 'Collapsible';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'collapsible',
      title: 'Collapsible',
      reverse: true,
      example: Card(
        child: Collapsible(
          children: [
            const CollapsibleTrigger(
              child: Text('@sunarya-thito starred 3 repositories'),
            ),
            OutlinedContainer(
              child: const Text('@sunarya-thito/shadcn_flutter')
                  .small()
                  .mono()
                  .withPadding(horizontal: 16, vertical: 8),
            ).withPadding(top: 8),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@flutter/flutter')
                    .small()
                    .mono()
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@dart-lang/sdk')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            const CollapsibleTrigger(
              child: Text('@flutter starred 1 repository'),
            ).withPadding(top: 16),
            OutlinedContainer(
              child: const Text('@sunarya-thito/shadcn_flutter')
                  .small()
                  .mono()
                  .withPadding(horizontal: 16, vertical: 8),
            ).withPadding(top: 8),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@flutter/flutter')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@dart-lang/sdk')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
          ],
        ),
      ),
    );
  }
}
