import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample2 extends StatefulWidget {
  @override
  State<ResizableExample2> createState() => _ResizableExample2State();
}

class _ResizableExample2State extends State<ResizableExample2> {
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel(
        direction: Axis.vertical,
        children: [
          ResizablePane(
            child: NumberedContainer(
              index: 0,
              width: 200,
              fill: false,
            ),
            initialSize: 80,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 1,
              width: 200,
              fill: false,
            ),
            initialSize: 120,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 2,
              width: 200,
              fill: false,
            ),
            initialSize: 80,
          ),
        ],
      ),
    );
  }
}
