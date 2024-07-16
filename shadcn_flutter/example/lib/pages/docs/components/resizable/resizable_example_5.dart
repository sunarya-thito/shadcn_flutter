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
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                if (controller.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: Text('Expanded'),
                );
              },
            ),
            minSize: 100,
            collapsedSize: 40,
            controller: controller,
          ),
          ResizablePane(
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: Text('Resizable'),
            ),
            initialSize: 300,
          ),
        ],
      ),
    );
  }
}
