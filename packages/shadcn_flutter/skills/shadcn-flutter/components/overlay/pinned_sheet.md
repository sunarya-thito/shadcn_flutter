# PinnedSheet

A controller-driven, gesture-driven sheet that snaps between [SheetStage]s.

## Usage

### Pinned Sheet Example
```dart
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_1.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_2.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_3.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_4.dart';
import 'package:docs/pages/docs/components/pinned_sheet/pinned_sheet_example_5.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PinnedSheetExample extends StatelessWidget {
  const PinnedSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'pinned_sheet',
      description:
          'A controller-driven, gesture-driven sheet that snaps between stages.',
      displayName: 'Pinned Sheet',
      children: [
        WidgetUsageExample(
          title: 'Backdrop transform',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_1.dart',
          child: PinnedSheetExample1(),
        ),
        WidgetUsageExample(
          title: 'Peek drag handle',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_2.dart',
          child: PinnedSheetExample2(),
        ),
        WidgetUsageExample(
          title: 'Sheet container',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_3.dart',
          child: PinnedSheetExample3(),
        ),
        WidgetUsageExample(
          title: 'Nested sheets',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_4.dart',
          child: PinnedSheetExample4(),
        ),
        WidgetUsageExample(
          title: 'Expands',
          path:
              'lib/pages/docs/components/pinned_sheet/pinned_sheet_example_5.dart',
          child: PinnedSheetExample5(),
        ),
      ],
    );
  }
}

```

### Pinned Sheet Example 1
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

```

### Pinned Sheet Example 2
```dart
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

```

### Pinned Sheet Example 3
```dart
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

```

### Pinned Sheet Example 4
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
            draggableBackdrop: true,
            // Multiple stages: drag snaps within the inner sheet, and once the
            // drag runs past the inner sheet's range it hands off to the outer.
            stages: const [
              SheetStage.closed(),
              SheetStage.fraction(0.5),
              SheetStage.expanded(),
            ],
            backdropTransform: const ScaleBackdropTransform(),
            backdrop: Container(
              color: theme.colorScheme.muted,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nested pinned sheets. ').large().medium(),
                  const Gap(8),
                  const Text(
                          'You can press the button or drag this container to open it.')
                      .muted(),
                  const Gap(16),
                  PrimaryButton(
                    onPressed: () => inner.stage = const SheetStage.expanded(),
                    child: const Text('Open inner'),
                  ),
                  const Gap(8),
                  PrimaryButton(
                    onPressed: () => outer.stage = const SheetStage.expanded(),
                    child: const Text('Open outer'),
                  ),
                ],
              ),
            ),
            child: _content(
              'Inner sheet',
              () => inner.stage = const SheetStage.closed(),
            ),
          ),
          child: _content(
            'Outer sheet',
            () => outer.stage = const SheetStage.closed(),
          ),
        ),
      ),
    );
  }
}

```

### Pinned Sheet Example 5
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
                const Gap(8),
                PrimaryButton(
                  onPressed: () => controller.stage = sixty,
                  child: const Text('60% (stops short)'),
                ),
              ],
            ),
          ),
          child: DrawerContainer(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sized to the visible extent').large().medium(),
                  const Gap(8),
                  const Text(
                    'With expands:true the sheet grows and shrinks with its '
                    'value instead of sliding. Drag it down to close.',
                  ).muted(),
                  // const Gap(16),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlineButton(
                      onPressed: () =>
                          controller.stage = const SheetStage.closed(),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

### Pinned Sheet Tile
```dart
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

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The sheet content (typically wrapped in a [DrawerContainer]/[SheetContainer]). If that container uses `expands`/`intrinsic`, set the matching [contentExpands]/[contentIntrinsic] here too — this sheet does not (and structurally cannot reliably) look inside [child] to find them. |
| `position` | `OverlayPosition` | The edge the sheet is anchored to. |
| `controller` | `SheetController?` | The controller driving this sheet. |
| `stages` | `List<SheetStage>` | The snap stages. Defaults to `[SheetStage.closed(), SheetStage.expanded()]`. |
| `initialStage` | `SheetStage?` | The stage the sheet rests at initially. Defaults to the first stage. |
| `backdrop` | `Widget?` | The content shown behind the sheet, transformed by [backdropTransform]. |
| `backdropTransform` | `BackdropTransform?` | The backdrop transform. When null, the backdrop is not transformed. |
| `draggable` | `bool` | Whether the sheet can be dragged. |
| `draggableBackdrop` | `bool` | Whether dragging the [backdrop] also drives this sheet (so a closed sheet can be pulled open from its backdrop area). Taps still pass through to backdrop content; only drags are captured. |
| `showDragHandle` | `bool` | Whether the drag handle is shown. |
| `expands` | `bool` | Whether the sheet expands along the cross axis. |
| `contentExpands` | `bool` | Whether the sheet content is sized along the *main* axis to the currently visible extent (a physically shrinking/growing box) instead of sliding a fixed-size child.  This mirrors [DrawerContainer.expands]/[SheetContainer.expands], but is this sheet's *own* setting, told to it directly, rather than something it tries to detect from [child]. [PinnedSheet] is [child]'s ancestor, so it cannot read a value [child] only declares once built — inferring it from `child`'s exact runtime type would work only when `child` is a [DrawerContainer]/[SheetContainer] *directly*, breaking silently (as if `false`) the moment it's wrapped in anything else (a `Builder`, a custom wrapper widget, conditional logic, ...). Set this to match whatever [child]'s own `expands` is. |
| `contentIntrinsic` | `bool` | Whether, in `contentExpands: true` mode, the sheet floors its main-axis size at the content's intrinsic size instead of clipping it down to nothing. Mirrors [DrawerContainer.intrinsic]/[SheetContainer.intrinsic] — set this to match whichever [child] uses. See [contentExpands] for why this is this sheet's own setting rather than inferred from [child]. |
| `modal` | `bool` | Whether a modal barrier is drawn behind the sheet. |
| `barrierDismissible` | `bool` | Whether tapping the barrier closes the sheet (to [SheetStage.closed]). |
| `barrierColor` | `Color?` | The barrier color. |
| `borderRadius` | `BorderRadiusGeometry?` | Corner radius override (provided to the container via [DrawerContainerData]). |
| `dragHandleSize` | `Size?` | Drag handle size override. |
| `surfaceOpacity` | `double?` | Surface opacity for the container background. |
| `surfaceBlur` | `double?` | Surface blur for the container background. |
| `constraints` | `BoxConstraints?` | Size constraints for the sheet content. |
| `duration` | `Duration` | The default animation duration for open/close/snapping. |
