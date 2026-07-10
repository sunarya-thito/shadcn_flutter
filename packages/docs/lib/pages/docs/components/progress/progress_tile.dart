import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ProgressTile extends StatelessWidget implements IComponentPage {
  const ProgressTile({super.key});

  @override
  String get title => 'Progress';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Progress',
      name: 'progress',
      example: const Progress(
        progress: 0.75,
      ).sized(width: 200),
      center: true,
    );
  }
}
