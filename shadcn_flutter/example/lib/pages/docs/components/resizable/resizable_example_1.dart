import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample1 extends StatefulWidget {
  @override
  State<ResizableExample1> createState() => _ResizableExample1State();
}

class _ResizableExample1State extends State<ResizableExample1> {
  @override
  Widget build(BuildContext context) {
    return ResizablePanel(
      direction: Axis.horizontal,
      children: [
        ResizablePane(
          child: NumberedContainer(
            index: 2,
            height: 200,
          ),
          initialSize: 120,
          minSize: 100,
          maxSize: 150,
          collapsedSize: 80,
        ),
        ResizablePane(
          child: NumberedContainer(
            index: 0,
            height: 200,
          ),
          initialSize: 80,
          maxSize: 160,
          minSize: 20,
          collapsedSize: 5,
        ),
        ResizablePane(
          child: NumberedContainer(
            index: 1,
            height: 200,
          ),
          initialSize: 80,
          maxSize: 100,
          minSize: 20,
        ),
        ResizablePane(
          child: NumberedContainer(
            index: 3,
            height: 200,
          ),
          initialSize: 80,
          maxSize: 100,
          minSize: 20,
        ),
        ResizablePane(
          child: NumberedContainer(
            index: 4,
            height: 200,
          ),
          initialSize: 80,
          maxSize: 250,
          minSize: 20,
          collapsedSize: 5,
        ),
      ],
    );
  }
}
