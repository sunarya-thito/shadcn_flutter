import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabListExample1 extends StatefulWidget {
  const TabListExample1({super.key});

  @override
  State<TabListExample1> createState() => _TabListExample1State();
}

class _TabListExample1State extends State<TabListExample1> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabList(
          index: index,
          children: [
            TabButton(
              child: const Text('Tab 1'),
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            TabButton(
              child: const Text('Tab 2'),
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
            TabButton(
              child: const Text('Tab 3'),
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },
            ),
          ],
        ),
        const Gap(16),
        IndexedStack(
          index: index,
          children: const [
            NumberedContainer(
              index: 1,
            ),
            NumberedContainer(
              index: 2,
            ),
            NumberedContainer(
              index: 3,
            ),
          ],
        ).sized(height: 300),
      ],
    );
  }
}
