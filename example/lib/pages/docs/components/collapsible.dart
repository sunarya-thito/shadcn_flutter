import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CollapsibleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'collapsible',
      description: 'A widget that can be expanded or collapsed.',
      displayName: 'Collapsible',
      children: [
        WidgetUsageExample(
          builder: (context) {
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
          },
          code: '''
Collapsible(
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
)''',
        ),
      ],
    );
  }
}
