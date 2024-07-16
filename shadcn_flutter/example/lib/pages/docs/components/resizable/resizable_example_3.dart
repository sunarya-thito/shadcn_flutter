import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample3 extends StatefulWidget {
  @override
  State<ResizableExample3> createState() => _ResizableExample3State();
}

class _ResizableExample3State extends State<ResizableExample3> {
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel(
        direction: Axis.horizontal,
        draggerBuilder: (context) {
          return HorizontalResizableDragger();
        },
        children: [
          ResizablePane(
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
            initialSize: 80,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 1,
              height: 200,
              fill: false,
            ),
            initialSize: 80,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 2,
              height: 200,
              fill: false,
            ),
            initialSize: 120,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 3,
              height: 200,
              fill: false,
            ),
            initialSize: 80,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 4,
              height: 200,
              fill: false,
            ),
            initialSize: 80,
          ),
        ],
      ),
    );
  }
}
