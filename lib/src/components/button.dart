import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

enum ButtonType {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
  link,
}

enum ButtonSize {
  normal,
  icon,
  badge,
}

class Toggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final EdgeInsets padding;

  const Toggle({
    Key? key,
    required this.value,
    this.onChanged,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  }) : super(key: key);

  @override
  _ToggleState createState() => _ToggleState();
}

// toggle button is just ghost button
class _ToggleState extends State<Toggle> {
  bool _hovering = false;
  bool _focusing = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      child: FocusableActionDetector(
        enabled: widget.onChanged != null,
        mouseCursor: widget.onChanged != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onShowFocusHighlight: (value) {
          setState(() {
            _focusing = value;
          });
        },
        onShowHoverHighlight: (value) {
          setState(() {
            _hovering = value;
          });
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (Intent intent) {
              widget.onChanged?.call(!widget.value);
              return true;
            },
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: AnimatedContainer(
          duration: kDefaultDuration,
          decoration: BoxDecoration(
            color: _hovering || widget.value
                ? themeData.colorScheme.muted
                : Colors.transparent,
            borderRadius: BorderRadius.circular(themeData.radiusMd),
            border: _focusing
                ? Border.all(
                    color: themeData.colorScheme.ring,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : Border.all(
                    color: Colors.transparent,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
          ),
          padding: widget.padding,
          child: mergeAnimatedTextStyle(
            duration: kDefaultDuration,
            style: TextStyle(
              color: _hovering && !widget.value
                  ? themeData.colorScheme.mutedForeground
                  : themeData.colorScheme.foreground,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final Widget child;
  final ButtonType type;
  final VoidCallback? onPressed;

  const Badge({
    Key? key,
    required this.child,
    this.type = ButtonType.primary,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      type: type,
      onPressed: onPressed ?? () {},
      size: ButtonSize.badge,
      mouseCursor: SystemMouseCursors.basic,
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 12,
          height: 1.4,
        ),
        child: child,
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final Widget icon;
  final ButtonType type;
  final VoidCallback? onPressed;

  const IconButton({
    Key? key,
    required this.icon,
    this.type = ButtonType.primary,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      type: type,
      onPressed: onPressed,
      size: ButtonSize.icon,
      child: icon,
    );
  }
}

class Button extends StatefulWidget {
  final ButtonType type;
  final Widget? leading;
  final Widget? trailing;
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final MouseCursor mouseCursor;
  final FocusNode? focusNode;
  final bool focusable;
  final EdgeInsets? padding;
  final AlignmentGeometry alignment;
  const Button({
    Key? key,
    this.type = ButtonType.primary,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.size = ButtonSize.normal,
    this.mouseCursor = SystemMouseCursors.click,
    this.focusNode,
    this.focusable = true,
    this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _hovering = false;
  bool _focusing = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant Button oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed?.call();
      },
      child: FocusableActionDetector(
        focusNode: _focusNode,
        enabled: widget.onPressed != null,
        mouseCursor: widget.onPressed != null
            ? widget.mouseCursor
            : SystemMouseCursors.basic,
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (Intent intent) {
              widget.onPressed?.call();
              return true;
            },
          ),
        },
        onShowFocusHighlight: (value) {
          setState(() {
            _focusing = value;
          });
        },
        onShowHoverHighlight: (value) {
          setState(() {
            _hovering = value;
          });
        },
        child: buildButton(context),
      ),
    );
  }

  EdgeInsets get padding {
    if (widget.padding != null) {
      return widget.padding!;
    }
    switch (widget.size) {
      case ButtonSize.normal:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.icon:
        return const EdgeInsets.all(8);
      case ButtonSize.badge:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 2);
    }
  }

  Widget buildButton(BuildContext context) {
    switch (widget.type) {
      case ButtonType.primary:
        return buildPrimary(context);
      case ButtonType.secondary:
        return buildSecondary(context);
      case ButtonType.destructive:
        return buildDestructive(context);
      case ButtonType.outline:
        return buildOutline(context);
      case ButtonType.ghost:
        return buildGhost(context);
      case ButtonType.link:
        return buildLink(context);
    }
  }

  bool get _disabled => widget.onPressed == null;

  Widget buildPrimary(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        color: _disabled
            ? themeData.colorScheme.mutedForeground
            : _hovering
                ? themeData.colorScheme.primary.withOpacity(0.8)
                : themeData.colorScheme.primary,
        borderRadius: BorderRadius.circular(themeData.radiusMd),
        border: _focusing
            ? Border.all(
                color: themeData.colorScheme.ring,
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
            : Border.all(
                color: Colors.transparent,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        style: TextStyle(
          color: themeData.colorScheme.primaryForeground,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: themeData.colorScheme.primaryForeground,
          ),
          child: Basic(
            leading: widget.leading,
            title: widget.child,
            trailing: widget.trailing,
          ),
        ),
        duration: kDefaultDuration,
      ),
    );
  }

  Widget buildSecondary(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        color: _disabled
            ? themeData.colorScheme.primaryForeground
            : _hovering
                ? themeData.colorScheme.secondary.withOpacity(0.8)
                : themeData.colorScheme.secondary,
        borderRadius: BorderRadius.circular(themeData.radiusMd),
        border: _focusing
            ? Border.all(
                color: themeData.colorScheme.ring,
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
            : Border.all(
                color: Colors.transparent,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.secondaryForeground,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.secondaryForeground,
          ),
          child: Basic(
            leading: widget.leading,
            title: widget.child,
            trailing: widget.trailing,
          ),
        ),
      ),
    );
  }

  Widget buildDestructive(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        color: _disabled
            ? themeData.colorScheme.primaryForeground
            : _hovering
                ? themeData.colorScheme.destructive.withOpacity(0.8)
                : themeData.colorScheme.destructive,
        borderRadius: BorderRadius.circular(themeData.radiusMd),
        border: _focusing
            ? Border.all(
                color: themeData.colorScheme.ring,
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
            : Border.all(
                color: Colors.transparent,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.destructiveForeground,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.destructiveForeground,
          ),
          child: Basic(
            leading: widget.leading,
            title: widget.child,
            trailing: widget.trailing,
          ),
        ),
      ),
    );
  }

  Widget buildOutline(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        color: _disabled
            ? Colors.transparent
            : _focusing
                ? themeData.colorScheme.ring
                : _hovering
                    ? themeData.colorScheme.muted.withOpacity(0.8)
                    : Colors.transparent,
        border: Border.all(
          color: _disabled
              ? themeData.colorScheme.muted
              : _hovering
                  ? themeData.colorScheme.muted.withOpacity(0.8)
                  : themeData.colorScheme.muted,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(themeData.radiusMd),
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.foreground,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.foreground,
          ),
          child: Basic(
            leading: widget.leading,
            title: widget.child,
            trailing: widget.trailing,
          ),
        ),
      ),
    );
  }

  Widget buildGhost(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        color: _hovering && !_disabled
            ? themeData.colorScheme.muted.withOpacity(0.8)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(themeData.radiusMd),
        border: _focusing
            ? Border.all(
                color: themeData.colorScheme.ring,
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
            : Border.all(
                color: Colors.transparent,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.foreground,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.foreground,
          ),
          child: Basic(
            leading: widget.leading,
            title: widget.child,
            trailing: widget.trailing,
          ),
        ),
      ),
    );
  }

  Widget buildLink(BuildContext context) {
    var themeData = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(themeData.radiusMd),
        border: _focusing
            ? Border.all(
                color: themeData.colorScheme.ring,
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
            : Border.all(
                color: Colors.transparent,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
      ),
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.foreground,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.foreground,
          ),
          child: Align(
            alignment: widget.alignment,
            child: Basic(
              leading: widget.leading,
              title: UnderlineText(
                underline: _hovering && !_disabled,
                child: widget.child,
              ),
              trailing: widget.trailing,
            ),
          ),
        ),
      ),
    );
  }
}

class LinkButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? selected; // if this is not null, then its a toggle button

  const LinkButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.selected,
  }) : super(key: key);

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool _hovering = false;
  bool _focusing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed?.call();
      },
      child: FocusableActionDetector(
        mouseCursor: widget.onPressed != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onShowFocusHighlight: (value) {
          setState(() {
            _focusing = value;
          });
        },
        onShowHoverHighlight: (value) {
          setState(() {
            _hovering = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: _focusing
                ? Border.all(
                    color: Theme.of(context).colorScheme.ring,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : Border.all(
                    color: Colors.transparent,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
          ),
          child: UnderlineText(
            underline: _hovering,
            child: mergeAnimatedTextStyle(
              style: TextStyle(
                color: widget.selected == null || widget.selected!
                    ? Theme.of(context).colorScheme.foreground
                    : Theme.of(context).colorScheme.mutedForeground,
              ),
              child: widget.child,
              duration: kDefaultDuration,
            ),
          ),
        ),
      ),
    );
  }
}
