import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../divider/divider_example_3.dart';

class DividerTile extends StatelessWidget implements IComponentPage {
  const DividerTile({super.key});

  @override
  String get title => 'Divider';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'divider',
      title: 'Divider',
      scale: 1.2,
      example: Card(child: DividerExample3()),
    );
  }
}
