import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

import '../../../shadcn_flutter.dart';

const kSwitchDuration = Duration(milliseconds: 100);

class SwitchController extends ValueNotifier<bool>
    with ComponentController<bool> {
  SwitchController([super.value = false]);

  void toggle() {
    value = !value;
  }
}

class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  @override
  final bool initialValue;
  @override
  final ValueChanged<bool>? onChanged;
  @override
  final bool enabled;
  @override
  final SwitchController? controller;

  final Widget? leading;
  final Widget? trailing;

  const ControlledSwitch({
    super.key,
    this.controller,
    this.initialValue = false,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Switch(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          leading: leading,
          trailing: trailing,
        );
      },
    );
  }
}

class Switch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool? enabled;

  const Switch({
    super.key,
    required this.value,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.enabled = true,
  });

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> with FormValueSupplier<bool, Switch> {
  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void didUpdateWidget(covariant Switch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return FocusOutline(
      focused: _focusing,
      borderRadius: BorderRadius.circular(theme.radiusXl),
      align: 3 * scaling,
      width: 2 * scaling,
      child: GestureDetector(
        onTap: _enabled
            ? () {
                widget.onChanged?.call(!widget.value);
              }
            : null,
        child: FocusableActionDetector(
          enabled: _enabled,
          onShowFocusHighlight: (value) {
            setState(() {
              _focusing = value;
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
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null) widget.leading!,
              if (widget.leading != null) SizedBox(width: 8 * scaling),
              AnimatedContainer(
                duration: kSwitchDuration,
                width: (32 + 4) * scaling,
                height: (16 + 4) * scaling,
                padding: EdgeInsets.all(2 * scaling),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(theme.radiusXl),
                  color: !_enabled
                      ? theme.colorScheme.muted
                      : widget.value
                          ? theme.colorScheme.primary
                          : theme.colorScheme.border,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: kSwitchDuration,
                      curve: Curves.easeInOut,
                      left: widget.value ? 16 * scaling : 0,
                      top: 0,
                      bottom: 0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(theme.radiusLg),
                            color: theme.colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) SizedBox(width: 8 * scaling),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
