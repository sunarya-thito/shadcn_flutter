import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample2 extends StatefulWidget {
  const ResizableExample2({super.key});

  @override
  State<ResizableExample2> createState() => _ResizableExample2State();
}

class _ResizableExample2State extends State<ResizableExample2> {
  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel.vertical(
        children: [
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              width: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 1,
              width: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 2,
              width: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}
