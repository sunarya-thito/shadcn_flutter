import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SearchFilter<T> = int Function(T item, String query);

class SelectItemButton<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const SelectItemButton({
    Key? key,
    required this.value,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectItem<T>(
      value: value,
      builder: (context, selectItem, selected) {
        return Button(
          disableTransition: true,
          onPressed: selectItem,
          style: const ButtonStyle.ghost().copyWith(
            padding: (context, states, value) => const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            mouseCursor: (context, states, value) {
              return SystemMouseCursors.basic;
            },
          ),
          trailing: selected
              ? const Icon(
                  Icons.check,
                  size: 16,
                )
              : null,
          child: child.normal(),
        );
      },
    );
  }
}

class SelectGroup extends StatelessWidget {
  final List<Widget> children;

  const SelectGroup({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchData = Data.maybeOf<_SelectData>(context);
    assert(searchData != null, 'SelectGroup must be a child of Select');
    return _SelectValuesHolder(
      query: searchData?.query,
      showUnrelatedValues: searchData?.showUnrelatedValues ?? false,
      builder: (children) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        );
      },
      children: children,
    );
  }
}

typedef SelectItemReporter = void Function();
typedef SelectItemBuilder = Widget Function(
    BuildContext context, SelectItemReporter selectItem, bool selected);

class SelectItem<T> extends StatelessWidget {
  final SelectItemBuilder builder;
  final T value;
  final int Function(String query)? computeIndexingScore;

  const SelectItem({
    Key? key,
    required this.value,
    this.computeIndexingScore,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchData = Data.maybeOf<_SelectData>(context);
    assert(searchData != null, 'SelectItem must be a child of Select');
    return _SelectValueHolder(
      computeIndexingScore: (query) {
        if (computeIndexingScore != null) {
          return computeIndexingScore!(query);
        }
        return searchData.searchFilter?.call(value, query) ?? 0;
      },
      child: Data<_SelectData>.boundary(
        child: builder(
          context,
          () {
            searchData.onChanged(value);
          },
          searchData!.value == value,
        ),
      ),
    );
  }
}

class SelectLabel extends StatelessWidget {
  final Widget child;

  const SelectLabel({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: child.medium(),
    );
  }
}

class Select<T> extends StatefulWidget {
  final ValueChanged<T?>? onChanged; // if null, then it's a disabled combobox
  final SearchFilter<T>?
      searchFilter; // if its not null, then it's a searchable combobox
  final Widget? placeholder; // placeholder when value is null
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints constraints;
  final BoxConstraints popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  final List<Widget> children;
  final T? value;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool showUnrelatedValues;

  const Select({
    Key? key,
    this.onChanged,
    this.searchFilter,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints = const BoxConstraints(),
    this.popupConstraints = const BoxConstraints(),
    this.popupWidthConstraint = PopoverConstraint.anchorMinSize,
    this.value,
    this.showUnrelatedValues = false,
    required this.itemBuilder,
    required this.children,
  }) : super(key: key);

  @override
  _SelectState<T> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<Select<T>> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(Select<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  Widget get placeholder {
    if (widget.placeholder != null) {
      return widget.placeholder!;
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: widget.constraints,
      child: Popover(
        builder: (context) {
          return OutlineButton(
            focusNode: _focusNode,
            onPressed: widget.onChanged == null
                ? null
                : () {
                    context.showPopover();
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: widget.value != null
                      ? widget.itemBuilder(
                          context,
                          widget.value as T,
                        )
                      : placeholder,
                ),
                const SizedBox(width: 8),
                AnimatedIconTheme(
                  data: IconThemeData(
                    color: theme.colorScheme.foreground,
                    size: 15,
                    opacity: 0.5,
                  ),
                  duration: kDefaultDuration,
                  child: const Icon(Icons.unfold_more),
                ),
              ],
            ),
          );
        },
        popoverBuilder: (context) {
          return SelectPopup<T>(
            searchFilter: widget.searchFilter,
            constraints: widget.popupConstraints,
            value: widget.value,
            showUnrelatedValues: widget.showUnrelatedValues,
            onChanged: widget.onChanged,
            children: widget.children,
          );
        },
        alignment: Alignment.topCenter,
        anchorAlignment: Alignment.bottomCenter,
        widthConstraint: widget.popupWidthConstraint,
      ),
    );
  }
}

class SelectPopup<T> extends StatefulWidget {
  final T? value;
  final SearchFilter<T>? searchFilter;
  final BoxConstraints constraints;
  final List<Widget> children;
  final bool showUnrelatedValues;
  final ValueChanged<T?>? onChanged;

  const SelectPopup({
    Key? key,
    required this.value,
    this.searchFilter,
    this.constraints = const BoxConstraints(minWidth: 200),
    this.showUnrelatedValues = false,
    this.onChanged,
    required this.children,
  }) : super(key: key);

  @override
  _SelectPopupState<T> createState() => _SelectPopupState<T>();
}

class _SelectPopupState<T> extends State<SelectPopup<T>> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      constraints: widget.constraints,
      child: OutlinedContainer(
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.searchFilter != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        AnimatedIconTheme(
                          duration: kDefaultDuration,
                          data: IconThemeData(
                            color: Theme.of(context).colorScheme.foreground,
                            size: 16,
                            opacity: 0.5,
                          ),
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            border: false,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (widget.searchFilter != null) const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(4),
                    child: AnimatedBuilder(
                      animation: _searchController,
                      builder: (context, child) {
                        String? text = _searchController.text;
                        if (text.trim().isEmpty) {
                          text = null;
                        }
                        return Data(
                          data: _SelectData(
                            (item, query) {
                              return widget.searchFilter?.call(item, query) ??
                                  0;
                            },
                            text,
                            (value) {
                              widget.onChanged?.call(value);
                              Navigator.of(context).pop(value);
                            },
                            widget.value,
                            widget.showUnrelatedValues,
                          ),
                          child: _SelectValuesHolder(
                            query: text,
                            showUnrelatedValues: widget.showUnrelatedValues,
                            builder: (children) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: children,
                              );
                            },
                            children: widget.children,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectData {
  final SearchFilter? searchFilter;
  final String? query;
  final dynamic value;
  final ValueChanged onChanged;
  final bool showUnrelatedValues;

  _SelectData(this.searchFilter, this.query, this.onChanged, this.value,
      this.showUnrelatedValues);
}

abstract class _SelectValueHandler {
  int computeIndexingScore(String query);
}

class _AttachedSelectValue {
  _SelectValueHandler? _handler;
  int? score;

  _SelectValueHandler? get handler => _handler;
  set handler(_SelectValueHandler? value) {
    print('handler set to $value');
    _handler = value;
  }

  _AttachedSelectValue() {
    print('created');
  }
}

class _SelectValuesHolder extends StatefulWidget {
  final List<Widget> children;
  final String? query;
  final bool showUnrelatedValues;
  final Widget Function(List<Widget> children) builder;

  const _SelectValuesHolder({
    Key? key,
    required this.children,
    required this.showUnrelatedValues,
    this.query,
    required this.builder,
  }) : super(key: key);

  @override
  State<_SelectValuesHolder> createState() => _SelectValuesHolderState();
}

class _SelectValuesHolderState extends State<_SelectValuesHolder> {
  late List<_AttachedSelectValue> _attachedValues;

  int computeIndexingScore(String query) {
    int score = 0;
    for (int i = 0; i < widget.children.length; i++) {
      final attachedValue = _attachedValues[i];
      final handler = attachedValue.handler;
      if (handler != null) {
        score += handler.computeIndexingScore(query);
      }
    }
    return score;
  }

  @override
  void initState() {
    super.initState();
    _attachedValues = List.generate(
      widget.children.length,
      (index) => _AttachedSelectValue(),
    );
  }

  @override
  void didUpdateWidget(covariant _SelectValuesHolder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.children, oldWidget.children)) {
      print('generating new attached values');
      _attachedValues = List.generate(
        widget.children.length,
        (index) => _AttachedSelectValue(),
      );
    }
    if (widget.query != oldWidget.query) {
      // invalidate all scores
      if (widget.query != null) {
        for (final attachedValue in _attachedValues) {
          final handler = attachedValue.handler;
          if (handler != null) {
            final score = handler.computeIndexingScore(widget.query!);
            attachedValue.score = score;
          } else {
            attachedValue.score = null;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (widget.query == null) {
      for (int i = 0; i < widget.children.length; i++) {
        final child = widget.children[i];
        children.add(Data(
          data: _attachedValues[i],
          child: child,
        ));
      }
    } else {
      List<_QueriedAttachedValue> queriedValues = [];
      for (int i = 0; i < widget.children.length; i++) {
        final child = widget.children[i];
        final attachedValue = _attachedValues[i];
        final handler = attachedValue.handler;
        final cachedScore = attachedValue.score;
        if (cachedScore != null) {
          print('cached score: $cachedScore');
          queriedValues.add(_QueriedAttachedValue(
            Data(
              data: attachedValue,
              child: child,
            ),
            cachedScore,
            i,
          ));
        } else {
          if (handler != null) {
            final score = handler.computeIndexingScore(widget.query!);
            print('score with handler: $score');
            queriedValues.add(_QueriedAttachedValue(
              Data(
                data: attachedValue,
                child: child,
              ),
              score,
              i,
            ));
            attachedValue.score = score;
          } else {
            // attachedValue.score = 0; // should we cache this?
            print('score without handler: 0');
            queriedValues.add(_QueriedAttachedValue(
              Data(
                data: attachedValue,
                child: child,
              ),
              0,
              i,
            ));
          }
        }
      }
      // queriedValues.sort((a, b) => b.score.compareTo(a.score));
      // sort by score, if same, then sort by index
      queriedValues.sort((a, b) {
        if (a.score == b.score) {
          return a.index.compareTo(b.index);
        }
        return b.score.compareTo(a.score);
      });
      print(queriedValues);
      print('handlers: ${_attachedValues.map((e) => e.handler).toList()}');
      for (final queriedValue in queriedValues) {
        if (queriedValue.score == 0 && !widget.showUnrelatedValues) {
          continue;
        }
        children.add(queriedValue.widget);
      }
    }
    return _SelectValueHolder(
      computeIndexingScore: computeIndexingScore,
      child: widget.builder(children),
    );
  }
}

class _SelectValueHolder extends StatefulWidget {
  final Widget child;
  final int Function(String query) computeIndexingScore;

  const _SelectValueHolder({
    Key? key,
    required this.child,
    required this.computeIndexingScore,
  }) : super(key: key);

  @override
  State<_SelectValueHolder> createState() => _SelectValueHolderState();
}

class _SelectValueHolderState extends State<_SelectValueHolder>
    implements _SelectValueHandler {
  _AttachedSelectValue? _currentAttached;

  @override
  int computeIndexingScore(String query) {
    return widget.computeIndexingScore(query);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newAttached = Data.maybeOf<_AttachedSelectValue>(context);
    if (newAttached != _currentAttached) {
      int? cachedScore = _currentAttached?.score;
      _currentAttached?.handler = null;
      _currentAttached = newAttached;
      _currentAttached?.handler = this;
      if (cachedScore != null) {
        _currentAttached?.score = cachedScore;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<_AttachedSelectValue>.boundary(
      child: widget.child,
    );
  }
}

class _QueriedAttachedValue {
  final Widget widget;
  final int score;
  final int index;

  _QueriedAttachedValue(this.widget, this.score, this.index);

  @override
  String toString() {
    return 'QueriedAttachedValue{widget: $widget, score: $score, index: $index}';
  }
}
