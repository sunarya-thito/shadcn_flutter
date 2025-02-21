import '../../../shadcn_flutter.dart';

class Radio extends StatelessWidget {
  final bool value;
  final bool focusing;

  const Radio({
    super.key,
    required this.value,
    this.focusing = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: focusing
                ? theme.colorScheme.ring
                : theme.colorScheme.ring.withValues(alpha: 0)),
      ),
      child: AnimatedContainer(
        duration: kDefaultDuration,
        width: 16 * theme.scaling,
        height: 16 * theme.scaling,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.primary,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: kDefaultDuration,
            // -6 is the padding of the radio
            // -2 is the border width of the radio (1 each side)
            width: value ? (16 - 6 - 2) * theme.scaling : 0,
            height: value ? (16 - 6 - 2) * theme.scaling : 0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
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
    super.key,
    this.leading,
    this.trailing,
    required this.value,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<RadioItem<T>> createState() => _RadioItemState<T>();
}

class _RadioItemState<T> extends State<RadioItem<T>> {
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
    final theme = Theme.of(context);
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<_RadioGroupState<T>>(context);
    assert(groupData != null,
        'RadioItem<$T> must be a descendant of RadioGroup<$T>');
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
                  if (widget.leading != null)
                    SizedBox(width: 8 * theme.scaling),
                  Radio(
                      value: groupData?.selectedItem == widget.value,
                      focusing:
                          _focusing && groupData?.selectedItem == widget.value),
                  if (widget.trailing != null)
                    SizedBox(width: 8 * theme.scaling),
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

class RadioCard<T> extends StatefulWidget {
  final Widget child;
  final T value;
  final bool enabled;
  final FocusNode? focusNode;

  const RadioCard({
    super.key,
    required this.child,
    required this.value,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<RadioCard<T>> createState() => _RadioCardState<T>();
}

class _RadioCardState<T> extends State<RadioCard<T>> {
  late FocusNode _focusNode;
  bool _focusing = false;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RadioCard<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<_RadioGroupState<T>>(context);
    assert(groupData != null,
        'RadioCard<$T> must be a descendant of RadioGroup<$T>');
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
        onShowHoverHighlight: (value) {
          if (value != _hovering) {
            setState(() {
              _hovering = value;
            });
          }
        },
        child: Data<RadioGroupData<T>>.boundary(
          child: Data<_RadioCardState<T>>.boundary(
            child: Card(
              borderColor: groupData?.selectedItem == widget.value
                  ? theme.colorScheme.primary
                  : theme.colorScheme.muted,
              borderWidth: groupData?.selectedItem == widget.value
                  ? 2 * theme.scaling
                  : 1 * theme.scaling,
              borderRadius: theme.borderRadiusMd,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              duration: kDefaultDuration,
              fillColor: _hovering
                  ? theme.colorScheme.muted
                  : theme.colorScheme.background,
              child: Container(
                padding: EdgeInsets.all(16 * theme.scaling),
                child: AnimatedPadding(
                  duration: kDefaultDuration,
                  padding: groupData?.selectedItem == widget.value
                      ? EdgeInsets.zero
                      // to compensate for the border width
                      : EdgeInsets.all(1 * theme.scaling),
                  child: widget.child,
                ),
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
    super.key,
    required this.child,
    this.value,
    this.onChanged,
  });

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

class _RadioGroupState<T> extends State<RadioGroup<T>>
    with FormValueSupplier<T, RadioGroup<T>> {
  void _setSelected(T value) {
    if (widget.value != value) {
      widget.onChanged?.call(value);
    }
  }

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant RadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      child: Data.inherit(
        data: this,
        child: Data.inherit(
          data: RadioGroupData<T>(widget.value),
          child: FocusTraversalGroup(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
