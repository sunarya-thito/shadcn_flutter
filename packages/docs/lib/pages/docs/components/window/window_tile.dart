import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'window_example_1.dart';

class WindowTile extends StatelessWidget implements IComponentPage {
  const WindowTile({super.key});

  @override
  String get title => 'Window';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'window',
      title: 'Window',
      fit: true,
      example: SizedBox(
        width: 420,
        height: 660,
        child: WindowExample1(),
      ),
    );
  }
}
