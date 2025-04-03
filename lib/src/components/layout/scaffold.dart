import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Scaffold extends StatefulWidget {
  final List<Widget> headers;
  final List<Widget> footers;
  final Widget child;
  final double? loadingProgress;
  final bool loadingProgressIndeterminate;
  final bool
      floatingHeader; // when header floats, it takes no space in the layout, and positioned on top of the content
  final bool floatingFooter;
  final Color? headerBackgroundColor;
  final Color? footerBackgroundColor;
  final Color? backgroundColor;
  final bool showLoadingSparks;
  final bool? resizeToAvoidBottomInset;

  const Scaffold({
    super.key,
    required this.child,
    this.headers = const [],
    this.footers = const [],
    this.loadingProgress,
    this.loadingProgressIndeterminate = false,
    this.floatingHeader = false,
    this.floatingFooter = false,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.footerBackgroundColor,
    this.showLoadingSparks = false,
    this.resizeToAvoidBottomInset,
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
  Widget buildHeader(BuildContext context) {
    return RepaintBoundary(
      child: Container(
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
            if (widget.loadingProgress != null && widget.showLoadingSparks)
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
    );
  }

  Widget buildFooter(BuildContext context, EdgeInsets viewInsets) {
    return Offstage(
      offstage: viewInsets.bottom > 0,
      child: RepaintBoundary(
        child: Container(
          color: widget.footerBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    return DrawerOverlay(
      child: Container(
        color: widget.backgroundColor ?? theme.colorScheme.background,
        child: _ScaffoldFlex(
          floatingHeader: widget.floatingHeader,
          floatingFooter: widget.floatingFooter,
          children: [
            buildHeader(context),
            LayoutBuilder(builder: (context, constraints) {
              Widget child = (widget.resizeToAvoidBottomInset ?? true)
                  ? Container(
                      padding: EdgeInsets.only(
                        bottom: viewInsets.bottom,
                      ),
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          viewInsets: viewInsets.copyWith(
                            bottom: 0,
                          ),
                        ),
                        child: ToastLayer(child: widget.child),
                      ),
                    )
                  : ToastLayer(child: widget.child);
              if (constraints is ScaffoldBoxConstraints &&
                  (widget.floatingHeader || widget.floatingFooter)) {
                final currentMediaQuery = MediaQuery.of(context);
                EdgeInsets padding = currentMediaQuery.padding;
                if (widget.floatingHeader) {
                  padding += EdgeInsets.only(top: constraints.headerHeight);
                }
                if (widget.floatingFooter) {
                  padding += EdgeInsets.only(bottom: constraints.footerHeight);
                }
                child = MediaQuery(
                  data: currentMediaQuery.copyWith(
                    padding: padding,
                  ),
                  child: RepaintBoundary(
                    child: child,
                  ),
                );
              }
              return child;
            }),
            buildFooter(context, viewInsets),
          ],
        ),
      ),
    );
  }
}

class ScaffoldPaddingStorage {
  double top;
  double left;
  double right;
  double bottom;

  ScaffoldPaddingStorage({
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
  });
}

class ScaffoldBoxConstraints extends BoxConstraints {
  final double headerHeight;
  final double footerHeight;

  const ScaffoldBoxConstraints({
    required this.headerHeight,
    required this.footerHeight,
    super.minWidth,
    super.maxWidth,
    super.minHeight,
    super.maxHeight,
  });

  factory ScaffoldBoxConstraints.fromBoxConstraints({
    required BoxConstraints constraints,
    required double headerHeight,
    required double footerHeight,
  }) {
    return ScaffoldBoxConstraints(
      headerHeight: headerHeight,
      footerHeight: footerHeight,
      minWidth: constraints.minWidth,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  ScaffoldBoxConstraints copyWith({
    double? headerHeight,
    double? footerHeight,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ScaffoldBoxConstraints(
      headerHeight: headerHeight ?? this.headerHeight,
      footerHeight: footerHeight ?? this.footerHeight,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScaffoldBoxConstraints) return false;
    return other.headerHeight == headerHeight &&
        other.footerHeight == footerHeight &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth &&
        other.minHeight == minHeight &&
        other.maxHeight == maxHeight;
  }

  @override
  int get hashCode {
    return Object.hash(
      headerHeight,
      footerHeight,
      minWidth,
      maxWidth,
      minHeight,
      maxHeight,
    );
  }

  @override
  String toString() {
    return 'ScaffoldBoxConstraints(headerHeight: $headerHeight, footerHeight: $footerHeight, minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight)';
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
  final AlignmentGeometry alignment;
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
          child: Container(
            color: widget.backgroundColor ??
                theme.colorScheme.background.scaleAlpha(surfaceOpacity ?? 1),
            alignment: widget.alignment,
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
              child: SizedBox(
                height: widget.height,
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
      ),
    );
  }
}

class _ScaffoldFlex extends MultiChildRenderObjectWidget {
  final bool floatingHeader;
  final bool floatingFooter;
  const _ScaffoldFlex({
    super.children,
    required this.floatingHeader,
    required this.floatingFooter,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ScaffoldRenderFlex(
      floatingHeader: floatingHeader,
      floatingFooter: floatingFooter,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _ScaffoldRenderFlex renderObject) {
    bool needsLayout = false;
    if (renderObject._floatingHeader != floatingHeader) {
      renderObject._floatingHeader = floatingHeader;
      needsLayout = true;
    }
    if (renderObject._floatingFooter != floatingFooter) {
      renderObject._floatingFooter = floatingFooter;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class _ScaffoldParentData extends ContainerBoxParentData<RenderBox> {}

class _ScaffoldRenderFlex extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _ScaffoldParentData> {
  _ScaffoldRenderFlex({
    required bool floatingHeader,
    required bool floatingFooter,
  })  : _floatingHeader = floatingHeader,
        _floatingFooter = floatingFooter;

  bool _floatingHeader = false;
  bool _floatingFooter = false;

  final ValueNotifier<double> _headerSize = ValueNotifier(0);
  final ValueNotifier<double> _footerSize = ValueNotifier(0);

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _ScaffoldParentData) {
      child.parentData = _ScaffoldParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // There is gonna be only 3 children
    // 1. header
    // 2. content
    // 3. footer
    // By default, the paint order is 1, 2, 3
    // but with this custom implementation, we can change the order to 2, 1, 3
    // which means the header will be painted after the content
    // and the footer will be painted after the header
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    context.paintChild(
        content, (content.parentData as BoxParentData).offset + offset);
    context.paintChild(
        header, (header.parentData as BoxParentData).offset + offset);
    context.paintChild(
        footer, (footer.parentData as BoxParentData).offset + offset);
  }

  bool _hitTestBox(BoxHitTestResult result, RenderBox child, Offset position) {
    final BoxParentData childParentData = child.parentData as BoxParentData;
    final bool isHit = result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        assert(transformed == position - childParentData.offset);
        return child.hitTest(result, position: transformed);
      },
    );
    return isHit;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    if (_hitTestBox(result, header, position)) {
      return true;
    }
    if (_hitTestBox(result, footer, position)) {
      return true;
    }
    if (_hitTestBox(result, content, position)) {
      return true;
    }
    return false;
  }

  @override
  void performLayout() {
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    final constraints = this.constraints;
    header.layout(constraints, parentUsesSize: true);
    footer.layout(constraints, parentUsesSize: true);
    BoxConstraints contentConstraints;
    Offset contentOffset;
    double footerSize = footer.getMaxIntrinsicHeight(double.infinity);
    double headerSize = header.getMaxIntrinsicHeight(double.infinity);
    switch ((_floatingHeader, _floatingFooter)) {
      case (true, true): // floating header and footer
        contentConstraints = constraints;
        contentOffset = Offset.zero;
        break;
      case (true, false): // floating header
        contentConstraints = constraints.deflate(
          EdgeInsets.only(bottom: footerSize),
        );
        contentOffset = Offset.zero;
        break;
      case (false, true): // floating footer
        contentConstraints = constraints.deflate(
          EdgeInsets.only(top: headerSize),
        );
        contentOffset = Offset(0, headerSize);
        break;
      case (false, false):
        contentConstraints = constraints.deflate(
          EdgeInsets.only(
            top: headerSize,
            bottom: footerSize,
          ),
        );
        contentOffset = Offset(0, headerSize);
        break;
    }
    content.layout(ScaffoldBoxConstraints.fromBoxConstraints(
      constraints: contentConstraints,
      headerHeight: headerSize,
      footerHeight: footerSize,
    ));
    size = constraints.biggest;
    (content.parentData as BoxParentData).offset = contentOffset;
    (footer.parentData as BoxParentData).offset = Offset(
      0,
      constraints.biggest.height - footerSize,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _headerSize.value = headerSize;
      _footerSize.value = footerSize;
    });
  }
}

class ScaffoldHeaderPadding extends SingleChildRenderObjectWidget {
  const ScaffoldHeaderPadding({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(
      paddingType: _ScaffoldPaddingType.header,
    );
  }
}

class ScaffoldFooterPadding extends SingleChildRenderObjectWidget {
  const ScaffoldFooterPadding({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(
      paddingType: _ScaffoldPaddingType.footer,
    );
  }
}

enum _ScaffoldPaddingType {
  header,
  footer,
}

class _RenderScaffoldPadding extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ScaffoldParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ScaffoldParentData> {
  final _ScaffoldPaddingType _paddingType;

  _RenderScaffoldPadding({
    _ScaffoldPaddingType paddingType = _ScaffoldPaddingType.header,
  }) : _paddingType = paddingType;

  _ScaffoldRenderFlex? findParent() {
    RenderObject? parent = this;
    while (parent != null) {
      if (parent is _ScaffoldRenderFlex) {
        return parent;
      }
      parent = parent.parent;
    }
    return null;
  }

  _ScaffoldRenderFlex? currentParent;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    var scaffoldParent = findParent();
    currentParent = scaffoldParent;
    scaffoldParent?._headerSize.addListener(markNeedsLayout);
    scaffoldParent?._footerSize.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    var scaffoldParent = currentParent;
    scaffoldParent?._headerSize.removeListener(markNeedsLayout);
    scaffoldParent?._footerSize.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void performLayout() {
    _ScaffoldRenderFlex? parentData = findParent();
    assert(parentData != null, 'Must be a child of a Scaffold');
    BoxConstraints constraints;
    switch (_paddingType) {
      case _ScaffoldPaddingType.header:
        constraints = this.constraints.copyWith(
              minHeight: parentData!._headerSize.value,
              maxHeight: parentData._headerSize.value,
            );
        break;
      case _ScaffoldPaddingType.footer:
        constraints = this.constraints.copyWith(
              minHeight: parentData!._footerSize.value,
              maxHeight: parentData._footerSize.value,
            );
        break;
    }
    final child = firstChild;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child.size);
      (child.parentData as BoxParentData).offset = Offset.zero;
    } else {
      size = constraints.biggest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
