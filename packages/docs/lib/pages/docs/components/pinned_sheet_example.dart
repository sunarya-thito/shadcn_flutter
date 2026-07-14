import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_1.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_2.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_3.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_4.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_5.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PinnedSheetExample extends StatelessWidget {
  const PinnedSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'pinned_sheet',
      description:
          'A controller-driven, gesture-driven sheet that snaps between stages.',
      displayName: 'Pinned Sheet',
      children: [
        WidgetUsageExample(
          title: 'Backdrop transform',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_1.dart',
          child: PinnedSheetExample1(),
        ),
        WidgetUsageExample(
          title: 'Peek drag handle',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_2.dart',
          child: PinnedSheetExample2(),
        ),
        WidgetUsageExample(
          title: 'Sheet container',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_3.dart',
          child: PinnedSheetExample3(),
        ),
        WidgetUsageExample(
          title: 'Nested sheets',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_4.dart',
          child: PinnedSheetExample4(),
        ),
        WidgetUsageExample(
          title: 'Expands',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_5.dart',
          child: PinnedSheetExample5(),
        ),
      ],
    );
  }
}
