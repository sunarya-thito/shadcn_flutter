import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample1 extends StatefulWidget {
  const ResizableExample1({super.key});

  @override
  State<ResizableExample1> createState() => _ResizableExample1State();
}

class _ResizableExample1State extends State<ResizableExample1> {
  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // A horizontal panel splits available width into multiple resizable panes.
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane(
            // Initial width in logical pixels for this pane.
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 1,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 2,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 3,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 4,
              height: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}
