import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SearchFilter<T> = int Function(T item, String query);

class SelectGroup extends StatelessWidget {
  final List<Widget> children;

  const SelectGroup({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class SelectItem<T> extends StatelessWidget {
  final Widget child;
  final T value;
  final int Function(String query)? computeIndexingScore;

  const SelectItem({
    Key? key,
    required this.child,
    required this.value,
    this.computeIndexingScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SelectValueHolder(
      child: child,
      computeIndexingScore: (query) {
        if (computeIndexingScore != null) {
          return computeIndexingScore!(query);
        }
        return 0;
      },
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: child,
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
            onPressed: () {
              context.showPopover();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: widget.value != null
                      ? widget.itemBuilder(
                          context,
                          widget.value!,
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
            onChanged: widget.onChanged,
            value: widget.value,
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
  final ValueChanged<T?>? onChanged;
  final T? value;
  final SearchFilter<T>? searchFilter;
  final BoxConstraints constraints;
  final List<Widget> children;

  const SelectPopup({
    Key? key,
    required this.value,
    required this.onChanged,
    this.searchFilter,
    this.constraints = const BoxConstraints(minWidth: 200),
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
                        return _SelectValuesHolder(
                          query: text,
                          children: widget.children,
                          builder: (children) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: children,
                            );
                          },
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

abstract class _SelectValueHandler {
  int computeIndexingScore(String query);
}

class _AttachedSelectValue {
  _SelectValueHandler? handler;
  int? score;
}

class _SelectValuesHolder extends StatefulWidget {
  final List<Widget> children;
  final String? query;
  final Widget Function(List<Widget> children) builder;

  const _SelectValuesHolder({
    Key? key,
    required this.children,
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
            attachedValue.score = 0;
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
          queriedValues.add(_QueriedAttachedValue(
            Data(
              data: attachedValue,
              child: child,
            ),
            cachedScore,
          ));
        } else {
          if (handler != null) {
            final score = handler.computeIndexingScore(widget.query!);
            queriedValues.add(_QueriedAttachedValue(
              Data(
                data: attachedValue,
                child: child,
              ),
              score,
            ));
            attachedValue.score = score;
          } else {
            attachedValue.score = 0; // should we cache this?
            queriedValues.add(_QueriedAttachedValue(
              Data(
                data: attachedValue,
                child: child,
              ),
              0,
            ));
          }
        }
      }
      queriedValues.sort((a, b) => b.score.compareTo(a.score));
      for (final queriedValue in queriedValues) {
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
      _currentAttached?.handler = null;
      _currentAttached = newAttached;
      _currentAttached?.handler = this;
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

  _QueriedAttachedValue(this.widget, this.score);
}
