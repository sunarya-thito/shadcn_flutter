import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class CircularProgressTile extends StatelessWidget implements IComponentPage {
  const CircularProgressTile({super.key});

  @override
  String get title => 'Circular Progress';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'circular_progress',
      title: 'Circular Progress',
      center: true,
      example: Transform.scale(
        scale: 3,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
