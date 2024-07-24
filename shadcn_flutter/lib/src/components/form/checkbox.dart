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
    final themeData = Theme.of(context);
    return Clickable(
      enabled: widget.onChanged != null,
      mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
      onPressed: widget.onChanged != null ? _tap : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) widget.leading!.small().medium(),
          const SizedBox(width: 8),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: widget.state == CheckboxState.checked
                  ? themeData.colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(themeData.radiusSm),
              border: Border.all(
                color: _focusing
                    ? themeData.colorScheme.ring
                    : widget.state == CheckboxState.checked
                        ? themeData.colorScheme.primary
                        : themeData.colorScheme.mutedForeground,
                width: _focusing ? 2 : 1,
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
          const SizedBox(width: 8),
          if (widget.trailing != null) widget.trailing!.small().medium(),
        ],
      ),
    );
  }
}
