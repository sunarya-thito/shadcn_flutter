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
  final Widget? label;
  final bool tristate;

  const Checkbox({
    Key? key,
    required this.state,
    required this.onChanged,
    this.label,
    this.tristate = false,
  }) : super(key: key);

  @override
  _CheckboxState createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
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
        actions: {
          ActivateAction: CallbackAction(
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
          children: [
            Container(
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
            if (widget.label != null) const SizedBox(width: 8),
            if (widget.label != null)
              DefaultTextStyle.merge(
                style: themeData.typography.small,
                child: widget.label!,
              ),
          ],
        ),
      ),
    );
  }
}
