import '../../shadcn_flutter.dart';

class Radio extends StatelessWidget {
  final bool value;
  final bool focusing;

  const Radio({
    Key? key,
    required this.value,
    this.focusing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: focusing ? theme.colorScheme.ring : Colors.transparent),
      ),
      child: AnimatedContainer(
        duration: kDefaultDuration,
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.primary,
          ),
        ),
        child: value
            ? Icon(Icons.check, size: 12, color: theme.colorScheme.primary)
            : null,
      ),
    );
  }
}

class NextItemIntent extends Intent {
  const NextItemIntent();
}

class PreviousItemIntent extends Intent {
  const PreviousItemIntent();
}

class RadioItem<T> extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final T value;
  final bool enabled;
  final FocusNode? focusNode;

  const RadioItem({
    Key? key,
    this.leading,
    this.trailing,
    required this.value,
    this.enabled = true,
    this.focusNode,
  }) : super(key: key);

  @override
  State<RadioItem<T>> createState() => _RadioItemState<T>();
}

class _RadioItemState<T> extends State<RadioItem<T>> with FormValueSupplier {
  late FocusNode _focusNode;

  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RadioItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<_RadioGroupState<T>>(context);
    assert(groupData != null, 'RadioItem must be a descendant of RadioGroup');
    return GestureDetector(
      onTap: widget.enabled
          ? () {
              group?._setSelected(widget.value);
            }
          : null,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        mouseCursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onShowFocusHighlight: (value) {
          if (value && widget.enabled) {
            group?._setSelected(widget.value);
          }
          if (value != _focusing) {
            setState(() {
              _focusing = value;
            });
          }
        },
        child: Data<RadioGroupData<T>>.boundary(
          child: Data<_RadioItemState<T>>.boundary(
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.leading != null) widget.leading!,
                  if (widget.leading != null) const SizedBox(width: 8),
                  Radio(
                      value: groupData?.selectedItem == widget.value,
                      focusing:
                          _focusing && groupData?.selectedItem == widget.value),
                  if (widget.trailing != null) const SizedBox(width: 8),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadioGroup<T> extends StatefulWidget {
  final Widget child;
  final T? value;
  final ValueChanged<T>? onChanged;
  const RadioGroup({
    Key? key,
    required this.child,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _RadioGroupState<T> createState() => _RadioGroupState<T>();
}

class RadioGroupData<T> {
  final T? selectedItem;

  RadioGroupData(this.selectedItem);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioGroupData<T> && other.selectedItem == selectedItem;
  }

  @override
  int get hashCode => selectedItem.hashCode;
}

class _RadioGroupState<T> extends State<RadioGroup<T>> with FormValueSupplier {
  void _setSelected(T value) {
    if (widget.value != value) {
      reportNewFormValue(value, (value) {
        widget.onChanged?.call(value);
      }).then((success) {
        if (success) {
          widget.onChanged?.call(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      child: Data(
        data: this,
        child: Data(
          data: RadioGroupData<T>(widget.value),
          child: FocusTraversalGroup(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
