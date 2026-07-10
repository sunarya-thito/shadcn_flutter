import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/material/material_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'material/cupertino_example_1.dart';

class MaterialExample extends StatelessWidget {
  const MaterialExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'external',
      component: false,
      description:
          'You can use Material/Cupertino Widgets with shadcn_flutter.',
      displayName: 'Material/Cupertino Widgets',
      children: [
        const Gap(24),
        Alert(
          leading: const Icon(Icons.info_outline),
          title: const Text('Note'),
          content: const Text(
                  'By default, Material/Cupertino Theme will follow shadcn_flutter theme. ')
              .thenButton(
                  onPressed: () {
                    context.goNamed('theme');
                  },
                  child: const Text(
                      'Try changing the shadcn_flutter theme right here!')),
        ),
        WidgetUsageExample(
          title: 'Material Example',
          path: 'lib/pages/docs/components/material/material_example_1.dart',
          summarize: false,
          child: const MaterialExample1().sized(width: 500, height: 900),
        ),
        WidgetUsageExample(
          title: 'Cupertino Example',
          path: 'lib/pages/docs/components/material/cupertino_example_1.dart',
          summarize: false,
          child: const CupertinoExample1().sized(width: 500, height: 900),
        ),
      ],
    );
  }
}
