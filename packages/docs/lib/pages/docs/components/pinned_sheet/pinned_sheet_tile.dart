import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PinnedSheetTile extends StatefulWidget implements IComponentPage {
  const PinnedSheetTile({super.key});

  @override
  String get title => 'Pinned Sheet';

  @override
  State<PinnedSheetTile> createState() => _PinnedSheetTileState();
}

class _PinnedSheetTileState extends State<PinnedSheetTile> {
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
    return ComponentCard(
      title: 'Pinned Sheet',
      name: 'pinned_sheet',
      fit: true,
      example: SizedBox(
        width: 300,
        height: 300,
        child: OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: PinnedSheet(
            controller: controller,
            position: OverlayPosition.bottom,
            stages: stages,
            initialStage: const SheetStage.peekDragHandle(),
            backdrop: Card(
              fillColor: theme.colorScheme.muted,
              filled: true,
              child: Center(child: const Text('Backdrop content').muted()),
            ),
            child: DrawerContainer(
              child: SizedBox(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pinned Sheet').large().medium(),
                      const Gap(4),
                      const Text('Drag the handle to expand').muted(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
