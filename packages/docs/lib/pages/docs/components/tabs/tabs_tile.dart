import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabsTile extends StatelessWidget implements IComponentPage {
  const TabsTile({super.key});

  @override
  String get title => 'Tabs';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Tabs',
      name: 'tabs',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            Tabs(index: 0, onChanged: (value) {}, children: const [
              // Text('Tab 1'),
              // Text('Tab 2'),
              // Text('Tab 3'),
              TabItem(child: Text('Tab 1')),
              TabItem(child: Text('Tab 2')),
              TabItem(child: Text('Tab 3')),
            ]),
            Tabs(index: 1, onChanged: (value) {}, children: const [
              TabItem(child: Text('Tab 1')),
              TabItem(child: Text('Tab 2')),
              TabItem(child: Text('Tab 3')),
            ]),
            Tabs(index: 2, onChanged: (value) {}, children: const [
              TabItem(child: Text('Tab 1')),
              TabItem(child: Text('Tab 2')),
              TabItem(child: Text('Tab 3')),
            ]),
          ],
        ).gap(8),
      ),
    );
  }
}
