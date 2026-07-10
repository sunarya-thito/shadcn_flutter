import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SliderTile extends StatelessWidget implements IComponentPage {
  const SliderTile({super.key});

  @override
  String get title => 'Slider';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'slider',
      title: 'Slider',
      center: true,
      scale: 2,
      example: Slider(
        value: const SliderValue.single(0.75),
        onChanged: (value) {},
      ).sized(width: 100),
    );
  }
}
