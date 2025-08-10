import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabListTile extends StatelessWidget implements IComponentPage {
  const TabListTile({super.key});

  @override
  String get title => 'Tab List';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tab_list',
      title: 'Tab List',
      scale: 1,
      reverseVertical: true,
      verticalOffset: 60,
      example: TabList(
        index: 0,
        onChanged: (value) {},
        children: const [
          TabItem(child: Text('Preview')),
          TabItem(child: Text('Code')),
          TabItem(child: Text('Design')),
          TabItem(child: Text('Settings')),
        ],
      ),
    );
  }
}
