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
          title: 'Color Picker Example',
          path:
              'lib/pages/docs/components/color_picker/color_picker_example_1.dart',
          child: ColorPickerExample1(),
        ),
      ],
    );
  }
}
