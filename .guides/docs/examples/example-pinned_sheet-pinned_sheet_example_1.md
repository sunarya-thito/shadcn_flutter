---
title: "Example: components/pinned_sheet/pinned_sheet_example_1.dart"
description: "Component example"
---

Source preview
```dart
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
```
