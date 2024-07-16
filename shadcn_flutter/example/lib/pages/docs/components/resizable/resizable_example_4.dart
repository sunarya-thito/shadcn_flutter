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
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel(
        direction: Axis.horizontal,
        children: [
          ResizablePane.controlled(
            child: NumberedContainer(
              index: 0,
              width: 200,
              fill: false,
            ),
            controller: controller1,
          ),
          ResizablePane.controlled(
            child: NumberedContainer(
              index: 1,
              width: 200,
              fill: false,
            ),
            controller: controller2,
          ),
          ResizablePane.controlled(
            child: NumberedContainer(
              index: 2,
              width: 200,
              fill: false,
            ),
            controller: controller3,
          ),
          ResizablePane.controlled(
            child: NumberedContainer(
              index: 3,
              width: 200,
              fill: false,
            ),
            controller: controller4,
          ),
          ResizablePane.controlled(
            child: NumberedContainer(
              index: 4,
              width: 200,
              fill: false,
            ),
            controller: controller5,
          ),
        ],
      ),
    );
  }
}
