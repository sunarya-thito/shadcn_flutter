import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for [ScrollableClient].
class ScrollableClientTheme {
  final DiagonalDragBehavior? diagonalDragBehavior;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final Clip? clipBehavior;
  final HitTestBehavior? hitTestBehavior;
  final bool? overscroll;

  const ScrollableClientTheme({
    this.diagonalDragBehavior,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.clipBehavior,
    this.hitTestBehavior,
    this.overscroll,
  });

  ScrollableClientTheme copyWith({
    ValueGetter<DiagonalDragBehavior?>? diagonalDragBehavior,
    ValueGetter<DragStartBehavior?>? dragStartBehavior,
    ValueGetter<ScrollViewKeyboardDismissBehavior?>? keyboardDismissBehavior,
    ValueGetter<Clip?>? clipBehavior,
    ValueGetter<HitTestBehavior?>? hitTestBehavior,
    ValueGetter<bool?>? overscroll,
  }) {
    return ScrollableClientTheme(
      diagonalDragBehavior: diagonalDragBehavior == null
          ? this.diagonalDragBehavior
          : diagonalDragBehavior(),
      dragStartBehavior:
          dragStartBehavior == null ? this.dragStartBehavior : dragStartBehavior(),
      keyboardDismissBehavior: keyboardDismissBehavior == null
          ? this.keyboardDismissBehavior
          : keyboardDismissBehavior(),
      clipBehavior:
          clipBehavior == null ? this.clipBehavior : clipBehavior(),
      hitTestBehavior:
          hitTestBehavior == null ? this.hitTestBehavior : hitTestBehavior(),
      overscroll: overscroll == null ? this.overscroll : overscroll(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ScrollableClientTheme &&
      other.diagonalDragBehavior == diagonalDragBehavior &&
      other.dragStartBehavior == dragStartBehavior &&
      other.keyboardDismissBehavior == keyboardDismissBehavior &&
      other.clipBehavior == clipBehavior &&
      other.hitTestBehavior == hitTestBehavior &&
      other.overscroll == overscroll;

  @override
  int get hashCode => Object.hash(diagonalDragBehavior, dragStartBehavior,
      keyboardDismissBehavior, clipBehavior, hitTestBehavior, overscroll);

  @override
  String toString() =>
      'ScrollableClientTheme(diagonalDragBehavior: $diagonalDragBehavior, dragStartBehavior: $dragStartBehavior, keyboardDismissBehavior: $keyboardDismissBehavior, clipBehavior: $clipBehavior, hitTestBehavior: $hitTestBehavior, overscroll: $overscroll)';
}

typedef ScrollableBuilder = Widget Function(
    BuildContext context, Offset offset, Size viewportSize, Widget? child);

class ScrollableClient extends StatelessWidget {
  final bool? primary;
  final Axis mainAxis;
  final ScrollableDetails verticalDetails;
  final ScrollableDetails horizontalDetails;
  final ScrollableBuilder builder;
  final Widget? child;
  final DiagonalDragBehavior? diagonalDragBehavior;
  final DragStartBehavior? dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final Clip? clipBehavior;
  final HitTestBehavior? hitTestBehavior;
  final bool? overscroll;

  const ScrollableClient({
    super.key,
    this.primary,
    this.mainAxis = Axis.vertical,
    this.verticalDetails = const ScrollableDetails.vertical(),
    this.horizontalDetails = const ScrollableDetails.horizontal(),
    required this.builder,
    this.child,
    this.diagonalDragBehavior,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.clipBehavior,
    this.hitTestBehavior,
    this.overscroll,
  });

  Widget _buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
    bool overscroll,
    Clip clipBehavior,
  ) {
    return ScrollableClientViewport(
        overscroll: overscroll,
        verticalOffset: verticalOffset,
        verticalAxisDirection: verticalDetails.direction,
        horizontalOffset: horizontalOffset,
        horizontalAxisDirection: horizontalDetails.direction,
        clipBehavior: clipBehavior,
        delegate: TwoDimensionalChildBuilderDelegate(
          builder: (context, vicinity) {
            return ListenableBuilder(
              listenable: Listenable.merge([
                verticalOffset,
                horizontalOffset,
              ]),
              builder: (context, child) {
                var horizontalPixels = horizontalOffset.pixels;
                var verticalPixels = verticalOffset.pixels;
                return builder(
                    context,
                    Offset(horizontalPixels, verticalPixels),
                    (vicinity as _ScrollableClientChildVicinity).viewportSize,
                    child);
              },
              child: child,
            );
          },
        ),
        mainAxis: mainAxis);
  }

  @override
  Widget build(BuildContext context) {
    assert(axisDirectionToAxis(verticalDetails.direction) == Axis.vertical,
        'TwoDimensionalScrollView.verticalDetails are not Axis.vertical.');
    assert(axisDirectionToAxis(horizontalDetails.direction) == Axis.horizontal,
        'TwoDimensionalScrollView.horizontalDetails are not Axis.horizontal.');

    final compTheme = ComponentTheme.maybeOf<ScrollableClientTheme>(context);
    final diag = diagonalDragBehavior ??
        compTheme?.diagonalDragBehavior ??
        DiagonalDragBehavior.none;
    final dragStart =
        dragStartBehavior ?? compTheme?.dragStartBehavior ?? DragStartBehavior.start;
    final keyboardDismiss = keyboardDismissBehavior ??
        compTheme?.keyboardDismissBehavior ??
        ScrollViewKeyboardDismissBehavior.manual;
    final clip = clipBehavior ?? compTheme?.clipBehavior ?? Clip.hardEdge;
    final hitTest =
        hitTestBehavior ?? compTheme?.hitTestBehavior ?? HitTestBehavior.opaque;
    final bool overscroll =
        this.overscroll ?? compTheme?.overscroll ?? false;

    ScrollableDetails mainAxisDetails = switch (mainAxis) {
      Axis.vertical => verticalDetails,
      Axis.horizontal => horizontalDetails,
    };

    final bool effectivePrimary = primary ??
        mainAxisDetails.controller == null &&
            PrimaryScrollController.shouldInherit(
              context,
              mainAxis,
            );

    if (effectivePrimary) {
      // Using PrimaryScrollController for mainAxis.
      assert(
          mainAxisDetails.controller == null,
          'TwoDimensionalScrollView.primary was explicitly set to true, but a '
          'ScrollController was provided in the ScrollableDetails of the '
          'TwoDimensionalScrollView.mainAxis.');
      mainAxisDetails = mainAxisDetails.copyWith(
        controller: PrimaryScrollController.of(context),
      );
    }

    final TwoDimensionalScrollable scrollable = TwoDimensionalScrollable(
      horizontalDetails: switch (mainAxis) {
        Axis.horizontal => mainAxisDetails,
        Axis.vertical => horizontalDetails,
      },
      verticalDetails: switch (mainAxis) {
        Axis.vertical => mainAxisDetails,
        Axis.horizontal => verticalDetails,
      },
      diagonalDragBehavior: diag,
      viewportBuilder: (context, vOffset, hOffset) =>
          _buildViewport(context, vOffset, hOffset, overscroll, clip),
      dragStartBehavior: dragStart,
      hitTestBehavior: hitTest,
    );

    final Widget scrollableResult = effectivePrimary
        // Further descendant ScrollViews will not inherit the same PrimaryScrollController
        ? PrimaryScrollController.none(child: scrollable)
        : scrollable;

    if (keyboardDismiss == ScrollViewKeyboardDismissBehavior.onDrag) {
      return NotificationListener<ScrollUpdateNotification>(
        child: scrollableResult,
        onNotification: (ScrollUpdateNotification notification) {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (notification.dragDetails != null &&
              !currentScope.hasPrimaryFocus &&
              currentScope.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          return false;
        },
      );
    }
    return scrollableResult;
  }
}

class ScrollableClientViewport extends TwoDimensionalViewport {
  final bool overscroll;
  const ScrollableClientViewport({
    super.key,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
    required this.overscroll,
  });

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return RenderScrollableClientViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      delegate: delegate,
      mainAxis: mainAxis,
      childManager: context as TwoDimensionalChildManager,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      overscroll: overscroll,
    );
  }
}

class RenderScrollableClientViewport extends RenderTwoDimensionalViewport {
  final bool overscroll;
  RenderScrollableClientViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
    required this.overscroll,
  });

  @override
  void layoutChildSequence() {
    double horizontalPixels = horizontalOffset.pixels;
    double verticalPixels = verticalOffset.pixels;
    final Size viewportDimension = this.viewportDimension;
    final ChildVicinity vicinity = _ScrollableClientChildVicinity(
      viewportSize: viewportDimension,
      xIndex: 0,
      yIndex: 0,
    );
    final RenderBox child = buildOrObtainChildFor(vicinity)!;
    child.layout(
        BoxConstraints(
          minWidth: constraints.maxWidth,
          minHeight: constraints.maxHeight,
        ),
        parentUsesSize: true);
    if (!overscroll) {
      horizontalPixels = max(0.0, horizontalPixels);
      verticalPixels = max(0.0, verticalPixels);
      double maxHorizontalPixels = child.size.width - viewportDimension.width;
      double maxVerticalPixels = child.size.height - viewportDimension.height;
      horizontalPixels = min(horizontalPixels, maxHorizontalPixels);
      verticalPixels = min(verticalPixels, maxVerticalPixels);
    }
    parentDataOf(child).layoutOffset =
        Offset(-horizontalPixels, -verticalPixels);
    horizontalOffset.applyContentDimensions(
        0,
        (child.size.width - viewportDimension.width)
            .clamp(0.0, double.infinity));
    verticalOffset.applyContentDimensions(
        0,
        (child.size.height - viewportDimension.height)
            .clamp(0.0, double.infinity));
    horizontalOffset.applyViewportDimension(viewportDimension.width);
    verticalOffset.applyViewportDimension(viewportDimension.height);
  }
}

class _ScrollableClientChildVicinity extends ChildVicinity {
  final Size viewportSize;

  const _ScrollableClientChildVicinity({
    required this.viewportSize,
    required super.xIndex,
    required super.yIndex,
  });
}
