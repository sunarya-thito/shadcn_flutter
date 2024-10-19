import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final Duration debounce;
  final Duration wait;
  final WidgetBuilder hoverBuilder;
  final Alignment popoverAlignment;
  final Alignment? anchorAlignment;
  final Offset popoverOffset;
  final HitTestBehavior behavior;
  final PopoverController? controller;
  final OverlayHandler? handler;
  const HoverCard({
    super.key,
    required this.child,
    required this.hoverBuilder,
    this.debounce = const Duration(milliseconds: 500),
    this.wait = const Duration(milliseconds: 500),
    this.popoverAlignment = Alignment.topCenter,
    this.anchorAlignment,
    this.popoverOffset = const Offset(0, 8),
    this.behavior = HitTestBehavior.deferToChild,
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
    return MouseRegion(
      onEnter: (_) {
        int count = ++_hoverCount;
        Future.delayed(widget.wait, () {
          if (count == _hoverCount &&
              !_controller.hasOpenPopover &&
              context.mounted) {
            _showPopover(context);
          }
        });
      },
      onExit: (_) {
        int count = ++_hoverCount;
        Future.delayed(widget.debounce, () {
          if (count == _hoverCount) {
            _controller.close();
          }
        });
      },
      child: GestureDetector(
        onLongPress: () {
          // open popover on long press
          _showPopover(context);
        },
        child: widget.child,
      ),
    );
  }

  void _showPopover(BuildContext context) {
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
            Future.delayed(widget.debounce, () {
              if (count == _hoverCount) {
                _controller.close();
              }
            });
          },
          child: widget.hoverBuilder(context),
        );
      },
      alignment: widget.popoverAlignment,
      anchorAlignment: widget.anchorAlignment,
      offset: widget.popoverOffset,
      handler: handler,
    );
  }
}
