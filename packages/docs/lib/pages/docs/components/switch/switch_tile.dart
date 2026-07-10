import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SwitchTile extends StatelessWidget implements IComponentPage {
  const SwitchTile({super.key});

  @override
  String get title => 'Switch';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'switch',
      title: 'Switch',
      scale: 2,
      center: true,
      example: Switch(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}
