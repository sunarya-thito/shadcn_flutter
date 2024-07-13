import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample1 extends StatefulWidget {
  @override
  State<ResizableExample1> createState() => _ResizableExample1State();
}

class _ResizableExample1State extends State<ResizableExample1> {
  final ResizablePaneController controller1 = ResizablePaneController(80);
  final ResizablePaneController controller2 = ResizablePaneController(80);
  final ResizablePaneController controller3 = ResizablePaneController(80);
  final ResizablePaneController controller4 = ResizablePaneController(80);
  final ResizablePaneController controller5 = ResizablePaneController(80);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // sum value
        AnimatedBuilder(
          animation: Listenable.merge([
            controller1,
            controller2,
            controller3,
            controller4,
            controller5,
          ]),
          builder: (context, child) {
            return Text(
                'sum value: ${controller1.value + controller2.value + controller3.value + controller4.value + controller5.value}');
          },
        ),
        ResizablePanel(
          direction: Axis.horizontal,
          children: [
            ResizablePane.controlled(
              child: NumberedContainer(
                index: 0,
                height: 200,
              ),
              controller: controller1,
              // maxSize: 150,
              // minSize: 20,
            ),
            ResizablePane.controlled(
              child: NumberedContainer(
                index: 1,
                height: 200,
              ),
              controller: controller2,
              // maxSize: 100,
              // minSize: 20,
            ),
            ResizablePane.controlled(
              child: NumberedContainer(
                index: 2,
                height: 200,
              ),
              controller: controller3,
              // minSize: 100,
              // maxSize: 210,
            ),
            ResizablePane.controlled(
              child: NumberedContainer(
                index: 3,
                height: 200,
              ),
              controller: controller4,
              // maxSize: 100,
              // minSize: 20,
            ),
            ResizablePane.controlled(
              child: NumberedContainer(
                index: 4,
                height: 200,
              ),
              controller: controller5,
              // maxSize: 150,
              // minSize: 20,
            ),
          ],
        ),
      ],
    );
  }
}
