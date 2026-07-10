import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample5 extends StatefulWidget {
  const ResizableExample5({super.key});

  @override
  State<ResizableExample5> createState() => _ResizableExample5State();
}

class _ResizableExample5State extends State<ResizableExample5> {
  final ResizablePaneController controller =
      AbsoluteResizablePaneController(120);
  final ResizablePaneController controller2 =
      AbsoluteResizablePaneController(120);
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane.controlled(
            // This controlled pane supports collapsing with a minimum and collapsed size.
            minSize: 100,
            collapsedSize: 40,
            controller: controller,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                // Render a different UI when the pane is collapsed.
                if (controller.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('Expanded'),
                );
              },
            ),
          ),
          ResizablePane(
            // A standard resizable pane with an absolute initial width.
            initialSize: 300,
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text('Resizable'),
            ),
          ),
          ResizablePane.controlled(
            minSize: 100,
            collapsedSize: 40,
            controller: controller2,
            child: AnimatedBuilder(
              animation: controller2,
              builder: (context, child) {
                if (controller2.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('Expanded'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
