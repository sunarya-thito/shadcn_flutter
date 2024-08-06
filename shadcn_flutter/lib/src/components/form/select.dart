import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/control/hover.dart';

typedef SearchFilter<T> = int Function(T item, String query);
typedef SearchIndexer = int Function(String query);

class SearchResult {
  final bool hasSelectedValue;
  final int score;

  const SearchResult(this.score, this.hasSelectedValue);
}

class SearchQuery<T> {
  final String query;
  final SearchFilter<T>? searchFilter;
  final T? selectedValue;

  const SearchQuery(this.query, this.searchFilter, this.selectedValue);
}

class SelectItemButton<T> extends StatelessWidget
    implements AbstractSelectItem<T> {
  final T value;
  final Widget child;
  final SearchIndexer? computeIndexingScore;

  const SelectItemButton({
    Key? key,
    this.computeIndexingScore,
    required this.value,
    required this.child,
  }) : super(key: key);

  @override
  SearchResult search(SearchQuery<T> query) {
    if (query.query.isEmpty) {
      return SearchResult(0, query.selectedValue == value);
    }
    return SearchResult(
      computeIndexingScore?.call(query.query) ??
          query.searchFilter?.call(value, query.query) ??
          0,
      query.selectedValue == value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SelectItem<T>(
      value: value,
      builder: (context, selectItem, selected) {
        return Button(
          disableTransition: true,
          onPressed: selectItem,
          style: const ButtonStyle.ghost().copyWith(
            padding: (context, states, value) => EdgeInsets.symmetric(
              vertical: 8 * scaling,
              horizontal: 8 * scaling,
            ),
            mouseCursor: (context, states, value) {
              return SystemMouseCursors.basic;
            },
          ),
          trailing: selected == value
              ? const Icon(
                  Icons.check,
                ).iconSmall()
              : selected != null
                  ? SizedBox(
                      width: 16 * scaling,
                    )
                  : null,
          child: child.normal(),
        );
      },
    );
  }
}

class SelectGroup<T> extends StatelessWidget implements AbstractSelectItem<T> {
  static int _keepOrderFilter<T>(T item, String query) {
    return 1;
  }

  final List<Widget>? headers;
  final List<AbstractSelectItem<T>> children;
  final List<Widget>? footers;
  final bool? showUnrelatedValues;
  final SearchFilter<T>? searchFilter;

  const SelectGroup({
    Key? key,
    this.headers,
    this.footers,
    this.showUnrelatedValues,
    required this.children,
    this.searchFilter,
  }) : super(key: key);

  const SelectGroup.fixedOrder({
    Key? key,
    this.headers,
    this.footers,
    this.showUnrelatedValues,
    required this.children,
  })  : searchFilter = _keepOrderFilter,
        super(key: key);

  @override
  SearchResult search(SearchQuery<T> query) {
    if (searchFilter != null) {
      query = SearchQuery(query.query, searchFilter, query.selectedValue);
    }
    if (query.query.isEmpty) {
      bool hasSelectedValue = false;
      if (searchFilter != _keepOrderFilter) {
        for (var item in children) {
          if (item.search(query).hasSelectedValue) {
            hasSelectedValue = true;
            break;
          }
        }
      }
      return SearchResult(0, hasSelectedValue);
    }
    int score = 0;
    bool hasSelectedValue = false;
    for (var item in children) {
      var result = item.search(query);
      score += result.score;
      if (searchFilter != _keepOrderFilter && result.hasSelectedValue) {
        hasSelectedValue = true;
      }
    }
    return SearchResult(score, hasSelectedValue);
  }

  @override
  Widget build(BuildContext context) {
    final searchData = Data.maybeOf<_SelectData>(context);
    assert(searchData != null, 'SelectGroup must be a child of Select');
    final text = searchData!.query;
    Map<AbstractSelectItem<T>, _SearchResult> resultMap = {};
    for (int i = 0; i < this.children.length; i++) {
      var item = this.children[i];
      if (text == null || text.isEmpty) {
        var result = item.search(SearchQuery<T>(
            text ?? '', searchData.searchFilter, searchData.value));
        resultMap[item] = _SearchResult(0, i, result.hasSelectedValue);
      } else {
        var result = item.search(
            SearchQuery<T>(text, searchData.searchFilter, searchData.value));
        int score = result.score;
        bool hasSelectedValue = result.hasSelectedValue;
        if (score > 0 || searchData.showUnrelatedValues) {
          resultMap[item] = _SearchResult(score, i, hasSelectedValue);
        }
      }
    }
    List<Widget> children = [];
    // sort from largest score to lowest score, if score is same, then sort by index
    resultMap.entries.toList()
      ..sort((a, b) {
        if (searchData.orderSelectedFirst) {
          if (a.value.hasSelectedValue && !b.value.hasSelectedValue) {
            return -1;
          }
          if (!a.value.hasSelectedValue && b.value.hasSelectedValue) {
            return 1;
          }
        }
        if (a.value.score == b.value.score) {
          return a.value.index.compareTo(b.value.index);
        }
        return b.value.score.compareTo(a.value.score);
      })
      ..forEach((element) {
        children.add(element.key);
      });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (headers != null) ...headers!,
        ...children,
        if (footers != null) ...footers!,
      ],
    );
  }
}

typedef SelectItemReporter = void Function();
typedef SelectItemBuilder<T> = Widget Function(
    BuildContext context, SelectItemReporter selectItem, T? selectedValue);

abstract class AbstractSelectItem<T> extends Widget {
  SearchResult search(SearchQuery<T> query);
}

class SelectItem<T> extends StatelessWidget implements AbstractSelectItem<T> {
  final SelectItemBuilder<T> builder;
  final T value;

  const SelectItem({
    Key? key,
    required this.value,
    required this.builder,
  }) : super(key: key);

  @override
  SearchResult search(SearchQuery<T> query) {
    if (query.query.isEmpty) {
      return SearchResult(0, query.selectedValue == value);
    }
    return SearchResult(
      query.searchFilter?.call(value, query.query) ?? 0,
      query.selectedValue == value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchData = Data.maybeOf<_SelectData>(context);
    assert(searchData != null, 'SelectItem must be a child of Select');
    return Data<_SelectData>.boundary(
      child: builder(
        context,
        () {
          searchData.onChanged(value);
        },
        searchData!.value,
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
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: const EdgeInsets.all(8) * scaling,
      child: child.semiBold(),
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
  final BoxConstraints? constraints;
  final BoxConstraints? popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  final List<AbstractSelectItem<T>> children;
  final T? value;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool showUnrelatedValues;
  final BorderRadius? borderRadius;
  final String? searchPlaceholder;
  final EdgeInsetsGeometry? padding;
  final Alignment popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final WidgetBuilder? emptyBuilder;
  final bool orderSelectedFirst;

  const Select({
    Key? key,
    this.onChanged,
    this.searchFilter,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = PopoverConstraint.anchorMinSize,
    this.value,
    this.showUnrelatedValues = false,
    this.orderSelectedFirst = true,
    this.borderRadius,
    this.searchPlaceholder,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.emptyBuilder,
    required this.itemBuilder,
    required this.children,
  }) : super(key: key);

  @override
  _SelectState<T> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<Select<T>> {
  late FocusNode _focusNode;
  final PopoverController _popoverController = PopoverController();

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
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return ConstrainedBox(
      constraints: widget.constraints ?? const BoxConstraints(),
      child: Button(
        focusNode: _focusNode,
        style:
            (widget.filled ? ButtonVariance.secondary : ButtonVariance.outline)
                .copyWith(
          decoration: widget.borderRadius != null
              ? (context, states, decoration) {
                  return (decoration as BoxDecoration).copyWith(
                    borderRadius: widget.borderRadius,
                  );
                }
              : null,
          padding: widget.padding != null
              ? (context, states, value) => widget.padding!
              : null,
        ),
        onPressed: widget.onChanged == null
            ? null
            : () {
                _popoverController.show(
                  context: context,
                  alignment: widget.popoverAlignment,
                  anchorAlignment: widget.popoverAnchorAlignment,
                  widthConstraint: widget.popupWidthConstraint,
                  builder: (context) {
                    return SelectPopup<T>(
                      orderSelectedFirst: widget.orderSelectedFirst,
                      searchPlaceholder: widget.searchPlaceholder,
                      searchFilter: widget.searchFilter,
                      constraints: widget.popupConstraints,
                      value: widget.value,
                      showUnrelatedValues: widget.showUnrelatedValues,
                      onChanged: widget.onChanged,
                      emptyBuilder: widget.emptyBuilder,
                      children: widget.children,
                    );
                  },
                );
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
            SizedBox(width: 8 * scaling),
            AnimatedIconTheme(
              data: IconThemeData(
                color: theme.colorScheme.foreground,
                opacity: 0.5,
              ),
              duration: kDefaultDuration,
              child: const Icon(Icons.unfold_more).iconSmall(),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectPopup<T> extends StatefulWidget {
  final T? value;
  final SearchFilter<T>? searchFilter;
  final BoxConstraints? constraints;
  final List<AbstractSelectItem<T>> children;
  final bool showUnrelatedValues;
  final ValueChanged<T?>? onChanged;
  final String? searchPlaceholder;
  final WidgetBuilder? emptyBuilder;
  final bool orderSelectedFirst;

  const SelectPopup({
    Key? key,
    required this.value,
    this.searchFilter,
    this.constraints,
    this.showUnrelatedValues = false,
    this.onChanged,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.orderSelectedFirst = true,
    required this.children,
  }) : super(key: key);

  @override
  _SelectPopupState<T> createState() => _SelectPopupState<T>();
}

class _SelectPopupState<T> extends State<SelectPopup<T>> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // this is required due to late scroll controller attachment
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8) * scaling,
      constraints: widget.constraints ??
          (const BoxConstraints(
                minWidth: 200,
              ) *
              scaling),
      child: OutlinedContainer(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.searchFilter != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12) * scaling,
                child: Row(
                  children: [
                    AnimatedIconTheme(
                      duration: kDefaultDuration,
                      data: IconThemeData(
                        color: Theme.of(context).colorScheme.foreground,
                        opacity: 0.5,
                      ),
                      child: const Icon(
                        Icons.search,
                      ).iconSmall(),
                    ),
                    SizedBox(width: 8 * scaling),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        border: false,
                        placeholder: widget.searchPlaceholder,
                        padding:
                            const EdgeInsets.symmetric(vertical: 12) * scaling,
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.searchFilter != null) const Divider(),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(theme.radiusXl),
                  bottomRight: Radius.circular(theme.radiusXl),
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: AnimatedBuilder(
                    animation: _searchController,
                    builder: (context, child) {
                      String text = _searchController.text;
                      Map<AbstractSelectItem<T>, _SearchResult> resultMap = {};
                      for (int i = 0; i < widget.children.length; i++) {
                        var item = widget.children[i];
                        if (text.isEmpty) {
                          var result = item.search(SearchQuery<T>(
                              text, widget.searchFilter, widget.value));
                          resultMap[item] =
                              _SearchResult(0, i, result.hasSelectedValue);
                        } else {
                          var result = item.search(SearchQuery<T>(
                              text, widget.searchFilter, widget.value));
                          int score = result.score;
                          bool hasSelectedValue = result.hasSelectedValue;
                          if (score > 0 || widget.showUnrelatedValues) {
                            resultMap[item] =
                                _SearchResult(score, i, hasSelectedValue);
                          }
                        }
                      }
                      List<Widget> children = [];
                      // sort from largest score to lowest score, if score is same, then sort by index
                      resultMap.entries.toList()
                        ..sort((a, b) {
                          if (widget.orderSelectedFirst) {
                            if (a.value.hasSelectedValue &&
                                !b.value.hasSelectedValue) {
                              return -1;
                            }
                            if (!a.value.hasSelectedValue &&
                                b.value.hasSelectedValue) {
                              return 1;
                            }
                          }
                          if (a.value.score == b.value.score) {
                            return a.value.index.compareTo(b.value.index);
                          }
                          return b.value.score.compareTo(a.value.score);
                        })
                        ..forEach((element) {
                          children.add(element.key);
                        });
                      Widget child;
                      if (children.isEmpty) {
                        child = widget.emptyBuilder?.call(context) ??
                            const SizedBox();
                      } else {
                        child = Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Padding(
                              // to fix visual glitch, add padding
                              padding:
                                  const EdgeInsets.only(top: 1, bottom: 1) *
                                      scaling,
                              child: ListView(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(4) * scaling,
                                shrinkWrap: true,
                                children: children,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _scrollController,
                              builder: (context, child) {
                                return Visibility(
                                  visible: _scrollController.offset > 0,
                                  child: Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: HoverActivity(
                                      hitTestBehavior:
                                          HitTestBehavior.translucent,
                                      debounceDuration:
                                          const Duration(milliseconds: 16),
                                      onHover: () {
                                        // decrease scroll offset
                                        var value =
                                            _scrollController.offset - 8;
                                        value = value.clamp(
                                          0.0,
                                          _scrollController
                                              .position.maxScrollExtent,
                                        );
                                        _scrollController.jumpTo(
                                          value,
                                        );
                                      },
                                      child: Container(
                                        color: theme.colorScheme.background,
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 4) *
                                            scaling,
                                        child: const Icon(
                                          RadixIcons.chevronUp,
                                        ).iconX3Small(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            AnimatedBuilder(
                              animation: _scrollController,
                              builder: (context, child) {
                                return Visibility(
                                  visible: _scrollController.hasClients &&
                                      _scrollController
                                          .position.hasContentDimensions &&
                                      _scrollController.offset <
                                          _scrollController
                                              .position.maxScrollExtent,
                                  child: Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: HoverActivity(
                                      hitTestBehavior:
                                          HitTestBehavior.translucent,
                                      debounceDuration:
                                          const Duration(milliseconds: 16),
                                      onHover: () {
                                        // increase scroll offset
                                        var value =
                                            _scrollController.offset + 8;
                                        value = value.clamp(
                                          0.0,
                                          _scrollController
                                              .position.maxScrollExtent,
                                        );
                                        _scrollController.jumpTo(
                                          value,
                                        );
                                      },
                                      child: Container(
                                        color: theme.colorScheme.background,
                                        padding: const EdgeInsets.symmetric(
                                                vertical: 4) *
                                            scaling,
                                        child: const Icon(
                                          RadixIcons.chevronDown,
                                        ).iconX3Small(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return Data.inherit(
                        data: _SelectData(
                          (item, query) {
                            return widget.searchFilter?.call(item, query) ?? 0;
                          },
                          text,
                          (value) {
                            widget.onChanged?.call(value);
                            closePopover(context, value);
                          },
                          widget.value,
                          widget.showUnrelatedValues,
                          widget.orderSelectedFirst,
                        ),
                        child: child,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResult {
  final int score;
  final int index;
  final bool hasSelectedValue;

  _SearchResult(this.score, this.index, this.hasSelectedValue);
}

class _SelectData {
  final SearchFilter? searchFilter;
  final String? query;
  final dynamic value;
  final ValueChanged onChanged;
  final bool showUnrelatedValues;
  final bool orderSelectedFirst;

  _SelectData(this.searchFilter, this.query, this.onChanged, this.value,
      this.showUnrelatedValues, this.orderSelectedFirst);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _SelectData &&
        other.searchFilter == searchFilter &&
        other.query == query &&
        other.value == value &&
        other.onChanged == onChanged &&
        other.showUnrelatedValues == showUnrelatedValues &&
        other.orderSelectedFirst == orderSelectedFirst;
  }

  @override
  int get hashCode {
    return Object.hash(
      searchFilter,
      query,
      value,
      onChanged,
      showUnrelatedValues,
      orderSelectedFirst,
    );
  }
}
