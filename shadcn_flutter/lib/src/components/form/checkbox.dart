import '../../../shadcn_flutter.dart';

enum CheckboxState implements Comparable<CheckboxState> {
  checked,
  unchecked,
  indeterminate;

  @override
  int compareTo(CheckboxState other) {
    return index.compareTo(other.index);
  }
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

class _CheckboxState extends State<Checkbox> with FormValueSupplier {
  final bool _focusing = false;

  void _changeTo(CheckboxState state) {
    if (widget.onChanged != null) {
      widget.onChanged!(state);
    }
  }

  void _tap() {
    if (widget.tristate) {
      switch (widget.state) {
        case CheckboxState.checked:
          _changeTo(CheckboxState.unchecked);
          break;
        case CheckboxState.unchecked:
          _changeTo(CheckboxState.indeterminate);
          break;
        case CheckboxState.indeterminate:
          _changeTo(CheckboxState.checked);
          break;
      }
    } else {
      _changeTo(
        widget.state == CheckboxState.checked
            ? CheckboxState.unchecked
            : CheckboxState.checked,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(widget.state, (value) {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  @override
  void didUpdateWidget(covariant Checkbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      reportNewFormValue(widget.state, (value) {
        _changeTo(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Clickable(
      enabled: widget.onChanged != null,
      mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
      onPressed: widget.onChanged != null ? _tap : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) widget.leading!.small().medium(),
          SizedBox(width: theme.scaling * 8),
          Container(
            width: theme.scaling * 16,
            height: theme.scaling * 16,
            decoration: BoxDecoration(
              color: widget.state == CheckboxState.checked
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(theme.radiusSm),
              border: Border.all(
                color: _focusing
                    ? theme.colorScheme.ring
                    : widget.state == CheckboxState.checked
                        ? theme.colorScheme.primary
                        : theme.colorScheme.mutedForeground,
                width: _focusing ? 2 : 1,
              ),
            ),
            child: widget.state == CheckboxState.checked
                ? const Icon(
                    Icons.check,
                  ).iconXSmall().iconPrimaryForeground()
                : widget.state == CheckboxState.indeterminate
                    ? Container(
                        width: theme.scaling * 8,
                        height: theme.scaling * 8,
                        margin: EdgeInsets.all(theme.scaling * 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(theme.radiusXs),
                        ),
                      )
                    : null,
          ),
          SizedBox(width: theme.scaling * 8),
          if (widget.trailing != null) widget.trailing!.small().medium(),
        ],
      ),
    );
  }
}
