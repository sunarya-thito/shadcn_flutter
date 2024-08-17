import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample5 extends StatefulWidget {
  const ResizableExample5({super.key});

  @override
  State<ResizableExample5> createState() => _ResizableExample5State();
}

class _ResizableExample5State extends State<ResizableExample5> {
  final ResizablePaneController controller = ResizablePaneController(120);
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane.controlled(
            minSize: 100,
            collapsedSize: 40,
            controller: controller,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
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
            initialSize: 300,
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text('Resizable'),
            ),
          ),
        ],
      ),
    );
  }
}
