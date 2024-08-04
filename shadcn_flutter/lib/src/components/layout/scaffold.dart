import 'package:flutter/foundation.dart';
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

class ScaffoldState extends State<Scaffold> {
  late List<BarHolder> _headerHolders;
  late List<BarHolder> _footerHolders;

  @override
  void initState() {
    super.initState();
    _headerHolders = List.generate(
        widget.headers.length,
        (index) => BarHolder(
              scaffold: this,
            ));
    _footerHolders = List.generate(
        widget.footers.length,
        (index) => BarHolder(
              isHeader: false,
              scaffold: this,
            ));
  }

  @override
  void didUpdateWidget(covariant Scaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.headers, widget.headers)) {
      _headerHolders = List.generate(
          widget.headers.length,
          (index) => BarHolder(
                scaffold: this,
              ));
    }
    if (!listEquals(oldWidget.footers, widget.footers)) {
      _footerHolders = List.generate(
          widget.footers.length,
          (index) => BarHolder(
                isHeader: false,
                scaffold: this,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                          for (int i = 0; i < widget.headers.length; i++)
                            Data(
                              data: _headerHolders[i],
                              child: widget.headers[i],
                            ),
                        ],
                      ),
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
              child: widget.child,
            ),
            Container(
              color: widget.footerBackgroundColor,
              child: Column(
                children: [
                  for (int i = 0; i < widget.footers.length; i++)
                    Data(
                      data: _footerHolders[i],
                      child: widget.footers[i],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarHolder {
  final ScaffoldState scaffold;
  final bool isHeader;
  BarInstance? _attachedBar;

  BarHolder({this.isHeader = true, required this.scaffold});

  void attachBar(BarInstance bar) {
    _attachedBar = bar;
    // scaffold._recomputeScrollDeltaConsumption();
  }
}

abstract class BarInstance {
  double consumeScrollDelta(double delta);
}

class AppBar extends StatefulWidget {
  final List<Widget> trailing;
  final List<Widget> leading;
  final Widget? title;
  final Widget? header; // small widget placed on top of title
  final Widget? subtitle; // small widget placed below title
  final bool
      trailingExpanded; // expand the trailing instead of the main content
  final Alignment alignment;
  final Color? backgroundColor;

  const AppBar({
    super.key,
    this.trailing = const [],
    this.leading = const [],
    this.title,
    this.header,
    this.subtitle,
    this.trailingExpanded = false,
    this.alignment = Alignment.bottomCenter,
    this.backgroundColor,
  });

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
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
