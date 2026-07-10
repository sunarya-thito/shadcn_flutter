import 'package:docs/pages/docs/components/color_picker/color_picker_example_2.dart';
import 'package:docs/pages/docs/components/color_picker/color_picker_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'color_picker/color_picker_example_1.dart';

class ColorPickerExample extends StatelessWidget {
  const ColorPickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'color_picker',
      description:
          'A color picker is a widget that allows the user to pick a color.',
      displayName: 'Color Picker',
      children: [
        WidgetUsageExample(
          title: 'Color Input Example',
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_1.dart',
          child: ColorPickerExample1(),
        ),
        WidgetUsageExample(
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_2.dart',
          title: 'Screen Color Picker Example',
          child: ColorPickerExample2(),
        ),
        WidgetUsageExample(
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_3.dart',
          title: 'Color Picker Trigger Example',
          child: ColorPickerExample3(),
        ),
      ],
    );
  }
}
