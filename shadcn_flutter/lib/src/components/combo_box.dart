import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SearchFilter<T> = int Function(T item, String query);

class ComboBox<T> extends StatefulWidget {
  final List<T> items;
  final int? selectedIndex;
  final ValueChanged<int?>? onChanged; // if null, then it's a disabled combobox
  final SearchFilter<T>?
      searchFilter; // if its not null, then it's a searchable combobox
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? placeholder; // placeholder when value is null
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints constraints;
  final BoxConstraints popupConstraints;
  final PopupConstraint popupWidthConstraint;

  const ComboBox({
    Key? key,
    required this.items,
    this.selectedIndex,
    this.onChanged,
    this.searchFilter,
    required this.itemBuilder,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints = const BoxConstraints(),
    this.popupConstraints = const BoxConstraints(),
    this.popupWidthConstraint = PopupConstraint.anchorMinSize,
  }) : super(key: key);

  @override
  _ComboBoxState<T> createState() => _ComboBoxState<T>();
}

class _ComboBoxState<T> extends State<ComboBox<T>> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(ComboBox<T> oldWidget) {
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
                  child: widget.selectedIndex != null
                      ? widget.itemBuilder(
                          context,
                          widget.items[widget.selectedIndex!],
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
          return ComboBoxPopup<T>(
            // items: _items,
            // selectedIndex: _selectedIndex,
            items: widget.items,
            selectedIndex: widget.selectedIndex,
            onChanged: widget.onChanged,
            searchFilter: widget.searchFilter,
            itemBuilder: widget.itemBuilder,
            constraints: widget.popupConstraints,
          );
        },
        alignment: Alignment.topCenter,
        anchorAlignment: Alignment.bottomCenter,
        widthConstraint: widget.popupWidthConstraint,
      ),
    );
  }
}

class ComboBoxPopup<T> extends StatefulWidget {
  final List<T> items;
  final int? selectedIndex;
  final ValueChanged<int?>? onChanged;
  final SearchFilter<T>? searchFilter;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final BoxConstraints constraints;

  const ComboBoxPopup({
    Key? key,
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.searchFilter,
    required this.itemBuilder,
    this.constraints = const BoxConstraints(minWidth: 200),
  }) : super(key: key);

  @override
  _ComboBoxPopupState<T> createState() => _ComboBoxPopupState<T>();
}

class ComboBoxItem<T> {
  final int index;
  final T item;

  ComboBoxItem(this.index, this.item);
}

class _ComboBoxPopupState<T> extends State<ComboBoxPopup<T>> {
  final TextEditingController _searchController = TextEditingController();
  late List<ComboBoxItem<T>> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items
        .asMap()
        .entries
        .map((e) => ComboBoxItem(e.key, e.value))
        .toList();
    _searchController.addListener(_onChanged);
  }

  void _onChanged() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _filteredItems = widget.items
            .asMap()
            .entries
            .map((e) => ComboBoxItem(e.key, e.value))
            .toList();
      });
      return;
    }
    final filteredItems = <(int, int, T)>[]; // (score, index, item)
    for (var i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      final score = widget.searchFilter!(item, query);
      if (score > 0) {
        // add to filtered items (but sort by relevance, or by its original index from original list)
        bool added = false;
        for (var j = 0; j < filteredItems.length; j++) {
          if (score > filteredItems[j].$1) {
            filteredItems.insert(j, (score, i, item));
            added = true;
            break;
          } else if (score == filteredItems[j].$1) {
            int byIndex = filteredItems[j].$2;
            if (byIndex > i) {
              filteredItems.insert(j, (score, i, item));
              added = true;
              break;
            }
          }
        }
        if (!added) {
          filteredItems.add((score, i, item));
        }
      }
    }
    // sort by relevance
    setState(() {
      // _filteredItems = filteredItems.map((e) => e.$3).toList();
      _filteredItems =
          filteredItems.map((e) => ComboBoxItem(e.$2, e.$3)).toList();
    });
  }

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var item in _filteredItems)
                          GhostButton(
                            trailing: item.index == widget.selectedIndex
                                ? const Icon(Icons.check, size: 16)
                                : null,
                            onPressed: () {
                              // widget.onChanged?.call(item.index);
                              if (item.index == widget.selectedIndex) {
                                widget.onChanged?.call(null);
                              } else {
                                widget.onChanged?.call(item.index);
                              }
                              Navigator.of(context).pop();
                            },
                            child: widget.itemBuilder(context, item.item),
                          ),
                      ],
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
