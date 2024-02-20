import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

enum CheckboxState {
  checked,
  unchecked,
  indeterminate,
}

class Checkbox extends StatefulWidget {
  final CheckboxState state;
  final ValueChanged<CheckboxState>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool tristate;

  const Checkbox({
    Key? key,
    required this.state,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.tristate = false,
  }) : super(key: key);

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  bool _focusing = false;
  void _tap() {
    if (widget.tristate) {
      switch (widget.state) {
        case CheckboxState.checked:
          widget.onChanged!(CheckboxState.unchecked);
          break;
        case CheckboxState.unchecked:
          widget.onChanged!(CheckboxState.indeterminate);
          break;
        case CheckboxState.indeterminate:
          widget.onChanged!(CheckboxState.checked);
          break;
      }
    } else {
      widget.onChanged!(
        widget.state == CheckboxState.checked
            ? CheckboxState.unchecked
            : CheckboxState.checked,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: widget.onChanged != null ? _tap : null,
      child: FocusableActionDetector(
        mouseCursor: widget.onChanged != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onShowFocusHighlight: (bool value) {
          setState(() {
            _focusing = value;
          });
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (Intent intent) {
              if (widget.onChanged != null) {
                _tap();
              }
              return true;
            },
          ),
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.leading != null) widget.leading!.small().medium(),
            // mergeAnimatedTextStyle(
            //   style: themeData.typography.small,
            //   child: widget.leading!,
            //   duration: kDefaultDuration,
            // ),
            if (widget.leading != null) const SizedBox(width: 8),
            AnimatedContainer(
              duration: kDefaultDuration,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _focusing
                      ? themeData.colorScheme.ring
                      : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(themeData.radiusSm),
              ),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: widget.state == CheckboxState.checked
                      ? themeData.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(themeData.radiusSm),
                  border: Border.all(
                    color: widget.state == CheckboxState.checked
                        ? themeData.colorScheme.primary
                        : themeData.colorScheme.mutedForeground,
                    width: 1,
                  ),
                ),
                child: widget.state == CheckboxState.checked
                    ? Icon(
                        Icons.check,
                        color: themeData.colorScheme.primaryForeground,
                        size: 12,
                      )
                    : widget.state == CheckboxState.indeterminate
                        ? Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              borderRadius:
                                  BorderRadius.circular(themeData.radiusXs),
                            ),
                          )
                        : null,
              ),
            ),
            if (widget.trailing != null) const SizedBox(width: 8),
            if (widget.trailing != null)
              // DefaultTextStyle.merge(
              //   style: themeData.typography.small,
              //   child: widget.trailing!,
              // ),
              // mergeAnimatedTextStyle(
              //   style: themeData.typography.small,
              //   child: widget.trailing!,
              //   duration: kDefaultDuration,
              // ),
              widget.trailing!.small().medium(),
          ],
        ),
      ),
    );
  }
}
