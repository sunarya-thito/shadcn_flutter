import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherTile extends StatelessWidget implements IComponentPage {
  const SwitcherTile({super.key});

  @override
  String get title => 'Switcher';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Switcher',
      name: 'switcher',
      center: true,
      example: ClipRect(
        child: SizedBox(
          width: 160,
          height: 120,
          child: Switcher(
            index: 0,
            direction: AxisDirection.left,
            children: [
              for (int i = 0; i < 3; i++)
                NumberedContainer(index: i, width: 160, height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
