import 'package:shadcn_flutter/shadcn_flutter.dart';

class CollapsibleExample1 extends StatelessWidget {
  const CollapsibleExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Collapsible(
      children: [
        CollapsibleTrigger(
          child: Text('@sunarya-thito starred 3 repositories'),
        ),
        OutlinedContainer(
          child: Text('@sunarya-thito/shadcn_flutter')
              .small()
              .mono()
              .withPadding(horizontal: 16, vertical: 8),
        ).withPadding(top: 8),
        CollapsibleContent(
          child: OutlinedContainer(
            child: Text('@flutter/flutter')
                .small()
                .mono()
                .withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
        CollapsibleContent(
          child: OutlinedContainer(
            child: Text('@dart-lang/sdk')
                .small()
                .mono()
                .withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
      ],
    );
  }
}
