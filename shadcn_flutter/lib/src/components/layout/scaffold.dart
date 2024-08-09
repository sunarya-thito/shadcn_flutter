import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Scaffold extends StatefulWidget {
  final List<Widget> headers;
  final List<Widget> footers;
  final Widget child;
  final double? loadingProgress;
  final bool loadingProgressIndeterminate;
  final VoidCallback? onRefresh;
  final bool
      floatingHeader; // when header floats, it takes no space in the layout, and positioned on top of the content
  final bool floatingFooter;
  final Color? headerBackgroundColor;
  final Color? footerBackgroundColor;
  final bool showLoadingSparks;

  const Scaffold({
    super.key,
    required this.child,
    this.headers = const [],
    this.footers = const [],
    this.loadingProgress,
    this.loadingProgressIndeterminate = false,
    this.onRefresh,
    this.floatingHeader = false,
    this.floatingFooter = false,
    this.headerBackgroundColor,
    this.footerBackgroundColor,
    this.showLoadingSparks = false,
  });

  @override
  State<Scaffold> createState() => ScaffoldState();
}

class ScaffoldBarData {
  final bool isHeader;
  final int childIndex;
  final int childrenCount;

  const ScaffoldBarData({
    this.isHeader = true,
    required this.childIndex,
    required this.childrenCount,
  });
}

class ScaffoldState extends State<Scaffold> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    return DrawerOverlay(
      child: AnimatedContainer(
        duration: kDefaultDuration,
        color: theme.colorScheme.background,
        child: _ScaffoldFlex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: widget.headerBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.loadingProgress != null ||
                          widget.loadingProgressIndeterminate)
                        SizedBox(
                          // to make it float
                          height: 0,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.passthrough,
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.transparent,
                                  value: widget.loadingProgressIndeterminate
                                      ? null
                                      : widget.loadingProgress,
                                  showSparks: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0; i < widget.headers.length; i++)
                              Data.inherit(
                                data: ScaffoldBarData(
                                  childIndex: i,
                                  childrenCount: widget.headers.length,
                                ),
                                child: widget.headers[i],
                              ),
                          ]),
                    ],
                  ),
                  if (widget.loadingProgress != null &&
                      widget.showLoadingSparks)
                    SizedBox(
                      // to make it float
                      height: 0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.passthrough,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              value: widget.loadingProgressIndeterminate
                                  ? null
                                  : widget.loadingProgress,
                              showSparks: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: viewInsets,
                child: widget.child,
              ),
            ),
            Offstage(
              offstage: viewInsets.bottom > 0,
              child: Container(
                color: widget.footerBackgroundColor,
                child: Column(
                  children: [
                    for (var i = 0; i < widget.footers.length; i++)
                      Data.inherit(
                        data: ScaffoldBarData(
                          isHeader: false,
                          childIndex: i,
                          childrenCount: widget.footers.length,
                        ),
                        child: widget.footers[i],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  final List<Widget> trailing;
  final List<Widget> leading;
  final Widget? child;
  final Widget? title;
  final Widget? header; // small widget placed on top of title
  final Widget? subtitle; // small widget placed below title
  final bool
      trailingExpanded; // expand the trailing instead of the main content
  final Alignment alignment;
  final Color? backgroundColor;
  final double? leadingGap;
  final double? trailingGap;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final bool useSafeArea;
  final double? surfaceBlur;
  final double? surfaceOpacity;

  const AppBar({
    super.key,
    this.trailing = const [],
    this.leading = const [],
    this.title,
    this.header,
    this.subtitle,
    this.child,
    this.trailingExpanded = false,
    this.alignment = Alignment.center,
    this.padding,
    this.backgroundColor,
    this.leadingGap,
    this.trailingGap,
    this.height,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.useSafeArea = true,
  }) : assert(
          child == null || title == null,
          'Cannot provide both child and title',
        );

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final barData = Data.maybeOf<ScaffoldBarData>(context);
    var surfaceBlur = widget.surfaceBlur ?? theme.surfaceBlur;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    return FocusTraversalGroup(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: surfaceBlur ?? 0,
            sigmaY: surfaceBlur ?? 0,
          ),
          child: AnimatedContainer(
            duration: kDefaultDuration,
            color: widget.backgroundColor ??
                theme.colorScheme.background.scaleAlpha(surfaceOpacity ?? 1),
            alignment: widget.alignment,
            height: widget.height,
            padding: widget.padding ??
                (const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ) *
                    scaling),
            child: SafeArea(
              top: widget.useSafeArea &&
                  barData?.isHeader == true &&
                  barData?.childIndex == 0,
              right: widget.useSafeArea,
              left: widget.useSafeArea,
              bottom: widget.useSafeArea &&
                  barData?.isHeader == false &&
                  barData?.childIndex == (barData?.childrenCount ?? 0) - 1,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.leading.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.leading,
                      ).gap(widget.leadingGap ?? (4 * scaling)),
                    Flexible(
                      fit: widget.trailingExpanded
                          ? FlexFit.loose
                          : FlexFit.tight,
                      child: widget.child ??
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.header != null)
                                KeyedSubtree(
                                  key: const ValueKey('header'),
                                  child: widget.header!.muted().small(),
                                ),
                              if (widget.title != null)
                                KeyedSubtree(
                                  key: const ValueKey('title'),
                                  child: widget.title!.large().medium(),
                                ),
                              if (widget.subtitle != null)
                                KeyedSubtree(
                                  key: const ValueKey('subtitle'),
                                  child: widget.subtitle!.muted().small(),
                                ),
                            ],
                          ),
                    ),
                    if (widget.trailing.isNotEmpty)
                      if (!widget.trailingExpanded)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: widget.trailing,
                        ).gap(widget.trailingGap ?? (4 * scaling))
                      else
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widget.trailing,
                          ).gap(widget.trailingGap ?? (4 * scaling)),
                        ),
                  ],
                ).gap(18 * scaling),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScaffoldFlex extends Flex {
  const _ScaffoldFlex({
    super.direction = Axis.vertical,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.children = const <Widget>[],
  });

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return _ScaffoldRenderFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? Directionality.of(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }
}

class _ScaffoldRenderFlex extends RenderFlex {
  _ScaffoldRenderFlex({
    super.direction = Axis.vertical,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.mainAxisSize = MainAxisSize.max,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.textDirection,
    super.verticalDirection = VerticalDirection.down,
    super.textBaseline,
    super.clipBehavior = Clip.none,
  });

  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    // There is gonna be only 3 children
    // 1. header
    // 2. content
    // 3. footer
    // By default, the paint order is 1, 2, 3
    // but with this custom implementation, we can change the order to 2, 1, 3
    // which means the header will be painted after the content
    // and the footer will be painted after the header
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as FlexParentData).nextSibling!;
    RenderBox footer = (content.parentData as FlexParentData).nextSibling!;
    context.paintChild(
        content, (content.parentData as BoxParentData).offset + offset);
    context.paintChild(
        header, (header.parentData as BoxParentData).offset + offset);
    context.paintChild(
        footer, (footer.parentData as BoxParentData).offset + offset);
  }
}
