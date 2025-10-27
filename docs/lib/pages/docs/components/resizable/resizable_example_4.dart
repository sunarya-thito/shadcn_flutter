import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample4 extends StatefulWidget {
  const ResizableExample4({super.key});

  @override
  State<ResizableExample4> createState() => _ResizableExample4State();
}

class _ResizableExample4State extends State<ResizableExample4> {
  // Controlled panes: each pane has its own controller so we can read/write size
  // and call helper methods (tryExpandSize, tryCollapse, etc.).
  final AbsoluteResizablePaneController controller1 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller2 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller3 =
      AbsoluteResizablePaneController(120);
  final AbsoluteResizablePaneController controller4 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller5 =
      AbsoluteResizablePaneController(80);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: ResizablePanel.horizontal(
            children: [
              ResizablePane.controlled(
                // Bind pane size to controller1 (initial 80px).
                controller: controller1,
                child: const NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller2,
                child: const NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller3,
                // Optional constraint: this pane cannot grow beyond 200px.
                maxSize: 200,
                child: const NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller4,
                child: const NumberedContainer(
                  index: 3,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller5,
                // Min size prevents the pane from being dragged smaller than 80px.
                minSize: 80,
                // When collapsed, this pane will reduce to 20px instead of disappearing.
                collapsedSize: 20,
                child: const NumberedContainer(
                  index: 4,
                  height: 200,
                  fill: false,
                ),
              ),
            ],
          ),
        ),
        const Gap(48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            PrimaryButton(
              onPressed: () {
                // Restore all panes to their initial sizes.
                controller1.size = 80;
                controller2.size = 80;
                controller3.size = 120;
                controller4.size = 80;
                controller5.size = 80;
              },
              child: const Text('Reset'),
            ),
            PrimaryButton(
              onPressed: () {
                // Attempt to grow pane 2 (controller3) by +20px.
                controller3.tryExpandSize(20);
              },
              child: const Text('Expand Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                // Attempt to shrink pane 2 (controller3) by -20px.
                controller3.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                // Modify another pane's size incrementally.
                controller2.tryExpandSize(20);
              },
              child: const Text('Expand Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller2.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(20);
              },
              child: const Text('Expand Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                // Collapse reduces the pane to its 'collapsedSize'.
                controller5.tryCollapse();
              },
              child: const Text('Collapse Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                // Expand restores from the collapsed state.
                controller5.tryExpand();
              },
              child: const Text('Expand Panel 4'),
            ),
          ],
        )
      ],
    );
  }
}
