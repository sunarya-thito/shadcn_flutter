import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample4 extends StatefulWidget {
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
          child: ResizablePanel(
            direction: Axis.horizontal,
            children: [
              ResizablePane.controlled(
                child: NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
                controller: controller1,
              ),
              ResizablePane.controlled(
                child: NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
                controller: controller2,
              ),
              ResizablePane.controlled(
                child: NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
                controller: controller3,
                maxSize: 200,
              ),
              ResizablePane.controlled(
                child: NumberedContainer(
                  index: 3,
                  height: 200,
                  fill: false,
                ),
                controller: controller4,
              ),
              ResizablePane.controlled(
                child: NumberedContainer(
                  index: 4,
                  height: 200,
                  fill: false,
                ),
                controller: controller5,
                minSize: 80,
                collapsedSize: 20,
              ),
            ],
          ),
        ),
        gap(48),
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
              child: Text('Reset'),
            ),
            PrimaryButton(
              onPressed: () {
                controller3.tryExpandSize(20);
              },
              child: Text('Expand Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                controller3.tryExpandSize(-20);
              },
              child: Text('Shrink Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                controller1.tryExpandSize(20);
              },
              child: Text('Expand Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller1.tryExpandSize(-20);
              },
              child: Text('Shrink Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(20);
              },
              child: Text('Expand Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(-20);
              },
              child: Text('Shrink Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryCollapse();
              },
              child: Text('Collapse Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpand();
              },
              child: Text('Expand Panel 4'),
            ),
          ],
        )
      ],
    );
  }
}