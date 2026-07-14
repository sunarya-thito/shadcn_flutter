import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A controller-driven [PinnedSheet] with three snap stages.
///
/// The sheet is pinned to the bottom of a bounded region. It snaps between a
/// closed state, a half-open "peek" ([SheetStage.fraction]) and a fully
/// expanded state. The backdrop scales down while the sheet opens
/// ([PinnedSheet.backdropTransform]). The buttons drive the [SheetController],
/// and the sheet can also be dragged by its handle.
class PinnedSheetExample1 extends StatefulWidget {
  const PinnedSheetExample1({super.key});

  @override
  State<PinnedSheetExample1> createState() => _PinnedSheetExample1State();
}

class _PinnedSheetExample1State extends State<PinnedSheetExample1> {
  final SheetController controller = SheetController();

  static const List<SheetStage> stages = [
    SheetStage.closed(),
    SheetStage.fraction(0.4),
    SheetStage.expanded(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: OutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: PinnedSheet(
          controller: controller,
          position: OverlayPosition.bottom,
          stages: stages,
          initialStage: const SheetStage.fraction(0.4),
          backdropTransform: const ScaleBackdropTransform(),
          // The backdrop is scaled down as the sheet opens.
          backdrop: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return Opacity(
                opacity: 1.0 - controller.fraction,
                child: child,
              );
            },
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (controller.stage == const SheetStage.expanded()) {
                  controller.stage = const SheetStage.fraction(0.4);
                }
              },
              child: Card(
                filled: true,
                fillColor: Theme.of(context).colorScheme.muted,
                child: Center(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Backdrop content')
                            .large()
                            .medium()
                            .center(),
                        const Gap(8),
                        ListenableBuilder(
                          listenable: controller,
                          builder: (context, child) {
                            final percent = (controller.fraction * 100).round();
                            return Text('Sheet is $percent% open')
                                .muted()
                                .center();
                          },
                        ),
                        const Gap(24),
                        PrimaryButton(
                          onPressed: () =>
                              controller.stage = const SheetStage.expanded(),
                          alignment: Alignment.center,
                          child: const Text('Expand'),
                        ),
                        const Gap(8),
                        PrimaryButton(
                          onPressed: () =>
                              controller.stage = const SheetStage.fraction(0.4),
                          alignment: Alignment.center,
                          child: const Text('Peek'),
                        ),
                        const Gap(8),
                        PrimaryButton(
                          onPressed: () => controller.animateTo(
                            const SheetStage.closed(),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
                          alignment: Alignment.center,
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // The caller decides the chrome by wrapping their content in a
          // DrawerContainer (rounded, bordered) or a SheetContainer (edge-to-edge).
          child: DrawerContainer(
            child: Container(
              height: 320,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pinned sheet').large().medium(),
                  const Gap(8),
                  const Text(
                    'Drag the handle to snap between closed, peek and '
                    'expanded, or use the buttons on the backdrop.',
                  ).muted(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
