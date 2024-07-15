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

  const SelectItem({
    Key? key,
    required this.child,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
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

class _ComboBoxItem<T> {
  final int index;
  final T item;

  _ComboBoxItem(this.index, this.item);
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
                        return _SelectValuesHolder(
                          query: _searchController.text,
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

class _SelectValuesHolder extends StatelessWidget {
  final List<Widget> children;
  final String? query;
  final Widget Function(List<Widget> children) builder;

  const _SelectValuesHolder({
    Key? key,
    required this.children,
    this.query,
    required this.builder,
  }) : super(key: key);
}
