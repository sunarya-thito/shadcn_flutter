import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample4 extends StatefulWidget {
  const ResizableExample4({super.key});

  @override
  State<ResizableExample4> createState() => _ResizableExample4State();
}

class _ResizableExample4State extends State<ResizableExample4> {
  final ResizablePaneController controller1 = ResizablePaneController(80);
  final ResizablePaneController controller2 = ResizablePaneController(80);
  final ResizablePaneController controller3 = ResizablePaneController(120);
  final ResizablePaneController controller4 = ResizablePaneController(80);
  final ResizablePaneController controller5 = ResizablePaneController(80);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: ResizablePanel.horizontal(
            children: [
              ResizablePane.controlled(
                controller: controller1,
                child: const NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller2,
                child: const NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller3,
                maxSize: 200,
                child: const NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller4,
                child: const NumberedContainer(
                  index: 3,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller5,
                minSize: 80,
                collapsedSize: 20,
                child: const NumberedContainer(
                  index: 4,
                  height: 200,
                  fill: false,
                ),
              ),
            ],
          ),
        ),
        const Gap(48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            PrimaryButton(
              onPressed: () {
                controller1.size = 80;
                controller2.size = 80;
                controller3.size = 120;
                controller4.size = 80;
                controller5.size = 80;
              },
              child: const Text('Reset'),
            ),
            PrimaryButton(
              onPressed: () {
                controller3.tryExpandSize(20);
              },
              child: const Text('Expand Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                controller3.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                controller1.tryExpandSize(20);
              },
              child: const Text('Expand Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller1.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(20);
              },
              child: const Text('Expand Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryCollapse();
              },
              child: const Text('Collapse Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpand();
              },
              child: const Text('Expand Panel 4'),
            ),
          ],
        )
      ],
    );
  }
}
