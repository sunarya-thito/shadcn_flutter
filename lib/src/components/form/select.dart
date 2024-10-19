import 'package:flutter/foundation.dart';
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
  final List<T> selectedValue;

  const SearchQuery(this.query, this.searchFilter, this.selectedValue);
}

class SelectItemButton<T> extends StatelessWidget
    implements AbstractSelectItem<T> {
  final T value;
  final Widget child;
  final SearchIndexer? computeIndexingScore;

  const SelectItemButton({
    super.key,
    this.computeIndexingScore,
    required this.value,
    required this.child,
  });

  @override
  SearchResult search(SearchQuery<T> query) {
    if (query.query.isEmpty) {
      return SearchResult(0, query.selectedValue.contains(value));
    }
    return SearchResult(
      computeIndexingScore?.call(query.query) ??
          query.searchFilter?.call(value, query.query) ??
          0,
      query.selectedValue.contains(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return SelectItem<T>(
      value: value,
      builder: (context, selectItem, selected) {
        var isSelected = selected.contains(value);
        return Button(
          disableTransition: true,
          alignment: AlignmentDirectional.centerStart,
          onPressed: () {
            selectItem(!isSelected);
          },
          style: const ButtonStyle.ghost().copyWith(
            padding: (context, states, value) => EdgeInsets.symmetric(
              vertical: 8 * scaling,
              horizontal: 8 * scaling,
            ),
            mouseCursor: (context, states, value) {
              return SystemMouseCursors.basic;
            },
          ),
          trailing: isSelected
              ? const Icon(
                  Icons.check,
                ).iconSmall()
              : selected.isNotEmpty
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
    super.key,
    this.headers,
    this.footers,
    this.showUnrelatedValues,
    required this.children,
    this.searchFilter,
  });

  const SelectGroup.fixedOrder({
    super.key,
    this.headers,
    this.footers,
    this.showUnrelatedValues,
    required this.children,
  }) : searchFilter = _keepOrderFilter;

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
    final searchData = Data.maybeOf<SelectData>(context);
    assert(searchData != null, 'SelectGroup must be a child of Select');
    return AnimatedBuilder(
      animation: searchData!.value,
      builder: (context, child) {
        final text = searchData.query;
        Map<AbstractSelectItem<T>, SelectSearchResult> resultMap = {};
        for (int i = 0; i < this.children.length; i++) {
          var item = this.children[i];
          if (text == null || text.isEmpty) {
            var result = item.search(SearchQuery<T>(text ?? '',
                searchData.searchFilter, searchData.value.value as List<T>));
            resultMap[item] = SelectSearchResult(0, i, result.hasSelectedValue);
          } else {
            var result = item.search(SearchQuery<T>(text,
                searchData.searchFilter, searchData.value.value as List<T>));
            int score = result.score;
            bool hasSelectedValue = result.hasSelectedValue;
            if (score > 0 || searchData.showUnrelatedValues) {
              resultMap[item] = SelectSearchResult(score, i, hasSelectedValue);
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
      },
    );
  }
}

typedef SelectItemReporter = void Function(bool selected);
typedef SelectItemBuilder<T> = Widget Function(
    BuildContext context, SelectItemReporter selectItem, List<T> selectedValue);

abstract class AbstractSelectItem<T> extends Widget {
  const AbstractSelectItem({super.key});

  SearchResult search(SearchQuery<T> query);
}

class SelectItem<T> extends StatelessWidget implements AbstractSelectItem<T> {
  final SelectItemBuilder<T> builder;
  final T value;

  const SelectItem({
    super.key,
    required this.value,
    required this.builder,
  });

  @override
  SearchResult search(SearchQuery<T> query) {
    bool hasSelectedValue = query.selectedValue.contains(value);
    if (query.query.isEmpty) {
      return SearchResult(0, hasSelectedValue);
    }
    return SearchResult(
      query.searchFilter?.call(value, query.query) ?? 0,
      hasSelectedValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchData = Data.maybeOf<SelectData>(context);
    assert(searchData != null, 'SelectItem must be a child of Select');
    return Data<SelectData>.boundary(
      child: AnimatedBuilder(
          animation: searchData!.value,
          builder: (context, child) {
            return builder(
              context,
              (selected) {
                searchData.onChanged(value, selected);
              },
              searchData.value.value as List<T>,
            );
          }),
    );
  }
}

class SelectLabel extends StatelessWidget {
  final Widget child;

  const SelectLabel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: const EdgeInsets.all(8) * scaling,
      child: child.semiBold().small(),
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
  final double? surfaceBlur;
  final double? surfaceOpacity;
  final bool disableHoverEffect;
  final bool canUnselect;
  final bool autoClosePopover;

  const Select({
    super.key,
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
    this.disableHoverEffect = false,
    this.borderRadius,
    this.searchPlaceholder,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.emptyBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.canUnselect = false,
    this.autoClosePopover = true,
    required this.itemBuilder,
    required this.children,
  });

  @override
  SelectState<T> createState() => SelectState<T>();
}

class SelectState<T> extends State<Select<T>> with FormValueSupplier {
  late FocusNode _focusNode;
  final PopoverController _popoverController = PopoverController();
  late ValueNotifier<List<T>> _valueNotifier;
  late ValueNotifier<List<AbstractSelectItem<T>>> _childrenNotifier;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _valueNotifier =
        ValueNotifier(widget.value == null ? const [] : [widget.value as T]);
    _childrenNotifier = ValueNotifier(widget.children);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      widget.value,
      (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }

  @override
  void didUpdateWidget(Select<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (widget.value != oldWidget.value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _valueNotifier.value =
            widget.value == null ? const [] : [widget.value as T];
      });
      reportNewFormValue(
        widget.value,
        (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      );
    }
    if (!listEquals(widget.children, oldWidget.children)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _childrenNotifier.value = widget.children;
      });
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
      child: TapRegion(
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        child: Button(
          disableHoverEffect: widget.disableHoverEffect,
          focusNode: _focusNode,
          style: (widget.filled
                  ? ButtonVariance.secondary
                  : ButtonVariance.outline)
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
                  _popoverController
                      .show(
                    context: context,
                    alignment: widget.popoverAlignment,
                    anchorAlignment: widget.popoverAnchorAlignment,
                    widthConstraint: widget.popupWidthConstraint,
                    overlayBarrier: OverlayBarrier(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8) * scaling,
                      borderRadius: BorderRadius.circular(theme.radiusLg),
                    ),
                    builder: (context) {
                      return SelectPopup<T>(
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                        margin:
                            const EdgeInsets.symmetric(vertical: 8) * scaling,
                        autoClose: widget.autoClosePopover,
                        orderSelectedFirst: widget.orderSelectedFirst,
                        searchPlaceholder: widget.searchPlaceholder,
                        searchFilter: widget.searchFilter,
                        constraints: widget.popupConstraints,
                        value: _valueNotifier,
                        showUnrelatedValues: widget.showUnrelatedValues,
                        onChanged: widget.onChanged == null
                            ? null
                            : (value, selected) {
                                if (selected && widget.value != value) {
                                  widget.onChanged!(value);
                                } else if (widget.canUnselect &&
                                    widget.value == value) {
                                  widget.onChanged!(null);
                                }
                              },
                        emptyBuilder: widget.emptyBuilder,
                        surfaceBlur: widget.surfaceBlur,
                        surfaceOpacity: widget.surfaceOpacity,
                        children: _childrenNotifier,
                      );
                    },
                  )
                      .then(
                    (value) {
                      _focusNode.requestFocus();
                    },
                  );
                },
          child: IntrinsicWidth(
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
        ),
      ),
    );
  }
}

typedef SelectValueChanged<T> = void Function(T value, bool selected);

class SelectPopup<T> extends StatefulWidget {
  final ValueListenable<List<T>> value;
  final SearchFilter<T>? searchFilter;
  final BoxConstraints? constraints;
  final ValueListenable<List<AbstractSelectItem<T>>> children;
  final bool showUnrelatedValues;
  final SelectValueChanged<T>? onChanged;
  final String? searchPlaceholder;
  final WidgetBuilder? emptyBuilder;
  final bool orderSelectedFirst;
  final double? surfaceBlur;
  final double? surfaceOpacity;
  final bool autoClose;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;

  const SelectPopup({
    super.key,
    required this.value,
    this.searchFilter,
    this.constraints,
    this.showUnrelatedValues = false,
    this.onChanged,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.orderSelectedFirst = true,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose = true,
    required this.margin,
    required this.borderRadius,
    required this.children,
  });

  @override
  SelectPopupState<T> createState() => SelectPopupState<T>();
}

class SelectPopupState<T> extends State<SelectPopup<T>> {
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
    final surfaceBlur = widget.surfaceBlur ?? theme.surfaceBlur;
    final surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    return Container(
      margin: widget.margin,
      constraints: widget.constraints ??
          (const BoxConstraints(
                minWidth: 200,
              ) *
              scaling),
      child: OutlinedContainer(
        clipBehavior: Clip.hardEdge,
        surfaceBlur: surfaceBlur,
        surfaceOpacity: surfaceOpacity,
        borderRadius: widget.borderRadius,
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
                  child: ListenableBuilder(
                    listenable: Listenable.merge([
                      _searchController,
                      widget.value,
                      widget.children,
                    ]),
                    builder: (context, child) {
                      String text = _searchController.text;
                      Map<AbstractSelectItem<T>, SelectSearchResult> resultMap =
                          {};
                      for (int i = 0; i < widget.children.value.length; i++) {
                        var item = widget.children.value[i];
                        if (text.isEmpty) {
                          var result = item.search(SearchQuery<T>(
                              text, widget.searchFilter, widget.value.value));
                          resultMap[item] =
                              SelectSearchResult(0, i, result.hasSelectedValue);
                        } else {
                          var result = item.search(SearchQuery<T>(
                              text, widget.searchFilter, widget.value.value));
                          int score = result.score;
                          bool hasSelectedValue = result.hasSelectedValue;
                          if (score > 0 || widget.showUnrelatedValues) {
                            resultMap[item] =
                                SelectSearchResult(score, i, hasSelectedValue);
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
                        data: SelectData(
                          (item, query) {
                            return widget.searchFilter?.call(item, query) ?? 0;
                          },
                          text,
                          (value, selected) {
                            widget.onChanged?.call(value, selected);
                            if (widget.autoClose) {
                              closePopover(context, value);
                            }
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

class SelectSearchResult {
  final int score;
  final int index;
  final bool hasSelectedValue;

  SelectSearchResult(this.score, this.index, this.hasSelectedValue);
}

class SelectData {
  final SearchFilter? searchFilter;
  final String? query;
  final ValueListenable<List<Object?>> value;
  final SelectValueChanged onChanged;
  final bool showUnrelatedValues;
  final bool orderSelectedFirst;

  SelectData(this.searchFilter, this.query, this.onChanged, this.value,
      this.showUnrelatedValues, this.orderSelectedFirst);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectData &&
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

class MultiSelect<T> extends StatefulWidget {
  final ValueChanged<List<T>>?
      onChanged; // if null, then it's a disabled combobox
  final SearchFilter<T>?
      searchFilter; // if its not null, then it's a searchable combobox
  final Widget? placeholder; // placeholder when value is null
  final bool filled;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final BoxConstraints? popupConstraints;
  final PopoverConstraint popupWidthConstraint;
  final List<AbstractSelectItem<T>> children;
  final List<T> value;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool showUnrelatedValues;
  final BorderRadius? borderRadius;
  final String? searchPlaceholder;
  final EdgeInsetsGeometry? padding;
  final Alignment popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final WidgetBuilder? emptyBuilder;
  final bool orderSelectedFirst;
  final double? surfaceBlur;
  final double? surfaceOpacity;
  final bool disableHoverEffect;
  final bool autoClosePopover;

  const MultiSelect({
    super.key,
    this.onChanged,
    this.searchFilter,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = PopoverConstraint.anchorMinSize,
    required this.value,
    this.showUnrelatedValues = false,
    this.orderSelectedFirst = true,
    this.disableHoverEffect = false,
    this.borderRadius,
    this.searchPlaceholder,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.emptyBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClosePopover = false,
    required this.itemBuilder,
    required this.children,
  });

  @override
  State<MultiSelect<T>> createState() => MultiSelectState<T>();
}

class MultiSelectState<T> extends State<MultiSelect<T>> with FormValueSupplier {
  late FocusNode _focusNode;
  final PopoverController _popoverController = PopoverController();
  late ValueNotifier<List<T>> _valueNotifier;
  late ValueNotifier<List<AbstractSelectItem<T>>> _childrenNotifier;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _valueNotifier = ValueNotifier(widget.value);
    _childrenNotifier = ValueNotifier(widget.children);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      widget.value,
      (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }

  @override
  void didUpdateWidget(MultiSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (!listEquals(widget.value, oldWidget.value)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _valueNotifier.value = widget.value;
      });
      reportNewFormValue(
        widget.value,
        (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      );
    }
    if (!listEquals(widget.children, oldWidget.children)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _childrenNotifier.value = widget.children;
      });
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
      child: TapRegion(
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        child: Button(
          disableHoverEffect: widget.disableHoverEffect,
          focusNode: _focusNode,
          style: (widget.filled
                  ? ButtonVariance.secondary
                  : ButtonVariance.outline)
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
                  _popoverController
                      .show(
                    context: context,
                    alignment: widget.popoverAlignment,
                    anchorAlignment: widget.popoverAnchorAlignment,
                    widthConstraint: widget.popupWidthConstraint,
                    overlayBarrier: OverlayBarrier(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8) * scaling,
                      borderRadius: BorderRadius.circular(theme.radiusLg),
                    ),
                    builder: (context) {
                      return SelectPopup<T>(
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                        margin:
                            const EdgeInsets.symmetric(vertical: 8) * scaling,
                        orderSelectedFirst: widget.orderSelectedFirst,
                        searchPlaceholder: widget.searchPlaceholder,
                        searchFilter: widget.searchFilter,
                        constraints: widget.popupConstraints,
                        value: _valueNotifier,
                        showUnrelatedValues: widget.showUnrelatedValues,
                        autoClose: widget.autoClosePopover,
                        onChanged: widget.onChanged == null
                            ? null
                            : (value, selected) {
                                if (value != null) {
                                  List<T> newValue = List.from(widget.value);
                                  if (selected) {
                                    newValue.add(value);
                                  } else {
                                    newValue.remove(value);
                                  }
                                  widget.onChanged!(newValue);
                                }
                              },
                        emptyBuilder: widget.emptyBuilder,
                        surfaceBlur: widget.surfaceBlur,
                        surfaceOpacity: widget.surfaceOpacity,
                        children: _childrenNotifier,
                      );
                    },
                  )
                      .then(
                    (value) {
                      _focusNode.requestFocus();
                    },
                  );
                },
          child: IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: widget.value.isNotEmpty
                      ? Wrap(
                          spacing: 4 * scaling,
                          runSpacing: 4 * scaling,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for (var value in widget.value)
                              Chip(
                                style: const ButtonStyle.primary(),
                                trailing: ChipButton(
                                  onPressed: widget.onChanged == null
                                      ? null
                                      : () {
                                          if (widget.onChanged != null) {
                                            List<T> newValue =
                                                List.from(widget.value);
                                            newValue.remove(value);
                                            widget.onChanged!(newValue);
                                          }
                                        },
                                  child: const Icon(
                                    Icons.close,
                                  ).iconSmall(),
                                ),
                                child: widget.itemBuilder(
                                  context,
                                  value,
                                ),
                              ),
                          ],
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
        ),
      ),
    );
  }
}
