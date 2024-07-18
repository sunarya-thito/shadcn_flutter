import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/material/material_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'material/cupertino_example_1.dart';

class MaterialExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'external',
      component: false,
      description:
          'You can use Material/Cupertino Widgets with shadcn_flutter.',
      displayName: 'Material/Cupertino Widgets',
      children: [
        gap(24),
        Alert(
          leading: Icon(Icons.info_outline),
          title: Text('Note'),
          content: Text(
                  'By default, Material/Cupertino Theme will follow shadcn_flutter theme. ')
              .thenButton(
                  onPressed: () {
                    context.goNamed('theme');
                  },
                  child: Text(
                      'Try changing the shadcn_flutter theme right here!')),
        ),
        WidgetUsageExample(
          title: 'Material Example',
          child: MaterialExample1().sized(width: 500, height: 900),
          path: 'lib/pages/docs/components/material/material_example_1.dart',
          summarize: false,
        ),
        WidgetUsageExample(
          title: 'Cupertino Example',
          child: CupertinoExample1().sized(width: 500, height: 900),
          path: 'lib/pages/docs/components/material/cupertino_example_1.dart',
          summarize: false,
        ),
      ],
    );
  }
}
