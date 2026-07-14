import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A [PinnedSheet] using a [SheetContainer] that does not stretch edge-to-edge:
/// it is sized to 70% of the width and centered ([SheetContainer.alignCenter]
/// with an [AxisSize]). It also shows stage arithmetic — the expanded stage
/// stops 40px short of fully covering, and a per-stage backdrop transform.
class PinnedSheetExample3 extends StatefulWidget {
  const PinnedSheetExample3({super.key});

  @override
  State<PinnedSheetExample3> createState() => _PinnedSheetExample3State();
}

class _PinnedSheetExample3State extends State<PinnedSheetExample3> {
  final SheetController controller = SheetController();

  // Expanded, but 40px short of fully covering, with a gentler backdrop scale.
  static final SheetStage expanded =
      const SheetStage.expanded(backdropTransform: 0.4) -
          const SheetStage.fixed(40);

  late final List<SheetStage> stages = [
    const SheetStage.closed(),
    expanded,
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
          initialStage: const SheetStage.closed(),
          backdropTransform: const ScaleBackdropTransform(),
          backdrop: Container(
            color: theme.colorScheme.muted,
            alignment: Alignment.center,
            child: PrimaryButton(
              onPressed: () => controller.stage = expanded,
              child: const Text('Open sheet'),
            ),
          ),
          // Sized to 70% width, centered, with a bit of horizontal padding.
          child: SheetContainer.alignCenter(
            size: const AxisSize.fraction(0.7),
            startPadding: 12,
            endPadding: 12,
            child: SizedBox(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Centered sheet').large().medium(),
                    const Gap(8),
                    const Text(
                      'This sheet is 70% of the width and centered, and its '
                      'expanded stage stops 40px short of full.',
                    ).muted(),
                    const Gap(16),
                    SecondaryButton(
                      onPressed: () =>
                          controller.stage = const SheetStage.closed(),
                      child: const Text('Close'),
                    ),
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
