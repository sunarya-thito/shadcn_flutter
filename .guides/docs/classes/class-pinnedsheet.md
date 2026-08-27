---
title: "Class: PinnedSheet"
description: "A controller-driven, gesture-driven sheet that snaps between [SheetStage]s.   A [PinnedSheet] is placed directly in the widget tree and controlled by a  [SheetController]. It slides in from [position], can be dragged, and snaps to  the nearest configured [stages] on release. When [backdropTransform] is  non-null and a [backdrop] is provided, the backdrop is transformed as the  sheet opens; the transform's progress is interpolated from each stage's  `backdropTransform`. Nested [PinnedSheet]s (a sheet inside another sheet's  [backdrop]) adjust their layout to hug the transformed backdrop.   The [child] is given loose constraints up to the region size (min 0), so a  `SizedBox.expand` child fills the whole backdrop while a content-sized child  shrink-wraps. The caller wraps [child] in a [DrawerContainer] or  [SheetContainer] to pick the chrome."
---

```dart
/// A controller-driven, gesture-driven sheet that snaps between [SheetStage]s.
///
/// A [PinnedSheet] is placed directly in the widget tree and controlled by a
/// [SheetController]. It slides in from [position], can be dragged, and snaps to
/// the nearest configured [stages] on release. When [backdropTransform] is
/// non-null and a [backdrop] is provided, the backdrop is transformed as the
/// sheet opens; the transform's progress is interpolated from each stage's
/// `backdropTransform`. Nested [PinnedSheet]s (a sheet inside another sheet's
/// [backdrop]) adjust their layout to hug the transformed backdrop.
///
/// The [child] is given loose constraints up to the region size (min 0), so a
/// `SizedBox.expand` child fills the whole backdrop while a content-sized child
/// shrink-wraps. The caller wraps [child] in a [DrawerContainer] or
/// [SheetContainer] to pick the chrome.
class PinnedSheet extends StatefulWidget {
  /// The sheet content (typically wrapped in a [DrawerContainer]/[SheetContainer]).
  /// If that container uses `expands`/`intrinsic`, set the matching
  /// [contentExpands]/[contentIntrinsic] here too — this sheet does not (and
  /// structurally cannot reliably) look inside [child] to find them.
  final Widget child;
  /// The edge the sheet is anchored to.
  final OverlayPosition position;
  /// The controller driving this sheet.
  final SheetController? controller;
  /// The snap stages. Defaults to `[SheetStage.closed(), SheetStage.expanded()]`.
  final List<SheetStage> stages;
  /// The stage the sheet rests at initially. Defaults to the first stage.
  final SheetStage? initialStage;
  /// The content shown behind the sheet, transformed by [backdropTransform].
  final Widget? backdrop;
  /// The backdrop transform. When null, the backdrop is not transformed.
  final BackdropTransform? backdropTransform;
  /// Whether the sheet can be dragged.
  final bool draggable;
  /// Whether dragging the [backdrop] also drives this sheet (so a closed sheet
  /// can be pulled open from its backdrop area). Taps still pass through to
  /// backdrop content; only drags are captured.
  final bool draggableBackdrop;
  /// Whether the drag handle is shown.
  final bool showDragHandle;
  /// Whether the sheet expands along the cross axis.
  final bool expands;
  /// Whether the sheet content is sized along the *main* axis to the
  /// currently visible extent (a physically shrinking/growing box) instead
  /// of sliding a fixed-size child.
  ///
  /// This mirrors [DrawerContainer.expands]/[SheetContainer.expands], but is
  /// this sheet's *own* setting, told to it directly, rather than something
  /// it tries to detect from [child]. [PinnedSheet] is [child]'s ancestor,
  /// so it cannot read a value [child] only declares once built — inferring
  /// it from `child`'s exact runtime type would work only when `child` is a
  /// [DrawerContainer]/[SheetContainer] *directly*, breaking silently (as if
  /// `false`) the moment it's wrapped in anything else (a `Builder`, a
  /// custom wrapper widget, conditional logic, ...). Set this to match
  /// whatever [child]'s own `expands` is.
  final bool contentExpands;
  /// Whether, in `contentExpands: true` mode, the sheet floors its main-axis
  /// size at the content's intrinsic size instead of clipping it down to
  /// nothing. Mirrors [DrawerContainer.intrinsic]/[SheetContainer.intrinsic]
  /// — set this to match whichever [child] uses. See [contentExpands] for
  /// why this is this sheet's own setting rather than inferred from [child].
  final bool contentIntrinsic;
  /// Whether a modal barrier is drawn behind the sheet.
  final bool modal;
  /// Whether tapping the barrier closes the sheet (to [SheetStage.closed]).
  final bool barrierDismissible;
  /// The barrier color.
  final Color? barrierColor;
  /// Corner radius override (provided to the container via [DrawerContainerData]).
  final BorderRadiusGeometry? borderRadius;
  /// Drag handle size override.
  final Size? dragHandleSize;
  /// Surface opacity for the container background.
  final double? surfaceOpacity;
  /// Surface blur for the container background.
  final double? surfaceBlur;
  /// Size constraints for the sheet content.
  final BoxConstraints? constraints;
  /// The default animation duration for open/close/snapping.
  final Duration duration;
  /// Creates a pinned sheet.
  const PinnedSheet({super.key, this.position = OverlayPosition.bottom, required this.child, this.controller, this.stages = const [SheetStage.closed(), SheetStage.expanded()], this.initialStage, this.backdrop, this.backdropTransform, this.draggable = true, this.draggableBackdrop = false, this.showDragHandle = true, this.expands = true, this.contentExpands = false, this.contentIntrinsic = true, this.modal = false, this.barrierDismissible = true, this.barrierColor, this.borderRadius, this.dragHandleSize, this.surfaceOpacity, this.surfaceBlur, this.constraints, this.duration = const Duration(milliseconds: 350)});
  State<PinnedSheet> createState();
}
```
