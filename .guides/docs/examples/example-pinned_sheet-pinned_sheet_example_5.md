---
title: "Example: components/pinned_sheet/pinned_sheet_example_5.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Demonstrates `PinnedSheet(contentExpands: true)`: the sheet content is
/// sized to the visible extent (0 when closed → the backdrop size when fully
/// open) instead of sliding. With `contentIntrinsic: true` (the default) the
/// content stops shrinking at its intrinsic size, so it never overflows. The
/// "90%" stage (`SheetStage.expanded() * 0.9`) stops 10% short of fully
/// covering.
class PinnedSheetExample5 extends StatefulWidget {
  const PinnedSheetExample5({super.key});

  @override
  State<PinnedSheetExample5> createState() => _PinnedSheetExample5State();
}

class _PinnedSheetExample5State extends State<PinnedSheetExample5> {
  final SheetController controller = SheetController();

  static final SheetStage sixty = const SheetStage.expanded() * 0.6;

  late final List<SheetStage> stages = [
    const SheetStage.closed(),
    sixty,
    const SheetStage.expanded(),
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
      height: 460,
      child: OutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: PinnedSheet(
          controller: controller,
          position: OverlayPosition.bottom,
          stages: stages,
          initialStage: const SheetStage.closed(),
          // Sizes the content to the visible extent instead of sliding it.
          contentExpands: true,
          backdropTransform: const ScaleBackdropTransform(),
          backdrop: Container(
            color: theme.colorScheme.muted,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Full-height sheet').large().medium(),
                const Gap(16),
                PrimaryButton(
                  onPressed: () =>
                      controller.stage = const SheetStage.expanded(),
                  child: const Text('Cover backdrop'),
                ),
```
