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

  const Button({
    Key? key,
    this.type = ButtonType.primary,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.size = ButtonSize.normal,
    this.mouseCursor = SystemMouseCursors.click,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: FocusableActionDetector(
        mouseCursor: widget.onPressed != null
            ? widget.mouseCursor
            : SystemMouseCursors.basic,
        actions: {
          ActivateAction: CallbackAction(
            onInvoke: (Intent intent) {
              widget.onPressed?.call();
              return true;
            },
          ),
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
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(themeData.radiusMd),
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.primary,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.primary,
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
      ),
      padding: padding,
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.primary,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.primary,
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
      child: mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: _disabled
              ? themeData.colorScheme.mutedForeground
              : themeData.colorScheme.primary,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
          data: IconThemeData(
            color: _disabled
                ? themeData.colorScheme.mutedForeground
                : themeData.colorScheme.primary,
          ),
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
    );
  }
}
