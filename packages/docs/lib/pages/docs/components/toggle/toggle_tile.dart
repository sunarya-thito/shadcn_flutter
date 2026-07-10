import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../toggle/toggle_example_2.dart';

class ToggleTile extends StatelessWidget implements IComponentPage {
  const ToggleTile({super.key});

  @override
  String get title => 'Toggle';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'toggle',
      title: 'Toggle',
      scale: 1.2,
      example: Card(
        child: const ToggleExample2().withAlign(Alignment.topLeft),
      ).sized(height: 300, width: 300),
    );
  }
}
