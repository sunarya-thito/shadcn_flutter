import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class CircularProgressExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'circular_progress',
      description: 'A circular progress indicator.',
      displayName: 'Circular Progress',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return CircularProgressIndicator();
          },
          code: 'CircularProgressIndicator()',
        ),
      ],
    );
  }
}
