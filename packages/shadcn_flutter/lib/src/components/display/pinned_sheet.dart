import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builder signature for pinned-sheet content.
typedef PinnedSheetBuilder = Widget Function(BuildContext context);

/// A mirror of the sheet's slide fraction, notified *separately* from the
/// driving [ControlledAnimation] itself.
///
/// Its only intended consumer is something that reacts purely at the render
/// layer — e.g. [FadeTransition]'s `RenderAnimatedOpacity`, whose listener
/// only ever calls `markNeedsPaint()` (verified against the Flutter SDK:
/// `RenderAnimatedOpacityMixin._updateOpacity`). That's what makes updating
/// this safe from within [RenderObject.performLayout], unlike notifying the
/// real animation: `markNeedsPaint()` only touches `PipelineOwner`'s paint
/// dirty list, never `BuildOwner`/`Element.markNeedsBuild()` — so nothing
/// listening to *this* object can ever trip Flutter's "Build scheduled
/// during frame" guard, the way a build-triggering `AnimatedBuilder`
/// listening to the real animation would. Never hand this to anything that
/// calls `setState()`/rebuilds a widget in response — only to paint-only
/// consumers.
///
/// This exists specifically so a modal sheet's dim (via
/// [DrawerContainerData.fadeAnimation]) can be corrected during
/// [_RenderPinnedSheetSlide.performLayout] — the same place
/// [_PinnedSheetState._settleInitialStage] resolves axis-dependent initial
/// stages ([SheetStage.fixed], [SheetStage.peekDragHandle]) — instead of
/// staying stuck at its pre-layout best-effort guess (which `FadeTransition`
/// would otherwise have already cached on attach, before layout ever runs)
/// until some unrelated interaction happens to notify the real animation.
class _PaintOnlyAnimation extends Animation<double>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  double _value;

  _PaintOnlyAnimation(this._value);

  @override
  double get value => _value;

  set value(double newValue) {
    if (_value == newValue) return;
    final wasForward = _value > 0;
    _value = newValue;
    notifyListeners();
    final isForward = _value > 0;
    if (wasForward != isForward) {
      notifyStatusListeners(
          isForward ? AnimationStatus.completed : AnimationStatus.dismissed);
    }
  }

  @override
  AnimationStatus get status =>
      _value > 0 ? AnimationStatus.completed : AnimationStatus.dismissed;
}

/// Minimum leftover drag delta (logical px) worth forwarding to a parent sheet.
const double _kDragEpsilon = 0.01;

/// The context a [SheetStage] resolves against: the sheet's content [size], the
/// resolved edge [position], and the container's [dragHandleExtent] (main-axis
/// pixels occupied by the drag handle, including its gaps; 0 when there is no
/// handle).
class SheetStageResolution {
  /// The measured sheet content size.
  final Size size;

  /// The resolved edge position (never start/end).
  final OverlayPosition position;

  /// The main-axis extent of the drag handle (+ gaps); 0 when there is none.
  final double dragHandleExtent;

  /// Creates a resolution context.
  const SheetStageResolution({
    required this.size,
    required this.position,
    this.dragHandleExtent = 0,
  });

  /// The extent of the sheet along its drag axis.
  double get axisExtent {
    switch (position) {
      case OverlayPosition.top:
      case OverlayPosition.bottom:
        return size.height;
      default:
        return size.width;
    }
  }
}

double _fallbackBackdropTransform(SheetStage stage, SheetStageResolution res) {
  final axis = res.axisExtent;
  if (axis <= 0) return 0;
  return (stage.resolveDragOffset(res) / axis).clamp(0.0, 1.0);
}

/// A snap position for a [PinnedSheet].
///
/// A stage resolves to a *visible extent* (logical pixels) along the sheet's
/// axis ([resolveDragOffset]) and, independently, to a *backdrop transform*
/// value in `0..1` ([resolveBackdropTransform]). When a stage's explicit
/// `backdropTransform` is null it falls back to the stage's normalized
/// expansion (offset / axis extent).
///
/// Stages support arithmetic so you can express derived snap points:
///
/// ```dart
/// SheetStage.expanded() - SheetStage.fixed(100); // 100px short of full
/// SheetStage.expanded() * 0.9;                    // 90% of full
/// SheetStage.fixed(100) + SheetStage.fraction(0.5);
/// ```
///
/// Built-in stages: [SheetStage.closed], [SheetStage.expanded],
/// [SheetStage.fixed], [SheetStage.fraction], [SheetStage.peekDragHandle].
abstract class SheetStage {
  /// Const constructor for subclasses.
  const SheetStage();

  /// A fully-hidden stage (offset 0).
  const factory SheetStage.closed({double? backdropTransform}) =
      ClosedSheetStage;

  /// A fully-shown stage (offset == the full axis extent).
  const factory SheetStage.expanded({double? backdropTransform}) =
      ExpandedSheetStage;

  /// A stage pinned at a fixed number of logical pixels from the edge.
  const factory SheetStage.fixed(double offset, {double? backdropTransform}) =
      FixedSheetStage;

  /// A stage pinned at a [fraction] (0..1) of the sheet's axis extent.
  const factory SheetStage.fraction(double fraction,
      {double? backdropTransform}) = FractionSheetStage;

  /// A stage that peeks only the drag handle. For containers without a drag
  /// handle the handle extent is 0, so this behaves like [SheetStage.closed].
  const factory SheetStage.peekDragHandle({double? backdropTransform}) =
      PeekDragHandleSheetStage;

  /// The visible extent (logical pixels) this stage resolves to.
  double resolveDragOffset(SheetStageResolution resolution);

  /// The backdrop transform value (0..1) this stage resolves to.
  double resolveBackdropTransform(SheetStageResolution resolution);

  /// Sum of two stages (offsets and backdrop transforms are added).
  SheetStage operator +(SheetStage other) => AdditiveSheetStage(this, other);

  /// Difference of two stages (offsets and backdrop transforms are subtracted).
  SheetStage operator -(SheetStage other) => SubtractedSheetStage(this, other);

  /// Scales this stage's offset and backdrop transform by [factor].
  SheetStage operator *(double factor) => MultipliedSheetStage(this, factor);

  /// Divides this stage's offset and backdrop transform by [factor].
  SheetStage operator /(double factor) => DividedSheetStage(this, factor);

  @override
  bool operator ==(Object other) {
    // When compared against a live controller stage, borrow its attached state
    // to resolve this stage and compare the actual pixel offsets.
    if (other is _AttachedSheetStage) {
      return other == this;
    }
    return identical(this, other);
  }

  @override
  int get hashCode => identityHashCode(this);
}

/// A [SheetStage] that is fully hidden.
class ClosedSheetStage extends SheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a closed stage.
  const ClosedSheetStage({this.backdropTransform});

  @override
  double resolveDragOffset(SheetStageResolution resolution) => 0;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [SheetStage] that is fully expanded.
class ExpandedSheetStage extends SheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates an expanded stage.
  const ExpandedSheetStage({this.backdropTransform});

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      resolution.axisExtent;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [SheetStage] pinned at a fixed number of logical pixels.
class FixedSheetStage extends SheetStage {
  /// The pixel offset from the closed edge.
  final double offset;

  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a fixed-offset stage.
  const FixedSheetStage(this.offset, {this.backdropTransform});

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      min(offset, resolution.axisExtent);

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [SheetStage] pinned at a fraction of the sheet's axis extent.
class FractionSheetStage extends SheetStage {
  /// The fraction (0..1) of the axis extent.
  final double fraction;

  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a fractional stage.
  const FractionSheetStage(this.fraction, {this.backdropTransform});

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      resolution.axisExtent * fraction;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [SheetStage] that peeks only the drag handle.
class PeekDragHandleSheetStage extends SheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a peek-drag-handle stage.
  const PeekDragHandleSheetStage({this.backdropTransform});

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      resolution.dragHandleExtent;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// Sum of two stages.
class AdditiveSheetStage extends SheetStage {
  /// The left operand.
  final SheetStage a;

  /// The right operand.
  final SheetStage b;

  /// Creates an additive stage.
  const AdditiveSheetStage(this.a, this.b);

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      a.resolveDragOffset(resolution) + b.resolveDragOffset(resolution);

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      a.resolveBackdropTransform(resolution) +
      b.resolveBackdropTransform(resolution);
}

/// Difference of two stages.
class SubtractedSheetStage extends SheetStage {
  /// The left operand.
  final SheetStage a;

  /// The right operand.
  final SheetStage b;

  /// Creates a subtracted stage.
  const SubtractedSheetStage(this.a, this.b);

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      a.resolveDragOffset(resolution) - b.resolveDragOffset(resolution);

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      a.resolveBackdropTransform(resolution) -
      b.resolveBackdropTransform(resolution);
}

/// A stage scaled by a scalar [factor].
class MultipliedSheetStage extends SheetStage {
  /// The operand.
  final SheetStage stage;

  /// The scalar factor.
  final double factor;

  /// Creates a multiplied stage.
  const MultipliedSheetStage(this.stage, this.factor);

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      stage.resolveDragOffset(resolution) * factor;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      stage.resolveBackdropTransform(resolution) * factor;
}

/// A stage divided by a scalar [factor].
class DividedSheetStage extends SheetStage {
  /// The operand.
  final SheetStage stage;

  /// The scalar divisor.
  final double factor;

  /// Creates a divided stage.
  const DividedSheetStage(this.stage, this.factor);

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      stage.resolveDragOffset(resolution) / factor;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      stage.resolveBackdropTransform(resolution) / factor;
}

/// A live stage bound to a [PinnedSheet]'s state, returned by
/// [SheetController.stage]. Comparing it to another [SheetStage] resolves both
/// against the sheet's current geometry and compares the pixel offsets, so
/// `controller.stage == (SheetStage.expanded() - SheetStage.fixed(100))` works.
class _AttachedSheetStage extends SheetStage {
  final _PinnedSheetState _state;

  const _AttachedSheetStage(this._state);

  @override
  double resolveDragOffset(SheetStageResolution resolution) =>
      _state.currentOffset;

  @override
  double resolveBackdropTransform(SheetStageResolution resolution) =>
      _state.currentBackdropTransform;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is _AttachedSheetStage) {
      return identical(_state, other._state);
    }
    if (other is SheetStage) {
      final resolution = _state.resolution;
      final current = _state.currentOffset;
      final target = other.resolveDragOffset(resolution);
      return (current - target).abs() < 0.5;
    }
    return false;
  }

  @override
  int get hashCode => identityHashCode(_state);
}

/// Controls a [PinnedSheet]: reads its current position and drives it to a
/// [SheetStage].
///
/// The controller is a [ChangeNotifier] that notifies whenever the sheet's
/// position changes. [stage] returns a live stage that can be compared against
/// derived stages:
///
/// ```dart
/// final controller = SheetController();
/// ...
/// PinnedSheet(controller: controller, child: ...);
/// ...
/// controller.stage = SheetStage.expanded();
/// controller.animateTo(SheetStage.fixed(120),
///     duration: kDefaultDuration, curve: Curves.easeOut);
/// if (controller.stage == (SheetStage.expanded() - SheetStage.fixed(100))) { ... }
/// ```
class SheetController extends ChangeNotifier {
  _PinnedSheetState? _state;

  /// Whether this controller is attached to a live [PinnedSheet].
  bool get isAttached => _state != null;

  void _attach(_PinnedSheetState state) {
    _state = state;
    notifyListeners();
  }

  void _detach(_PinnedSheetState state) {
    if (identical(_state, state)) {
      _state = null;
    }
  }

  void _notify() => notifyListeners();

  /// The current visible extent of the sheet, in logical pixels.
  double get offset => _state?.currentOffset ?? 0.0;

  /// The current visible extent of the sheet, as a fraction (0..1) of its axis.
  double get fraction => _state?.currentFraction ?? 0.0;

  /// Whether the sheet is showing at all.
  bool get isOpen => fraction > 0;

  /// The current position as a live stage that can be compared against other
  /// (possibly derived) stages using `==`.
  SheetStage get stage =>
      _state != null ? _AttachedSheetStage(_state!) : const SheetStage.closed();

  /// Assigning a stage animates the sheet to it with the default duration/curve.
  set stage(SheetStage stage) {
    animateTo(stage);
  }

  /// Animates the sheet to [stage].
  Future<void> animateTo(
    SheetStage stage, {
    Duration duration = kDefaultDuration,
    Curve curve = Curves.linear,
  }) {
    final state = _state;
    if (state == null) return Future<void>.value();
    return state.animateToStage(stage, duration: duration, curve: curve);
  }

  /// Immediately jumps the sheet to [stage] with no animation.
  void jumpTo(SheetStage stage) {
    _state?.jumpToStage(stage);
  }

  /// Animates the sheet fully open ([SheetStage.expanded]).
  Future<void> open({
    Duration duration = kDefaultDuration,
    Curve curve = Curves.easeOut,
  }) =>
      animateTo(const SheetStage.expanded(), duration: duration, curve: curve);

  /// Animates the sheet fully closed ([SheetStage.closed]).
  Future<void> close({
    Duration duration = kDefaultDuration,
    Curve curve = Curves.easeOut,
  }) =>
      animateTo(const SheetStage.closed(), duration: duration, curve: curve);
}

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
  const PinnedSheet({
    super.key,
    this.position = OverlayPosition.bottom,
    required this.child,
    this.controller,
    this.stages = const [SheetStage.closed(), SheetStage.expanded()],
    this.initialStage,
    this.backdrop,
    this.backdropTransform,
    this.draggable = true,
    this.draggableBackdrop = false,
    this.showDragHandle = true,
    this.expands = true,
    this.contentExpands = false,
    this.contentIntrinsic = true,
    this.modal = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.borderRadius,
    this.dragHandleSize,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.constraints,
    this.duration = const Duration(milliseconds: 350),
  });

  @override
  State<PinnedSheet> createState() => _PinnedSheetState();
}

class _PinnedSheetState extends State<PinnedSheet>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late ControlledAnimation _anim;
  late AnimationController _overscrollController;
  late ControlledAnimation _overscroll;

  /// Paint-only mirror of [_anim], used for [DrawerContainerData.fadeAnimation]
  /// (the modal dim). See [_PaintOnlyAnimation] for why this needs to be a
  /// separate object rather than handing out [_anim] itself.
  late final _PaintOnlyAnimation _fadeMirror = _PaintOnlyAnimation(0);

  Size _lastAvailableSize = Size.zero;

  /// The content's own natural size, written directly by
  /// [_RenderPinnedSheetSlide] after each of its layouts (a plain field the
  /// render object keeps in sync — not a `GlobalKey` lookup). Null until
  /// that render object has laid out a child at least once.
  Size? _measuredContentSize;

  /// The parent sheet this sheet is nested inside (its backdrop), used to hand
  /// off overscroll when a drag runs past this sheet's own range.
  _PinnedSheetState? _parentSheet;

  /// Whether a drag is currently in progress (so config changes don't re-snap
  /// the sheet mid-drag).
  bool _dragging = false;

  /// The stage to settle onto as soon as the first layout is known. Applied
  /// synchronously during the first layout (see [_settleInitialStage]) —
  /// not in a post-frame callback — so the sheet doesn't paint one frame at
  /// its default (closed) position before snapping to [initialStage].
  late SheetStage _initialStage;
  bool _stageSettled = false;

  BackdropTransform get _effectiveTransform =>
      widget.backdropTransform ?? BackdropTransform.none;

  List<SheetStage> get effectiveStages =>
      widget.stages.isEmpty ? const [SheetStage.closed()] : widget.stages;

  @override
  void initState() {
    super.initState();
    _slideController =
        AnimationController(vsync: this, duration: widget.duration);
    _anim = ControlledAnimation(_slideController);
    _overscrollController =
        AnimationController(vsync: this, duration: widget.duration);
    _overscroll = ControlledAnimation(_overscrollController);
    _initialStage = widget.initialStage ?? effectiveStages.first;
    _anim.addListener(_onAnimTick);
    widget.controller?._attach(this);
  }

  /// Best-effort seed for the very first [build], before this sheet has
  /// ever been laid out (so the true axis extent isn't knowable yet at all).
  /// Uses [_normalizedForBestEffort], which is *exact* — not a guess — for
  /// [SheetStage.closed], [SheetStage.expanded], [SheetStage.fraction], and
  /// compositions of those; only genuinely axis-dependent stages
  /// ([SheetStage.fixed], [SheetStage.peekDragHandle]) fall back to 0 here,
  /// corrected below by [_settleInitialStage] once layout actually knows the
  /// axis. This matters because build-time listeners of [_anim] or
  /// [_fadeMirror] — this sheet's own [backdrop] transform, and anything
  /// external like a `ListenableBuilder(listenable: controller)` a caller
  /// wires up themselves — read whatever's seeded *now*; unlike
  /// [_settleInitialStage]'s correction (mid-frame, from performLayout,
  /// which can only notify _fadeMirror safely — see [_PaintOnlyAnimation]),
  /// this one runs before anything has built yet, so it's the only
  /// opportunity to get external, build-time consumers right on the very
  /// first frame. Does *not* mark the stage as settled, so that correction
  /// still runs.
  void _seedInitialStageBestEffort() {
    if (_stageSettled) return;
    final value = _normalizedForBestEffort(_initialStage);
    _anim.seed(value);
    // Safe unconditionally (see _PaintOnlyAnimation): nothing is attached to
    // this mirror yet at this point either way.
    _fadeMirror.value = value;
  }

  /// Settles the sheet onto [_initialStage] once the first real layout size
  /// is known. Called from [_RenderPinnedSheetSlide.performLayout] — not a
  /// post-frame callback, not a `LayoutBuilder` — so the very first painted
  /// frame already reflects the initial stage instead of flashing closed
  /// for one frame first. Uses [ControlledAnimation.seed], not the regular
  /// `value` setter: by the time this runs, an `AnimatedBuilder` elsewhere
  /// in this same frame's tree may already be listening to [_anim], and
  /// notifying it mid-frame trips Flutter's "Build scheduled during frame"
  /// guard. [seed] establishes the value without notifying anyone, which
  /// this render object's own paint (right after, in the same performLayout
  /// call) sees correctly.
  ///
  /// [_fadeMirror], in contrast, *is* safe to notify here — see
  /// [_PaintOnlyAnimation] — which is what actually fixes the modal dim for
  /// axis-dependent initial stages ([SheetStage.fixed],
  /// [SheetStage.peekDragHandle]): the best-effort seed above may have
  /// guessed wrong (axis unknown before layout), and `FadeTransition` would
  /// otherwise be stuck showing that wrong guess — already cached on attach,
  /// before this layout ever ran — until an unrelated interaction happened
  /// to notify [_anim] for an unrelated reason.
  void _settleInitialStage() {
    if (_stageSettled) return;
    _stageSettled = true;
    final value = _normalizedFor(_initialStage);
    _anim.seed(value);
    _fadeMirror.value = value;
  }

  @override
  void didUpdateWidget(covariant PinnedSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }
    if (widget.duration != oldWidget.duration) {
      _slideController.duration = widget.duration;
      _overscrollController.duration = widget.duration;
    }
    // When the stage set changes (e.g. edited on hot reload), re-settle onto the
    // nearest new stage so the sheet isn't stranded at an old stage's position.
    final oldStages = oldWidget.stages;
    final newStages = widget.stages;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _dragging || _slideController.isAnimating) return;
      final res = resolution;
      final axis = res.axisExtent;
      if (axis <= 0) return;
      double norm(SheetStage s) =>
          (s.resolveDragOffset(res) / axis).clamp(0.0, 1.0);
      final oldNorms = oldStages.map(norm).toList()..sort();
      final newNorms = newStages.map(norm).toList()..sort();
      var changed = oldNorms.length != newNorms.length;
      for (var i = 0; !changed && i < newNorms.length; i++) {
        changed = (oldNorms[i] - newNorms[i]).abs() > 0.001;
      }
      if (changed) {
        final stages = effectiveStages;
        if (stages.isNotEmpty) {
          jumpToStage(stages[_nearestStageIndex(_anim.value)]);
        }
      }
    });
  }

  @override
  void dispose() {
    _anim.removeListener(_onAnimTick);
    widget.controller?._detach(this);
    _slideController.dispose();
    _overscrollController.dispose();
    super.dispose();
  }

  void _onAnimTick() {
    widget.controller?._notify();
    // Keeps _fadeMirror in sync for every *real* tick (drags, ticker-driven
    // animateTo/forward/snap) — these always happen outside build/layout, so
    // notifying here is always safe regardless of what's listening.
    _fadeMirror.value = _anim.value;
  }

  OverlayPosition get resolvedPosition =>
      _resolvePosition(widget.position, Directionality.of(context));

  static OverlayPosition _resolvePosition(
      OverlayPosition position, TextDirection direction) {
    if (position == OverlayPosition.start) {
      return direction == TextDirection.ltr
          ? OverlayPosition.left
          : OverlayPosition.right;
    }
    if (position == OverlayPosition.end) {
      return direction == TextDirection.ltr
          ? OverlayPosition.right
          : OverlayPosition.left;
    }
    return position;
  }

  Size get _contentSize => _measuredContentSize ?? _lastAvailableSize;

  /// Whether the child requests visible-extent sizing —
  /// [PinnedSheet.contentExpands], told to this sheet directly rather than
  /// inferred from [widget.child]'s runtime type.
  bool get _childExpands => widget.contentExpands;

  /// Whether, in [_childExpands] mode, the sheet floors at the content's
  /// intrinsic size — [PinnedSheet.contentIntrinsic].
  bool get _childIntrinsic => widget.contentIntrinsic;

  /// In expands mode the sheet is measured against the full region (its fully
  /// open extent is the backdrop size); otherwise against the measured child.
  Size get _effectiveContentSize =>
      _childExpands ? _lastAvailableSize : _contentSize;

  /// Main-axis extent (including gaps) of the drag handle, or 0 when hidden.
  double get _dragHandleExtent {
    if (!widget.showDragHandle) return 0;
    final theme = Theme.of(context);
    final densityGap = theme.density.baseGap * theme.scaling;
    final isVertical = resolvedPosition == OverlayPosition.top ||
        resolvedPosition == OverlayPosition.bottom;
    final handleMain = isVertical
        ? (widget.dragHandleSize?.height ?? densityGap * 0.75)
        : (widget.dragHandleSize?.width ?? densityGap * 0.75);
    // Matches DrawerRawContainer's default gaps.
    final gapBefore = densityGap * 1.5;
    final gapAfter = densityGap * 2;
    return handleMain + gapBefore + gapAfter;
  }

  /// The resolution context describing the current sheet geometry.
  SheetStageResolution get resolution => SheetStageResolution(
        size: _effectiveContentSize,
        position: resolvedPosition,
        dragHandleExtent: _dragHandleExtent,
      );

  double get _axis => max(1.0, resolution.axisExtent);

  double get currentFraction => _anim.value.clamp(0.0, 1.0);

  double get currentOffset => currentFraction * _axis;

  /// The current backdrop transform value, interpolated piecewise between the
  /// stages' backdrop transforms by the current pixel offset.
  double get currentBackdropTransform {
    final res = resolution;
    final axis = res.axisExtent;
    if (axis <= 0) return currentFraction;
    final current = currentOffset;
    final knots = <MapEntry<double, double>>[
      for (final stage in effectiveStages)
        MapEntry(
          stage.resolveDragOffset(res).clamp(0.0, axis),
          stage.resolveBackdropTransform(res).clamp(0.0, 1.0),
        ),
    ]..sort((a, b) => a.key.compareTo(b.key));
    if (knots.isEmpty) return currentFraction;
    if (current <= knots.first.key) return knots.first.value;
    if (current >= knots.last.key) return knots.last.value;
    for (var i = 0; i < knots.length - 1; i++) {
      final a = knots[i];
      final b = knots[i + 1];
      if (current >= a.key && current <= b.key) {
        final range = b.key - a.key;
        if (range <= 0) return a.value;
        final f = (current - a.key) / range;
        return a.value + (b.value - a.value) * f;
      }
    }
    return knots.last.value;
  }

  double _normalizedFor(SheetStage stage) {
    final res = resolution;
    final axis = res.axisExtent;
    if (axis <= 0) return 0.0;
    return (stage.resolveDragOffset(res) / axis).clamp(0.0, 1.0);
  }

  /// Like [_normalizedFor], but usable before this sheet has ever been laid
  /// out — i.e. before the true axis extent is knowable at all, not just
  /// before it happens to be cached (see [_seedInitialStageBestEffort]).
  ///
  /// Resolves [stage] against two different *placeholder* axis sizes.
  /// [SheetStage.closed], [SheetStage.expanded], [SheetStage.fraction], and
  /// arithmetic compositions of those (`* factor`, `+`/`-` two such stages,
  /// ...) resolve to `axisExtent * k` for some constant `k` — the axis
  /// cancels out of the normalized fraction, so both placeholders agree, and
  /// that agreed value is exact, not a guess, regardless of what the real
  /// axis turns out to be. [SheetStage.fixed] and [SheetStage.peekDragHandle]
  /// (or any stage mixing proportional and non-proportional terms) resolve
  /// to something that does NOT scale with the placeholder — the two probes
  /// disagree, and this falls back to 0 for those (corrected once the real
  /// axis is known — see [_settleInitialStage]). This probes arithmetically
  /// rather than checking stage *types*, so it works for arbitrary composed
  /// stages without needing to special-case each one.
  double _normalizedForBestEffort(SheetStage stage) {
    double normalizedAt(double placeholderAxis) {
      final res = SheetStageResolution(
        size: _isVertical
            ? Size(0, placeholderAxis)
            : Size(placeholderAxis, 0),
        position: resolvedPosition,
        dragHandleExtent: _dragHandleExtent,
      );
      return (stage.resolveDragOffset(res) / placeholderAxis).clamp(0.0, 1.0);
    }

    final probeA = normalizedAt(100.0);
    final probeB = normalizedAt(1000.0);
    if ((probeA - probeB).abs() < 1e-9) {
      return probeA;
    }
    return 0.0;
  }

  Future<void> animateToStage(
    SheetStage stage, {
    Duration duration = kDefaultDuration,
    Curve curve = Curves.linear,
  }) {
    _slideController.duration = duration;
    final target = _normalizedFor(stage);
    return _anim.forward(target, curve).orCancel.catchError((_) {});
  }

  void jumpToStage(SheetStage stage) {
    _anim.value = _normalizedFor(stage);
    widget.controller?._notify();
    if (mounted) setState(() {});
  }

  int _nearestStageIndex(double value) {
    final stages = effectiveStages;
    int best = 0;
    double bestDist = double.infinity;
    for (int i = 0; i < stages.length; i++) {
      final dist = (value - _normalizedFor(stages[i])).abs();
      if (dist < bestDist) {
        bestDist = dist;
        best = i;
      }
    }
    return best;
  }

  double get _dragSign {
    // Positive primaryDelta should open the sheet.
    switch (resolvedPosition) {
      case OverlayPosition.left:
      case OverlayPosition.top:
        return 1;
      default:
        return -1;
    }
  }

  /// Whether this sheet drags along the vertical axis (top/bottom) rather
  /// than the horizontal one (left/right).
  bool get _isVertical =>
      resolvedPosition == OverlayPosition.top ||
      resolvedPosition == OverlayPosition.bottom;

  /// Applies a raw [primaryDelta] to this sheet, clamped to its `[0, 1]` range,
  /// and returns the unconsumed leftover [primaryDelta] (0 when fully consumed).
  double _applyDrag(double primaryDelta) {
    final axis = _axis;
    final increment = _dragSign * primaryDelta / axis;
    final oldValue = _anim.value;
    final newValue = (oldValue + increment).clamp(0.0, 1.0);
    _anim.value = newValue;
    widget.controller?._notify();
    final leftoverIncrement = increment - (newValue - oldValue);
    return leftoverIncrement * axis / _dragSign;
  }

  void _applyOverscroll(double leftover) {
    _overscroll.value += _dragSign * leftover / max(_overscroll.value, 1);
  }

  /// This sheet plus its ancestor sheets that share this sheet's drag axis
  /// (vertical vs horizontal), innermost (child) first. An ancestor dragging
  /// on the other axis is skipped — its own gesture handles its own axis, so
  /// forwarding a cross-axis delta to it would move it on an axis the user
  /// never dragged (and, in RTL layouts, along a delta whose sign was never
  /// resolved for it). The walk still continues past a mismatched ancestor to
  /// reach further ones that do share the axis.
  List<_PinnedSheetState> _dragChain() {
    final chain = <_PinnedSheetState>[];
    final vertical = _isVertical;
    _PinnedSheetState? node = this;
    while (node != null) {
      if (node._isVertical == vertical) {
        chain.add(node);
      }
      node = node._parentSheet;
    }
    return chain;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta!;
    final chain = _dragChain();
    // Opening fills child -> parent; closing unwinds parent -> child, so a
    // reversed drag pulls the (engaged) outer sheet back before the inner one.
    final opening = _dragSign * delta > 0;
    double remaining = delta;
    if (opening) {
      for (final sheet in chain) {
        remaining = sheet._applyDrag(remaining);
        if (remaining.abs() <= _kDragEpsilon) break;
      }
      if (remaining.abs() > _kDragEpsilon) {
        chain.last._applyOverscroll(remaining);
      }
    } else {
      for (final sheet in chain.reversed) {
        remaining = sheet._applyDrag(remaining);
        if (remaining.abs() <= _kDragEpsilon) break;
      }
    }
    if (mounted) setState(() {});
  }

  void _snapToNearest() {
    _overscroll.forward(0, Curves.easeOut);
    final index = _nearestStageIndex(_anim.value);
    animateToStage(effectiveStages[index],
        duration: widget.duration, curve: Curves.easeOut);
  }

  void _onDragStart(DragStartDetails details) {
    _dragging = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _dragging = false;
    for (final sheet in _dragChain()) {
      sheet._snapToNearest();
    }
  }

  void _onDragCancel() {
    _dragging = false;
    _snapToNearest();
  }

  @override
  Widget build(BuildContext context) {
    // No LayoutBuilder: [_lastAvailableSize] is a plain field kept current
    // by [_RenderPinnedSheetSlide] (a sibling `Positioned.fill` layer in
    // this same Stack, so it sees identical constraints) after each of its
    // own layouts — one layout pass behind on the very first frame ever
    // (harmless: the backdrop transform has nothing to show yet), exact
    // from the next frame on. The sheet's own position doesn't depend on
    // this at all: [_RenderPinnedSheetSlide] resolves that itself, live,
    // from its own constraints during layout, including settling the
    // initial stage (see [_settleInitialStage]).
    //
    // Best-effort seed *before* building the backdrop layer below, so that
    // layer's own AnimatedBuilder (which also reads [_anim], during this
    // same build) sees the initial stage immediately rather than one frame
    // late, for the common axis-independent stage types. See
    // [_seedInitialStageBestEffort].
    _seedInitialStageBestEffort();

    final resolved = resolvedPosition;
    final transform = _effectiveTransform;

    final existing = Data.maybeOf<BackdropTransformData>(context);
    // Depth in a stack of nested PinnedSheets. 0 is the outermost sheet;
    // sheets placed inside another sheet's backdrop get a higher index,
    // which weakens their barrier and surface treatment (matching drawers).
    final stackData = Data.maybeOf<_PinnedSheetStackData>(context);
    final stackIndex = stackData?.stackIndex ?? 0;
    _parentSheet = stackData?.parent;
    final children = <Widget>[];

    // 1. Backdrop layer (transformed + propagates freed size to descendants).
    if (widget.backdrop != null) {
      Widget backdropContent = widget.backdrop!;
      if (widget.draggable && widget.draggableBackdrop) {
        backdropContent = _wrapGesture(resolved, backdropContent);
      }
      children.add(Positioned.fill(
        child: AnimatedBuilder(
          animation: _anim,
          builder: (context, child) {
            final t = currentBackdropTransform.clamp(0.0, 1.0);
            final size = _lastAvailableSize;
            var extra = transform.resolveExtraSize(size, t,
                isRoot: existing == null);
            if (existing != null) {
              extra = Size(
                extra.width +
                    existing.sizeDifference.width / kBackdropScaleDown,
                extra.height +
                    existing.sizeDifference.height / kBackdropScaleDown,
              );
            }
            return Data.inherit(
              data: BackdropTransformData(extra),
              child: Data.inherit(
                data: _PinnedSheetStackData(stackIndex + 1, this),
                child: transform.wrapBackdrop(context, child!, t,
                    isRoot: existing == null),
              ),
            );
          },
          child: backdropContent,
        ),
      ));
    }

    // 2. Modal barrier (transparent tap target; the visual dim is painted
    // by the container's ModalBackdrop via the fade animation).
    //
    // Deliberately not gated by an IgnorePointer synced from an
    // AnimatedBuilder (as this used to be): that gate is a value baked into
    // the widget tree at some earlier build, kept in sync only when
    // something notifies AnimatedBuilder's setState()-based listener — which
    // _settleInitialStage() can't safely do from performLayout (see its
    // doc). For axis-dependent initial stages (SheetStage.fixed,
    // SheetStage.peekDragHandle) that gate could stay stuck "ignoring"
    // (stale-closed) for a frame, letting a tap reach through to whatever's
    // behind the (already correctly dimmed — see _fadeMirror) barrier.
    // Reading _anim.value live, at the moment of the tap, needs no such
    // synchronization: it's exact by construction, always. The trade-off is
    // this barrier is now always semantically tappable (screen readers see
    // it even while closed), where IgnorePointer used to also exclude
    // semantics — a minor accessibility nuance, and the tap itself is an
    // inert no-op while closed either way.
    if (widget.modal) {
      children.add(Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.barrierDismissible
              ? () {
                  if (_anim.value <= 0) return;
                  animateToStage(const SheetStage.closed(),
                      duration: widget.duration, curve: Curves.easeOut);
                }
              : null,
        ),
      ));
    }

    // 3. The sheet content: slide + backdrop-hug offset + container + drag.
    children.add(Positioned.fill(
      child: _buildSheet(context, resolved, existing, stackIndex),
    ));

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: children,
    );
  }

  Widget _buildSheet(BuildContext context, OverlayPosition resolved,
      BackdropTransformData? existing, int stackIndex) {
    // Layout adjustment from the parent sheet's backdrop transform (nesting).
    Size additionalSize = Size.zero;
    Offset additionalOffset = Offset.zero;
    final extraSize = existing?.sizeDifference;
    if (extraSize != null) {
      switch (resolved) {
        case OverlayPosition.left:
          additionalSize = Size(extraSize.width / 2, 0);
          additionalOffset = Offset(-additionalSize.width, 0);
          break;
        case OverlayPosition.right:
          additionalSize = Size(extraSize.width / 2, 0);
          additionalOffset = Offset(additionalSize.width, 0);
          break;
        case OverlayPosition.top:
          additionalSize = Size(0, extraSize.height / 2);
          additionalOffset = Offset(0, -additionalSize.height);
          break;
        case OverlayPosition.bottom:
          additionalSize = Size(0, extraSize.height / 2);
          additionalOffset = Offset(0, additionalSize.height);
          break;
        default:
          break;
      }
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_anim, _overscroll]),
      builder: (context, child) {
        // PinnedSheet only provides the container configuration; the caller
        // decides whether their [child] is wrapped in a [DrawerContainer] or
        // a [SheetContainer] to select the chrome.
        final data = DrawerContainerData(
          position: resolved,
          size: _contentSize,
          stackIndex: stackIndex,
          expands: widget.expands,
          draggable: widget.draggable,
          showDragHandle: widget.showDragHandle,
          dragHandleSize: widget.dragHandleSize,
          borderRadius: widget.borderRadius,
          surfaceOpacity: widget.surfaceOpacity,
          surfaceBlur: widget.surfaceBlur,
          barrierColor: widget.barrierColor,
          constraints: widget.constraints,
          fadeAnimation: widget.modal ? _fadeMirror : null,
          extraSize: additionalSize,
          overscroll: _overscroll.value,
        );

        Widget container = Data.inherit(data: data, child: widget.child);

        // Attach the drag gesture to the content *before* translating/sizing,
        // so a closed sheet's hit area collapses with it instead of parking
        // over whatever is behind (e.g. a nested sheet's content).
        if (widget.draggable) {
          container = _wrapGesture(resolved, container);
        }

        // Replaces the former Align + FractionalTranslation/_SheetRevealBox +
        // Transform.translate composition with a single RenderObject that
        // both sizes/reveals (expands mode) and aligns/slides (non-expand
        // mode) the content in one layout pass. Deliberately *not* passed
        // pre-computed pixel values (visible extent, fraction) — it reads
        // [currentFraction] and its own `constraints` live, during its own
        // performLayout, and reports the child's measured size directly
        // back to this state (see [_measuredContentSize]) — no GlobalKey.
        return _PinnedSheetSlide(
          state: this,
          expands: _childExpands,
          intrinsic: _childIntrinsic,
          position: resolved,
          additionalOffset: additionalOffset / kBackdropScaleDown,
          child: container,
        );
      },
    );
  }

  Widget _wrapGesture(OverlayPosition resolved, Widget child) {
    final isVertical = _isVertical;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: isVertical ? _onDragStart : null,
      onVerticalDragUpdate: isVertical ? _onDragUpdate : null,
      onVerticalDragEnd: isVertical ? _onDragEnd : null,
      onVerticalDragCancel: isVertical ? _onDragCancel : null,
      onHorizontalDragStart: isVertical ? null : _onDragStart,
      onHorizontalDragUpdate: isVertical ? null : _onDragUpdate,
      onHorizontalDragEnd: isVertical ? null : _onDragEnd,
      onHorizontalDragCancel: isVertical ? null : _onDragCancel,
      child: child,
    );
  }
}

/// Marker carrying the nesting depth of a [PinnedSheet] and a reference to it,
/// provided to descendants placed inside its backdrop (used for drag chaining).
class _PinnedSheetStackData {
  final int stackIndex;
  final _PinnedSheetState? parent;
  _PinnedSheetStackData(this.stackIndex, this.parent);
}

/// Positions a [PinnedSheet]'s content according to its current slide
/// progress, in a single [RenderObject] pass. This replaces the former
/// `Align` + `FractionalTranslation`/reveal-box + `Transform.translate`
/// widget composition (3-4 render layers rebuilt every tick) with one
/// purpose-built render object.
///
/// In `expands: true` mode the child is *sized* to the visible extent
/// (clamped to this render object's own region; at least the child's
/// intrinsic main-axis size when [intrinsic] is true), anchored to the
/// reveal edge, and clipped to the visible box — a physically
/// shrinking/growing sheet.
///
/// In `expands: false` mode the child keeps its natural size; this widget
/// fills the available box and the child is anchored per [position]
/// (mirroring `Align`) then slid off the reveal edge by a fraction of its
/// own size (mirroring `FractionalTranslation`) — a content-sized sheet
/// that slides in/out.
///
/// [additionalOffset] (the backdrop-hug offset for nested sheets) is applied
/// on top of either mode, matching the former `Transform.translate`.
///
/// Deliberately *not* given the visible extent/slide fraction as
/// build-time-computed pixel values: this render object reads [state]'s
/// animation live and resolves the visible extent from its own
/// `constraints`, during its own [performLayout], instead of trusting a
/// snapshot taken before this frame's layout ran.
class _PinnedSheetSlide extends SingleChildRenderObjectWidget {
  final _PinnedSheetState state;
  final bool expands;
  final bool intrinsic;
  final OverlayPosition position;
  final Offset additionalOffset;

  const _PinnedSheetSlide({
    required this.state,
    required this.expands,
    required this.intrinsic,
    required this.position,
    required this.additionalOffset,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderPinnedSheetSlide(
      state: state,
      expands: expands,
      intrinsic: intrinsic,
      position: position,
      additionalOffset: additionalOffset,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderPinnedSheetSlide renderObject) {
    renderObject
      ..expands = expands
      ..intrinsic = intrinsic
      ..position = position
      ..additionalOffset = additionalOffset
      // Field setters above only trigger relayout when a value actually
      // changed. This widget rebuilds on every animation tick (it's built
      // from an AnimatedBuilder) specifically so state's live animation
      // value gets re-read — so always relayout, even when none of the
      // (mostly static) fields above moved.
      ..markNeedsLayout();
  }
}

class _RenderPinnedSheetSlide extends RenderShiftedBox {
  _RenderPinnedSheetSlide({
    required this.state,
    required bool expands,
    required bool intrinsic,
    required OverlayPosition position,
    required Offset additionalOffset,
  })  : _expands = expands,
        _intrinsic = intrinsic,
        _position = position,
        _additionalOffset = additionalOffset,
        super(null);

  /// The state this render object drives. Note `state` is stable for the
  /// lifetime of this render object (a given [PinnedSheet] element always
  /// rebuilds from the same [_PinnedSheetState]), so it's a plain
  /// constructor field rather than a mutable setter.
  final _PinnedSheetState state;

  bool _expands;
  set expands(bool value) {
    if (_expands == value) return;
    _expands = value;
    markNeedsLayout();
  }

  bool _intrinsic;
  set intrinsic(bool value) {
    if (_intrinsic == value) return;
    _intrinsic = value;
    markNeedsLayout();
  }

  OverlayPosition _position;
  set position(OverlayPosition value) {
    if (_position == value) return;
    _position = value;
    markNeedsLayout();
  }

  Offset _additionalOffset;
  set additionalOffset(Offset value) {
    if (_additionalOffset == value) return;
    _additionalOffset = value;
    markNeedsLayout();
  }

  /// The (possibly shrunken) visible sub-rect in expand mode, within this
  /// render object's own (always fully-tight) [size]. Drives both the paint
  /// clip and hit-testing, since [size] itself can no longer shrink to
  /// signal "closed" — a `Positioned.fill` child is given tight constraints,
  /// so [size] must always equal the full region.
  Rect? _visibleRect;

  bool get _vertical =>
      _position == OverlayPosition.top || _position == OverlayPosition.bottom;

  @override
  void performLayout() {
    // This render object's own constraints ARE the region size — exactly
    // what a LayoutBuilder would have handed `build()`, just discovered
    // during layout instead of before it. Publish it for gesture/API code
    // that runs outside the render pipeline (e.g. drag handling), then
    // settle the initial stage now that it's known (idempotent — see
    // [_PinnedSheetState._settleInitialStage] for why this is safe to do
    // from here, mid-frame).
    state._lastAvailableSize = constraints.biggest;
    state._settleInitialStage();

    final child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    if (_expands) {
      _layoutExpanded(child);
    } else {
      _layoutSliding(child);
    }
  }

  /// Sizes the child to the visible extent (reveal-box mode). A
  /// `Positioned.fill` ancestor gives this render object *tight* constraints,
  /// so [size] must always fill the full region; the shrinking reveal box is
  /// instead tracked as [_visibleRect], a sub-rect used for clipping/hit
  /// testing (mirroring what the old `Align`-wrapped version got "for free"
  /// by being loosened by its parent).
  void _layoutExpanded(RenderBox child) {
    size = constraints.biggest;
    final mainFull = _vertical ? size.height : size.width;
    final cross = _vertical ? size.width : size.height;
    final maxMain = mainFull;
    final visibleExtent = state.currentFraction * maxMain;

    // The intrinsic floor is the child's natural content size (flex children
    // like Spacer count as 0), NOT its size under a loose layout — otherwise a
    // MainAxisSize.max child would report the whole region as its intrinsic and
    // the content would never shrink.
    double floor = 0;
    if (_intrinsic) {
      floor = (_vertical
              ? child.getMaxIntrinsicHeight(cross)
              : child.getMaxIntrinsicWidth(cross))
          .clamp(0.0, maxMain);
    }

    // Phase 1 (visible >= floor): child fills the box exactly, so a
    // MainAxisSize.max child keeps e.g. a bottom-aligned button visible. Phase 2
    // (visible < floor): child stays at its intrinsic size, anchored to the
    // reveal edge, so its far end slides past the edge as the box shrinks.
    final childMain = visibleExtent.clamp(floor, maxMain);
    child.layout(
      _vertical
          ? BoxConstraints.tightFor(width: cross, height: childMain)
          : BoxConstraints.tightFor(width: childMain, height: cross),
      parentUsesSize: true,
    );
    state._measuredContentSize = child.size;

    // Where the (shrinking) visible box sits within the full region, and
    // where content sits within that box, anchored to the reveal edge (the
    // leading edge that advances into view); overflow hangs off the far
    // edge and is clipped.
    final boxMain = visibleExtent.clamp(0.0, maxMain);
    double boxStart;
    double contentStart;
    switch (_position) {
      case OverlayPosition.top:
        boxStart = 0;
        contentStart = boxMain - childMain;
        break;
      case OverlayPosition.left:
        boxStart = 0;
        contentStart = boxMain - childMain;
        break;
      case OverlayPosition.bottom:
        boxStart = mainFull - boxMain;
        contentStart = 0;
        break;
      default: // right
        boxStart = mainFull - boxMain;
        contentStart = 0;
    }

    _visibleRect = _vertical
        ? Rect.fromLTWH(0, boxStart, cross, boxMain)
        : Rect.fromLTWH(boxStart, 0, boxMain, cross);

    final childOffset = _vertical
        ? Offset(0, boxStart + contentStart)
        : Offset(boxStart + contentStart, 0);
    (child.parentData as BoxParentData).offset =
        childOffset + _additionalOffset;
  }

  /// Keeps the child at its natural size, anchored per [_position] within
  /// the full box (mirroring `Align`) and slid by a fraction of its own
  /// size off the reveal edge (mirroring `FractionalTranslation`).
  void _layoutSliding(RenderBox child) {
    _visibleRect = null;
    size = constraints.biggest;
    child.layout(constraints.loosen(), parentUsesSize: true);
    state._measuredContentSize = child.size;

    final dx = size.width - child.size.width;
    final dy = size.height - child.size.height;
    Offset base;
    switch (_position) {
      case OverlayPosition.left:
        base = Offset(0, dy / 2);
        break;
      case OverlayPosition.right:
        base = Offset(dx, dy / 2);
        break;
      case OverlayPosition.top:
        base = Offset(dx / 2, 0);
        break;
      case OverlayPosition.bottom:
        base = Offset(dx / 2, dy);
        break;
      default:
        throw UnimplementedError('Unknown position');
    }

    final progress = 1 - state.currentFraction;
    final Offset startFractionalOffset;
    switch (_position) {
      case OverlayPosition.left:
        startFractionalOffset = const Offset(-1, 0);
        break;
      case OverlayPosition.right:
        startFractionalOffset = const Offset(1, 0);
        break;
      case OverlayPosition.top:
        startFractionalOffset = const Offset(0, -1);
        break;
      case OverlayPosition.bottom:
        startFractionalOffset = const Offset(0, 1);
        break;
      default:
        throw UnimplementedError('Unknown position');
    }
    final slide = Offset(
      startFractionalOffset.dx * progress * child.size.width,
      startFractionalOffset.dy * progress * child.size.height,
    );

    (child.parentData as BoxParentData).offset =
        base + slide + _additionalOffset;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return;
    final childOffset = (child.parentData as BoxParentData).offset;
    final visibleRect = _visibleRect;
    if (visibleRect != null) {
      // Reveal-box mode: clip to the (shrinking) visible sub-rect.
      context.pushClipRect(
        needsCompositing,
        offset,
        visibleRect,
        (ctx, off) => ctx.paintChild(child, off + childOffset),
      );
    } else {
      context.paintChild(child, offset + childOffset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final child = this.child;
    if (child == null) return false;
    final childOffset = (child.parentData as BoxParentData).offset;
    return result.addWithPaintOffset(
      offset: childOffset,
      position: position,
      hitTest: (result, transformed) =>
          child.hitTest(result, position: transformed),
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // Restrict hits to the visible sub-rect in expand mode, so a collapsed
    // sheet doesn't intercept pointers meant for the content behind it. In
    // slide mode this render object's `size` already reflects the full
    // hittable region.
    final visibleRect = _visibleRect;
    if (visibleRect != null && !visibleRect.contains(position)) return false;
    return super.hitTest(result, position: position);
  }
}
