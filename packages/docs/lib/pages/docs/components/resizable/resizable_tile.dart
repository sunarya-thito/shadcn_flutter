import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import 'resizable_example_3.dart';

class ResizableTile extends StatelessWidget implements IComponentPage {
  const ResizableTile({super.key});

  @override
  String get title => 'Resizable';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'Resizable',
      name: 'resizable',
      scale: 1,
      example: ResizableExample3(),
    );
  }
}
