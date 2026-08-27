---
title: "Example: components/pinned_sheet/pinned_sheet_example_4.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Nested [PinnedSheet]s. The outer sheet's [PinnedSheet.backdrop] contains a
/// second [PinnedSheet]; when the outer sheet scales its backdrop, the inner
/// sheet adjusts its layout to hug the transformed region.
class PinnedSheetExample4 extends StatefulWidget {
  const PinnedSheetExample4({super.key});

  @override
  State<PinnedSheetExample4> createState() => _PinnedSheetExample4State();
}

class _PinnedSheetExample4State extends State<PinnedSheetExample4> {
  final SheetController outer = SheetController();
  final SheetController inner = SheetController();

  @override
  void dispose() {
    outer.dispose();
    inner.dispose();
    super.dispose();
  }

  Widget _content(String title, VoidCallback onClose) {
    return DrawerContainer(
      child: SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title).large().medium(),
              const Gap(8),
              const Text('Drag me, or use the buttons.').muted(),
              const Gap(16),
              SecondaryButton(onPressed: onClose, child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 460,
      child: OutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: PinnedSheet(
          controller: outer,
          position: OverlayPosition.bottom,
          draggableBackdrop: true,
          backdropTransform: const ScaleBackdropTransform(),
          backdrop: PinnedSheet(
            controller: inner,
            position: OverlayPosition.bottom,
```
