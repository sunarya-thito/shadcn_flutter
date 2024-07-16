import 'package:example/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample5 extends StatefulWidget {
  @override
  State<ResizableExample5> createState() => _ResizableExample5State();
}

class _ResizableExample5State extends State<ResizableExample5> {
  final ResizablePaneController controller = ResizablePaneController(120);
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
              height: 200,
              fill: false,
            ),
            minSize: 100,
            collapsedSize: 40,
            controller: controller,
          ),
          ResizablePane(
            child: NumberedContainer(
              index: 1,
              height: 200,
              fill: false,
            ),
            initialSize: 300,
          ),
        ],
      ),
    );
  }
}
