import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension PopoverExtension on BuildContext {
  Future<T?> showPopover<T>() {
    PopoverState state = Data.of(this);
    return state.show();
  }

  void hidePopover() {
    PopoverState state = Data.of(this);
    state.close();
  }
}

class Popover extends StatefulWidget {
  final WidgetBuilder builder;
  final WidgetBuilder popoverBuilder;
  final Alignment alignment;
  final Alignment? anchorAlignment;
  final bool follow;
  final bool modal;
  final PopupConstraint widthConstraint;
  final PopupConstraint heightConstraint;

  const Popover({
    Key? key,
    required this.builder,
    required this.popoverBuilder,
    required this.alignment,
    this.anchorAlignment,
    this.follow = true,
    this.modal = false,
    this.widthConstraint = PopupConstraint.flexible,
    this.heightConstraint = PopupConstraint.flexible,
  }) : super(key: key);

  @override
  PopoverState createState() => PopoverState();
}

class PopoverState extends State<Popover>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late Ticker ticker;
  GlobalKey<PopupAnchorState>? _key;

  @override
  bool get wantKeepAlive {
    // when follow is true, we want to keep the state alive
    // so that the popover can follow the widget
    // this is useful when the widget is in a list
    // list items are destroyed and recreated when scrolling
    return _key != null && widget.follow;
  }

  @override
  void initState() {
    super.initState();
    ticker = createTicker((_) {
      if (_key != null && widget.follow) {
        PopupAnchorState? state = _key!.currentState;
        if (state != null) {
          Alignment alignment = widget.anchorAlignment ?? widget.alignment * -1;
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset position = renderBox.localToGlobal(Offset.zero);
          final Size size = renderBox.size;
          // find offset based on alignment
          // alignment.x and alignment.y is -1, 0, 1 (where 0 is center)
          final Offset result = Offset(
            position.dx + size.width / 2 + size.width / 2 * alignment.x,
            position.dy + size.height / 2 + size.height / 2 * alignment.y,
          );
          state.position = result;
          state.alignment = widget.alignment;
          state.anchorSize = size;
          state.anchorAlignment =
              widget.anchorAlignment ?? widget.alignment * -1;
          state.widthConstraint = widget.widthConstraint;
          state.heightConstraint = widget.heightConstraint;
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant Popover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.follow != widget.follow) {
      if (widget.follow) {
        if (_key?.currentContext?.mounted ?? false) {
          _scheduleShow();
        }
      } else {
        _cancelShow();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DataBuilder(
      data: this,
      builder: widget.builder,
    );
  }

  void _scheduleShow() {
    if (!ticker.isActive && widget.follow) {
      ticker.start();
    }
  }

  void _cancelShow() {
    ticker.stop();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  void close() {
    _key?.currentState?.close();
  }

  Future<T?> show<T>() async {
    Alignment alignment = widget.anchorAlignment ?? widget.alignment * -1;
    WidgetBuilder builder = widget.popoverBuilder;
    _key = GlobalKey<PopupAnchorState>();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    // find offset based on alignment
    // alignment.x and alignment.y is -1, 0, 1 (where 0 is center)
    final Offset result = Offset(
      position.dx + size.width / 2 + size.width / 2 * alignment.x,
      position.dy + size.height / 2 + size.height / 2 * alignment.y,
    );
    _scheduleShow();
    T? res = await showPopup(
        context: context,
        position: result,
        alignment: widget.alignment,
        anchorAlignment: alignment,
        builder: builder,
        modal: widget.modal,
        anchorSize: size,
        widthConstraint: widget.widthConstraint,
        heightConstraint: widget.heightConstraint,
        key: _key);
    _cancelShow();
    _key = null;
    return res;
  }
}

class PopoverController {
  PopoverPortalState? _attached;
  final List<GlobalKey<PopupAnchorState>> _openPopovers = [];

  void _attach(PopoverPortalState state) {
    assert(_attached == null,
        'PopoverController already attached to another PopoverPortal');
    _attached = state;
  }

  void _detach(PopoverPortalState state) {
    assert(_attached == state,
        'PopoverController not attached to this PopoverPortal');
    _attached = null;
  }

  Future<T?> show<T>({
    required WidgetBuilder builder,
    required Alignment alignment,
    required Alignment anchorAlignment,
    PopupConstraint widthConstraint = PopupConstraint.flexible,
    PopupConstraint heightConstraint = PopupConstraint.flexible,
    bool modal = false,
    bool closeOthers = true,
  }) async {
    assert(_attached != null,
        'PopoverController not attached to any PopoverPortal');
    if (closeOthers) {
      close();
    }
    GlobalKey<PopupAnchorState> key = GlobalKey<PopupAnchorState>();
    _openPopovers.add(key);
    RenderBox renderBox = _attached!.context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    Offset result = Offset(
      position.dx + size.width / 2 + size.width / 2 * anchorAlignment.x,
      position.dy + size.height / 2 + size.height / 2 * anchorAlignment.y,
    );
    T? res = await showPopup(
      context: _attached!.context,
      position: result,
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      builder: builder,
      modal: modal,
      anchorSize: size,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
    );
    _openPopovers.remove(key);
    return res;
  }

  void close() {
    for (GlobalKey<PopupAnchorState> key in _openPopovers) {
      key.currentState?.close();
    }
  }
}

class PopoverPortal extends StatefulWidget {
  final PopoverController controller;
  final Widget child;

  const PopoverPortal({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  @override
  PopoverPortalState createState() => PopoverPortalState();
}

class PopoverPortalState extends State<PopoverPortal> {
  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
  }

  @override
  void didUpdateWidget(covariant PopoverPortal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach(this);
      widget.controller._attach(this);
      // transfer open popovers
      for (GlobalKey<PopupAnchorState> key
          in oldWidget.controller._openPopovers) {
        widget.controller._openPopovers.add(key);
      }
    }
  }

  @override
  void dispose() {
    widget.controller._attached = null;
    widget.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
