import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverCardTheme {
  final Duration? debounce;
  final Duration? wait;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? anchorAlignment;
  final Offset? popoverOffset;
  final HitTestBehavior? behavior;

  const HoverCardTheme({
    this.debounce,
    this.wait,
    this.popoverAlignment,
    this.anchorAlignment,
    this.popoverOffset,
    this.behavior,
  });

  HoverCardTheme copyWith({
    ValueGetter<Duration?>? debounce,
    ValueGetter<Duration?>? wait,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? anchorAlignment,
    ValueGetter<Offset?>? popoverOffset,
    ValueGetter<HitTestBehavior?>? behavior,
  }) {
    return HoverCardTheme(
      debounce: debounce == null ? this.debounce : debounce(),
      wait: wait == null ? this.wait : wait(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      anchorAlignment:
          anchorAlignment == null ? this.anchorAlignment : anchorAlignment(),
      popoverOffset:
          popoverOffset == null ? this.popoverOffset : popoverOffset(),
      behavior: behavior == null ? this.behavior : behavior(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HoverCardTheme &&
        other.debounce == debounce &&
        other.wait == wait &&
        other.popoverAlignment == popoverAlignment &&
        other.anchorAlignment == anchorAlignment &&
        other.popoverOffset == popoverOffset &&
        other.behavior == behavior;
  }

  @override
  int get hashCode => Object.hash(
        debounce,
        wait,
        popoverAlignment,
        anchorAlignment,
        popoverOffset,
        behavior,
      );
}

class HoverCard extends StatefulWidget {
  final Widget child;
  final Duration? debounce;
  final Duration? wait;
  final WidgetBuilder hoverBuilder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? anchorAlignment;
  final Offset? popoverOffset;
  final HitTestBehavior? behavior;
  final PopoverController? controller;
  final OverlayHandler? handler;
  const HoverCard({
    super.key,
    required this.child,
    required this.hoverBuilder,
    this.debounce,
    this.wait,
    this.popoverAlignment,
    this.anchorAlignment,
    this.popoverOffset,
    this.behavior,
    this.controller,
    this.handler,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  late PopoverController _controller;

  int _hoverCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PopoverController();
  }

  @override
  void didUpdateWidget(covariant HoverCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? PopoverController();
    }
  }

  @override
  void dispose() {
    // use this instead of dispose()
    // because controlled might not be ours
    _controller.disposePopovers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<HoverCardTheme>(context);
    final debounce = styleValue(
        widgetValue: widget.debounce,
        themeValue: compTheme?.debounce,
        defaultValue: const Duration(milliseconds: 500));
    final wait = styleValue(
        widgetValue: widget.wait,
        themeValue: compTheme?.wait,
        defaultValue: const Duration(milliseconds: 500));
    final popoverAlignment = styleValue(
        widgetValue: widget.popoverAlignment,
        themeValue: compTheme?.popoverAlignment,
        defaultValue: Alignment.topCenter);
    final anchorAlignment = styleValue(
        widgetValue: widget.anchorAlignment,
        themeValue: compTheme?.anchorAlignment,
        defaultValue: Alignment.bottomCenter);
    final popoverOffset = styleValue(
        widgetValue: widget.popoverOffset,
        themeValue: compTheme?.popoverOffset,
        defaultValue: const Offset(0, 8));
    final behavior = styleValue(
        widgetValue: widget.behavior,
        themeValue: compTheme?.behavior,
        defaultValue: HitTestBehavior.deferToChild);
    return MouseRegion(
      hitTestBehavior: behavior,
      onEnter: (_) {
        int count = ++_hoverCount;
        Future.delayed(wait, () {
          if (count == _hoverCount &&
              !_controller.hasOpenPopover &&
              context.mounted) {
            _showPopover(context,
                alignment: popoverAlignment,
                anchorAlignment: anchorAlignment,
                offset: popoverOffset,
                debounce: debounce);
          }
        });
      },
      onExit: (_) {
        int count = ++_hoverCount;
        Future.delayed(debounce, () {
          if (count == _hoverCount) {
            _controller.close();
          }
        });
      },
      child: GestureDetector(
        onLongPress: () {
          // open popover on long press
          _showPopover(context,
              alignment: popoverAlignment,
              anchorAlignment: anchorAlignment,
              offset: popoverOffset,
              debounce: debounce);
        },
        child: widget.child,
      ),
    );
  }

  void _showPopover(BuildContext context,
      {required AlignmentGeometry alignment,
      AlignmentGeometry? anchorAlignment,
      required Offset offset,
      required Duration debounce}) {
    OverlayHandler? handler = widget.handler;
    if (handler == null) {
      final overlayManager = OverlayManager.of(context);
      handler =
          OverlayManagerAsTooltipOverlayHandler(overlayManager: overlayManager);
    }
    _controller.show(
      context: context,
      builder: (context) {
        return MouseRegion(
          onEnter: (_) {
            _hoverCount++;
          },
          onExit: (_) {
            int count = ++_hoverCount;
            Future.delayed(debounce, () {
              if (count == _hoverCount) {
                _controller.close();
              }
            });
          },
          child: widget.hoverBuilder(context),
        );
      },
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      offset: offset,
      handler: handler,
    );
  }
}
