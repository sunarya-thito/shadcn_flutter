import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/focus_outline.dart';

class Clickable extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final WidgetStateProperty<Decoration?>? decoration;
  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<IconThemeData?>? iconTheme;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final HitTestBehavior behavior;
  final bool disableTransition;

  const Clickable({
    super.key,
    required this.child,
    this.enabled = true,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.onPressed,
    this.focusNode,
    this.behavior = HitTestBehavior.translucent,
    this.onHover,
    this.onFocus,
    this.disableTransition = false,
  });

  @override
  State<Clickable> createState() => _ClickableState();
}

class _ClickableState extends State<Clickable> {
  late FocusNode _focusNode;
  final WidgetStatesController _controller = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.update(WidgetState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(covariant Clickable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(WidgetState.disabled, !widget.enabled);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  void _onPressed() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        var enabled = widget.enabled;
        return FocusOutline(
          focused: _controller.value.contains(WidgetState.focused),
          borderRadius: BorderRadius.circular(theme.radiusMd),
          child: GestureDetector(
            behavior: widget.behavior,
            onTap: enabled ? _onPressed : null,
            child: FocusableActionDetector(
              enabled: enabled,
              focusNode: widget.focusNode,
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
                LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
                LogicalKeySet(LogicalKeyboardKey.arrowUp):
                    const DirectionalFocusIntent(TraversalDirection.up),
                LogicalKeySet(LogicalKeyboardKey.arrowDown):
                    const DirectionalFocusIntent(TraversalDirection.down),
                LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                    const DirectionalFocusIntent(TraversalDirection.left),
                LogicalKeySet(LogicalKeyboardKey.arrowRight):
                    const DirectionalFocusIntent(TraversalDirection.right),
              },
              actions: {
                ActivateIntent: CallbackAction(
                  onInvoke: (e) {
                    _onPressed();
                    return null;
                  },
                ),
                DirectionalFocusIntent: CallbackAction(
                  onInvoke: (e) {
                    final direction = (e as DirectionalFocusIntent).direction;
                    final focus = Focus.of(context);
                    switch (direction) {
                      case TraversalDirection.up:
                        focus.focusInDirection(TraversalDirection.up);
                        break;
                      case TraversalDirection.down:
                        focus.focusInDirection(TraversalDirection.down);
                        break;
                      case TraversalDirection.left:
                        focus.focusInDirection(TraversalDirection.left);
                        break;
                      case TraversalDirection.right:
                        focus.focusInDirection(TraversalDirection.right);
                        break;
                    }
                    return null;
                  },
                ),
              },
              onShowHoverHighlight: (value) {
                _controller.update(WidgetState.hovered, value);
                widget.onHover?.call(value);
              },
              onShowFocusHighlight: (value) {
                _controller.update(WidgetState.focused, value);
                widget.onFocus?.call(value);
              },
              mouseCursor: widget.mouseCursor?.resolve(_controller.value) ??
                  MouseCursor.defer,
              child: mergeAnimatedTextStyle(
                duration: kDefaultDuration,
                style: widget.textStyle?.resolve(_controller.value),
                child: AnimatedIconTheme.merge(
                  duration: kDefaultDuration,
                  data: widget.iconTheme?.resolve(_controller.value) ??
                      const IconThemeData(),
                  child: buildContainer(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildContainer(BuildContext context) {
    if (widget.disableTransition) {
      return Container(
        decoration: widget.decoration?.resolve(_controller.value),
        padding: widget.padding?.resolve(_controller.value),
        child: widget.child,
      );
    }
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: widget.decoration?.resolve(_controller.value),
      padding: widget.padding?.resolve(_controller.value),
      child: widget.child,
    );
  }
}
