import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A [PinnedSheet] with no backdrop transform, using [SheetStage.peekDragHandle]
/// so the closed-ish resting stage shows only the drag handle.
///
/// Because [PinnedSheet.backdropTransform] is null the backdrop is not scaled;
/// the sheet simply slides over it.
class PinnedSheetExample2 extends StatefulWidget {
  const PinnedSheetExample2({super.key});

  @override
  State<PinnedSheetExample2> createState() => _PinnedSheetExample2State();
}

class _PinnedSheetExample2State extends State<PinnedSheetExample2> {
  final SheetController controller = SheetController();

  static const List<SheetStage> stages = [
    SheetStage.peekDragHandle(),
    SheetStage.expanded(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 420,
      child: OutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: PinnedSheet(
          controller: controller,
          position: OverlayPosition.bottom,
          stages: stages,
          initialStage: const SheetStage.peekDragHandle(),
          // No backdropTransform: the backdrop is not scaled.
          backdrop: Card(
            fillColor: theme.colorScheme.muted,
            filled: true,
            child: Center(
                child:
                    const Text('Drag the handle to expand the sheet').muted()),
          ),
          child: DrawerContainer(
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Peek the drag handle').large().medium(),
                    const Gap(8),
                    const Text(
                      'At rest only the drag handle peeks out. Drag it up to '
                      'expand the sheet fully.',
                    ).muted(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
