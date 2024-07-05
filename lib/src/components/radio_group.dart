import 'package:flutter/services.dart';

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
  final ValueChanged<bool>? onSelected;
  final T? value;

  const RadioItem({
    Key? key,
    this.leading,
    this.trailing,
    this.onSelected,
    this.value,
  }) : super(key: key);

  @override
  State<RadioItem<T>> createState() => _RadioItemState<T>();
}

class _RadioItemState<T> extends State<RadioItem<T>> {
  _RadioGroupState? _group;
  bool _selected = false;
  bool _focusing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _RadioGroupState<T> newGroup = Data.of(context);
    if (_group != newGroup) {
      _group?._notifier.removeListener(_onChanged);
      _group?._focusing.removeListener(_onFocusChange);
      _group?._items.remove(this);
      _group = newGroup;
      _group?._notifier.addListener(_onChanged);
      _group?._focusing.addListener(_onFocusChange);
      _group?._items.add(this);
      if (_group?._notifier.value == null ||
          !_group!._notifier.value!.mounted) {
        _group?._notifier.value = this;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.onSelected != null) {
            widget.onSelected!(_selected);
          }
        });
      } else {
        _selected = _group?._notifier.value == this;
      }
    }
  }

  @override
  void dispose() {
    _group?._notifier.removeListener(_onChanged);
    _group?._focusing.removeListener(_onFocusChange);
    _group?._items.remove(this);
    if (_group?._notifier.value == this) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _group?._next();
      });
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (!mounted) return;
    setState(() {
      _focusing = _group?._focusing.value ?? false;
    });
  }

  void _onChanged() {
    if (!mounted) return;
    setState(() {
      _selected = _group?._notifier.value == this;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelected != null
          ? () {
              _group?._setSelected(this);
            }
          : null,
      child: MouseRegion(
        cursor: widget.onSelected != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.leading != null) widget.leading!,
            if (widget.leading != null) const SizedBox(width: 8),
            Radio(value: _selected, focusing: _focusing && _selected),
            if (widget.trailing != null) const SizedBox(width: 8),
            if (widget.trailing != null) widget.trailing!,
          ],
        ),
      ),
    );
  }
}

class RadioGroup<T> extends StatefulWidget {
  final Widget child;

  const RadioGroup({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState<T> extends State<RadioGroup> with FormValueSupplier {
  final List<_RadioItemState<T>> _items = [];
  final ValueNotifier<_RadioItemState<T>?> _notifier = ValueNotifier(null);
  final ValueNotifier<bool> _focusing = ValueNotifier(false);

  void _setSelected(_RadioItemState<T> item) {
    _RadioItemState? old = _notifier.value;
    if (old != item) {
      _notifier.value = item;
      if (old != null) {
        old.widget.onSelected?.call(false);
      }
      item.widget.onSelected?.call(true);
      reportNewFormValue(item.widget.value, (value) {
        _setSelectedValue(value);
      });
    }
  }

  void _setSelectedValue(T? value) {
    _RadioItemState<T>? item = findItem(value);
    if (item != null) {
      _setSelected(item);
    }
  }

  _RadioItemState<T>? findItem(dynamic value) {
    for (var item in _items) {
      if (item.widget.value == value) {
        return item;
      }
    }
    return null;
  }

  void _next() {
    if (_items.isEmpty) return;
    int index = _items.indexOf(_notifier.value!);
    if (index == -1) {
      // _notifier.value = _items.first;
      _setSelected(_items.first);
    } else {
      // _notifier.value = _items[(index + 1) % _items.length];
      _setSelected(_items[(index + 1) % _items.length]);
    }
  }

  void _previous() {
    if (_items.isEmpty) return;
    int index = _items.indexOf(_notifier.value!);
    if (index == -1) {
      // _notifier.value = _items.last;
      _setSelected(_items.last);
    } else {
      // _notifier.value = _items[(index - 1 + _items.length) % _items.length];
      _setSelected(_items[(index - 1 + _items.length) % _items.length]);
    }
    // _notifier.value?.widget.onSelected?.call(true);
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowDown): const NextItemIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const PreviousItemIntent(),
        // left
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const PreviousItemIntent(),
        // right
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const NextItemIntent(),
      },
      actions: {
        NextItemIntent: CallbackAction(
          onInvoke: (e) {
            _next();
            return;
          },
        ),
        PreviousItemIntent: CallbackAction(
          onInvoke: (e) {
            _previous();
            return;
          },
        ),
      },
      onShowFocusHighlight: (value) {
        _focusing.value = value;
      },
      child: Data(
        data: this,
        child: widget.child,
      ),
    );
  }
}
