import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

const kSwitchDuration = Duration(milliseconds: 100);

class Switch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final Widget? trailing;

  const Switch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  bool _focusing = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      child: FocusableActionDetector(
        enabled: widget.onChanged != null,
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
        mouseCursor: SystemMouseCursors.click,
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
                color: widget.onChanged == null
                    ? theme.colorScheme.muted
                    : widget.value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.border,
                border: Border.all(
                  color: _focusing
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  strokeAlign: 3 * scaling,
                  width: 2 * scaling,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(2 * scaling),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: kSwitchDuration,
                      curve: Curves.easeInOut,
                      left: widget.value ? 16 * scaling : 0,
                      child: Container(
                        width: 16 * scaling,
                        height: 16 * scaling,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(theme.radiusLg),
                          color: theme.colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.trailing != null) SizedBox(width: 8 * scaling),
            if (widget.trailing != null) widget.trailing!,
          ],
        ),
      ),
    );
  }
}
