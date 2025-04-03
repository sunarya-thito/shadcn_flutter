import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/control/hover.dart';

class SelectController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  SelectController([super.value]);
}

class ControlledSelect<T> extends StatelessWidget
    with ControlledComponent<T?>, SelectBase<T> {
  @override
  final T? initialValue;
  @override
  final ValueChanged<T?>? onChanged;
  @override
  final bool enabled;
  @override
  final SelectController<T>? controller;

  @override
  final Widget? placeholder;
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final PopoverConstraint popupWidthConstraint;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool autoClosePopover;
  @override
  final SelectPopupBuilder popup;
  @override
  final SelectValueBuilder<T> itemBuilder;
  @override
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  @override
  final Predicate<T>? showValuePredicate;

  const ControlledSelect({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = PopoverConstraint.anchorFixedSize,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.disableHoverEffect = false,
    this.canUnselect = false,
    this.autoClosePopover = true,
    required this.popup,
    required this.itemBuilder,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
    this.showValuePredicate,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<T?>(
      builder: (context, data) {
        return Select<T>(
          onChanged: data.onChanged,
          placeholder: placeholder,
          filled: filled,
          focusNode: focusNode,
          constraints: constraints,
          popupConstraints: popupConstraints,
          popupWidthConstraint: popupWidthConstraint,
          value: data.value,
          borderRadius: borderRadius,
          padding: padding,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          disableHoverEffect: disableHoverEffect,
          canUnselect: canUnselect,
          autoClosePopover: autoClosePopover,
          enabled: data.enabled,
          itemBuilder: itemBuilder,
          valueSelectionHandler: valueSelectionHandler,
          valueSelectionPredicate: valueSelectionPredicate,
          showValuePredicate: showValuePredicate,
          popup: popup,
        );
      },
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
    );
  }
}

class MultiSelectController<T> extends SelectController<Iterable<T>> {
  MultiSelectController([super.value]);
}

class ControlledMultiSelect<T> extends StatelessWidget
    with ControlledComponent<Iterable<T>?>, SelectBase<Iterable<T>> {
  @override
  final Iterable<T>? initialValue;
  @override
  final ValueChanged<Iterable<T>?>? onChanged;
  @override
  final bool enabled;
  @override
  final MultiSelectController<T>? controller;

  @override
  final Widget? placeholder;
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final PopoverConstraint popupWidthConstraint;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool autoClosePopover;
  @override
  final SelectPopupBuilder popup;
  @override
  SelectValueBuilder<Iterable<T>> get itemBuilder => (context, value) {
        return MultiSelect._buildItem(multiItemBuilder, context, value);
      };
  @override
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  @override
  final Predicate<Iterable<T>>? showValuePredicate;
  final SelectValueBuilder<T> multiItemBuilder;

  const ControlledMultiSelect({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = PopoverConstraint.anchorFixedSize,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.disableHoverEffect = false,
    this.canUnselect = true,
    this.autoClosePopover = false,
    this.showValuePredicate,
    required this.popup,
    required SelectValueBuilder<T> itemBuilder,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
  }) : multiItemBuilder = itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ControlledSelect<Iterable<T>>(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      initialValue: initialValue,
      placeholder: placeholder,
      filled: filled,
      focusNode: focusNode,
      constraints: constraints,
      popupConstraints: popupConstraints,
      popupWidthConstraint: popupWidthConstraint,
      borderRadius: borderRadius,
      padding: padding,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      disableHoverEffect: disableHoverEffect,
      canUnselect: canUnselect,
      autoClosePopover: autoClosePopover,
      popup: popup,
      itemBuilder: itemBuilder,
      showValuePredicate: (test) {
        return test.isNotEmpty && (showValuePredicate?.call(test) ?? true);
      },
      valueSelectionHandler:
          valueSelectionHandler ?? _defaultMultiSelectValueSelectionHandler,
      valueSelectionPredicate:
          valueSelectionPredicate ?? _defaultMultiSelectValueSelectionPredicate,
    );
  }
}

class SelectItemButton<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final AbstractButtonStyle style;

  const SelectItemButton({
    super.key,
    required this.value,
    required this.child,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = Data.maybeOf<SelectPopupHandle>(context);
    bool isSelected = data?.isSelected(value) ?? false;
    bool hasSelection = data?.hasSelection ?? false;
    return Button(
      disableTransition: true,
      alignment: AlignmentDirectional.centerStart,
      onPressed: () {
        data?.selectItem(value, !isSelected);
      },
      style: style.copyWith(
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
              LucideIcons.check,
            ).iconSmall()
          : hasSelection
              ? SizedBox(
                  width: 16 * scaling,
                )
              : null,
      child: child.normal(),
    );
  }
}

class SelectGroup extends StatelessWidget {
  final List<Widget>? headers;
  final List<Widget> children;
  final List<Widget>? footers;

  const SelectGroup({
    super.key,
    this.headers,
    this.footers,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
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

class SelectItem extends StatelessWidget {
  final WidgetBuilder builder;
  final Object? value;

  const SelectItem({
    super.key,
    required this.value,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<SelectData>(context);
    final selected = data?.isSelected(value) ?? false;
    return WidgetStatesProvider(
      states: {
        if (selected) WidgetState.selected,
      },
      child: Builder(builder: builder),
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

typedef SelectPopupBuilder = Widget Function(BuildContext context);
typedef SelectValueBuilder<T> = Widget Function(BuildContext context, T value);
typedef SelectValueSelectionHandler<T> = T? Function(
    T? oldValue, Object? value, bool selected);
typedef SelectValueSelectionPredicate<T> = bool Function(
    T? value, Object? test);

T? _defaultSingleSelectValueSelectionHandler<T>(
    T? oldValue, Object? value, bool selected) {
  if (value is! T?) {
    return null;
  }
  return selected ? value : null;
}

bool _defaultSingleSelectValueSelectionPredicate<T>(T? value, Object? test) {
  return value == test;
}

Iterable<T>? _defaultMultiSelectValueSelectionHandler<T>(
    Iterable<T>? oldValue, Object? newValue, bool selected) {
  if (newValue == null) {
    return null;
  }
  Iterable<T> wrappedNewValue = [newValue as T];
  if (oldValue == null) {
    return selected ? wrappedNewValue : null;
  }
  if (selected) {
    return oldValue.followedBy(wrappedNewValue);
  } else {
    var newIterable = oldValue.where((element) => element != newValue);
    return newIterable.isEmpty ? null : newIterable;
  }
}

bool _defaultMultiSelectValueSelectionPredicate<T>(
    Iterable<T>? value, Object? test) {
  if (value == null) {
    return test == null;
  }
  if (test == null) {
    return false;
  }
  return value.contains(test);
}

mixin SelectBase<T> {
  ValueChanged<T?>? get onChanged;
  Widget? get placeholder;
  bool get filled;
  FocusNode? get focusNode;
  BoxConstraints? get constraints;
  BoxConstraints? get popupConstraints;
  PopoverConstraint get popupWidthConstraint;
  BorderRadiusGeometry? get borderRadius;
  EdgeInsetsGeometry? get padding;
  AlignmentGeometry get popoverAlignment;
  AlignmentGeometry? get popoverAnchorAlignment;
  bool get disableHoverEffect;
  bool get canUnselect;
  bool? get autoClosePopover;
  SelectPopupBuilder get popup;
  SelectValueBuilder<T> get itemBuilder;
  SelectValueSelectionHandler<T>? get valueSelectionHandler;
  SelectValueSelectionPredicate<T>? get valueSelectionPredicate;
  Predicate<T>? get showValuePredicate;
}

class Select<T> extends StatefulWidget with SelectBase<T> {
  static const kDefaultSelectMaxHeight = 240.0;
  @override
  final ValueChanged<T?>? onChanged; // if null, then it's a disabled combobox
  @override
  final Widget? placeholder; // placeholder when value is null
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final PopoverConstraint popupWidthConstraint;
  final T? value;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool? autoClosePopover;
  final bool? enabled;
  @override
  final SelectPopupBuilder popup;
  @override
  final SelectValueBuilder<T> itemBuilder;
  @override
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  @override
  final Predicate<T>? showValuePredicate;

  const Select({
    super.key,
    this.onChanged,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = PopoverConstraint.anchorFixedSize,
    this.value,
    this.disableHoverEffect = false,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.canUnselect = false,
    this.autoClosePopover = true,
    this.enabled,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
    this.showValuePredicate,
    required this.popup,
    required this.itemBuilder,
  });

  @override
  SelectState<T> createState() => SelectState<T>();
}

class SelectState<T> extends State<Select<T>>
    with FormValueSupplier<T, Select<T>> {
  late FocusNode _focusNode;
  final PopoverController _popoverController = PopoverController();
  late ValueNotifier<T?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _valueNotifier = ValueNotifier(widget.value);
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(Select<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (widget.value != oldWidget.value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _valueNotifier.value = widget.value;
      });
      formValue = widget.value;
    } else if (widget.valueSelectionPredicate !=
        oldWidget.valueSelectionPredicate) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _valueNotifier.value = widget.value;
      });
    }
    if (widget.enabled != oldWidget.enabled ||
        widget.onChanged != oldWidget.onChanged) {
      bool enabled = widget.enabled ?? widget.onChanged != null;
      if (!enabled) {
        _focusNode.unfocus();
        _popoverController.close();
      }
    }
  }

  Widget get _placeholder {
    if (widget.placeholder != null) {
      return widget.placeholder!;
    }
    return const SizedBox();
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  BoxDecoration _overrideBorderRadius(
      BuildContext context, Set<WidgetState> states, Decoration value) {
    return (value as BoxDecoration).copyWith(
      borderRadius: widget.borderRadius,
    );
  }

  EdgeInsetsGeometry _overridePadding(
      BuildContext context, Set<WidgetState> states, EdgeInsetsGeometry value) {
    return widget.padding!;
  }

  bool _onChanged(Object? value, bool selected) {
    if (!selected && !widget.canUnselect) {
      return false;
    }
    var selectionHandler = widget.valueSelectionHandler ??
        _defaultSingleSelectValueSelectionHandler;
    var newValue = selectionHandler(widget.value, value, selected);
    widget.onChanged?.call(newValue);
    return true;
  }

  bool _isSelected(Object? value) {
    final selectionPredicate = widget.valueSelectionPredicate ??
        _defaultSingleSelectValueSelectionPredicate;
    return selectionPredicate(widget.value, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var enabled = widget.enabled ?? widget.onChanged != null;
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: widget.constraints ?? const BoxConstraints(),
        child: TapRegion(
          onTapOutside: (event) {
            _focusNode.unfocus();
          },
          child: Button(
            enabled: enabled,
            disableHoverEffect: widget.disableHoverEffect,
            focusNode: _focusNode,
            style: (widget.filled
                    ? ButtonVariance.secondary
                    : ButtonVariance.outline)
                .copyWith(
              decoration:
                  widget.borderRadius != null ? _overrideBorderRadius : null,
              padding: widget.padding != null ? _overridePadding : null,
            ),
            onPressed: widget.onChanged == null
                ? null
                : () {
                    // to prevent entire ListView from rebuilding
                    // while the Data<SelectData> is being updated
                    GlobalKey popupKey = GlobalKey();
                    _popoverController
                        .show(
                      context: context,
                      offset: Offset(0, 8 * scaling),
                      alignment: widget.popoverAlignment,
                      anchorAlignment: widget.popoverAnchorAlignment,
                      widthConstraint: widget.popupWidthConstraint,
                      overlayBarrier: OverlayBarrier(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8) * scaling,
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                      ),
                      builder: (context) {
                        return ConstrainedBox(
                          constraints: widget.popupConstraints ??
                              BoxConstraints(
                                maxHeight:
                                    Select.kDefaultSelectMaxHeight * scaling,
                              ),
                          child: ListenableBuilder(
                              listenable: _valueNotifier,
                              builder: (context, _) {
                                return Data.inherit(
                                  key: ValueKey(widget.value),
                                  data: SelectData(
                                    enabled: enabled,
                                    autoClose: widget.autoClosePopover,
                                    isSelected: _isSelected,
                                    onChanged: _onChanged,
                                    hasSelection: widget.value != null,
                                  ),
                                  child: Builder(
                                      key: popupKey,
                                      builder: (context) {
                                        return widget.popup(context);
                                      }),
                                );
                              }),
                        );
                      },
                    )
                        .then(
                      (value) {
                        _focusNode.requestFocus();
                      },
                    );
                  },
            child: WidgetStatesProvider.boundary(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Data.inherit(
                    data: SelectData(
                      enabled: enabled,
                      autoClose: widget.autoClosePopover,
                      isSelected: _isSelected,
                      onChanged: _onChanged,
                      hasSelection: widget.value != null,
                    ),
                    child: Expanded(
                      child: widget.value != null &&
                              (widget.showValuePredicate
                                      ?.call(widget.value as T) ??
                                  true)
                          ? Builder(builder: (context) {
                              return widget.itemBuilder(
                                context,
                                widget.value as T,
                              );
                            })
                          : _placeholder,
                    ),
                  ),
                  SizedBox(width: 8 * scaling),
                  IconTheme.merge(
                    data: IconThemeData(
                      color: theme.colorScheme.foreground,
                      opacity: 0.5,
                    ),
                    child: const Icon(LucideIcons.chevronsUpDown).iconSmall(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatelessWidget {
  final Object? value;
  final Widget child;
  final AbstractButtonStyle style;

  const MultiSelectChip({
    super.key,
    this.style = const ButtonStyle.primary(),
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<SelectData>(context);
    return Chip(
      style: style,
      trailing: data?.enabled == false
          ? null
          : ChipButton(
              onPressed: () {
                data?.onChanged(value, false);
              },
              child: const Icon(
                LucideIcons.x,
              ).iconSmall(),
            ),
      child: child,
    );
  }
}

class MultiSelect<T> extends StatelessWidget with SelectBase<Iterable<T>> {
  @override
  final ValueChanged<Iterable<T>?>?
      onChanged; // if null, then it's a disabled combobox
  @override
  final Widget? placeholder; // placeholder when value is null
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final PopoverConstraint popupWidthConstraint;
  final Iterable<T>? value;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool? autoClosePopover;
  final bool? enabled;
  @override
  final SelectPopupBuilder popup;
  @override
  SelectValueBuilder<Iterable<T>> get itemBuilder => (context, value) {
        return _buildItem(multiItemBuilder, context, value);
      };
  @override
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  final SelectValueBuilder<T> multiItemBuilder;
  @override
  final Predicate<Iterable<T>>? showValuePredicate;

  const MultiSelect({
    super.key,
    this.onChanged,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = PopoverConstraint.anchorFixedSize,
    required this.value,
    this.disableHoverEffect = false,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.canUnselect = true,
    this.autoClosePopover = false,
    this.enabled,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
    this.showValuePredicate,
    required this.popup,
    required SelectValueBuilder<T> itemBuilder,
  }) : multiItemBuilder = itemBuilder;

  static Widget _buildItem<T>(SelectValueBuilder<T> multiItemBuilder,
      BuildContext context, Iterable<T> value) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Wrap(
      spacing: 4 * scaling,
      runSpacing: 4 * scaling,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var value in value) multiItemBuilder(context, value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Select<Iterable<T>>(
      popup: popup,
      itemBuilder: itemBuilder,
      onChanged: onChanged,
      placeholder: placeholder,
      filled: filled,
      focusNode: focusNode,
      constraints: constraints,
      popupConstraints: popupConstraints,
      popupWidthConstraint: popupWidthConstraint,
      value: value,
      borderRadius: borderRadius,
      padding: padding,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      disableHoverEffect: disableHoverEffect,
      canUnselect: canUnselect,
      autoClosePopover: autoClosePopover ?? true,
      enabled: enabled,
      showValuePredicate: (test) {
        return test.isNotEmpty && (showValuePredicate?.call(test) ?? true);
      },
      valueSelectionHandler:
          valueSelectionHandler ?? _defaultMultiSelectValueSelectionHandler,
      valueSelectionPredicate:
          valueSelectionPredicate ?? _defaultMultiSelectValueSelectionPredicate,
    );
  }
}

typedef SelectValueChanged<T> = bool Function(T value, bool selected);

class SelectData {
  final bool? autoClose;
  final Predicate<Object?> isSelected;
  final SelectValueChanged<Object?> onChanged;
  final bool hasSelection;
  final bool enabled;

  const SelectData({
    required this.autoClose,
    required this.isSelected,
    required this.onChanged,
    required this.hasSelection,
    required this.enabled,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SelectData) return false;
    return other.isSelected == isSelected &&
        other.onChanged == onChanged &&
        other.hasSelection == hasSelection &&
        other.autoClose == autoClose &&
        other.enabled == enabled;
  }

  @override
  int get hashCode =>
      Object.hash(isSelected, onChanged, autoClose, hasSelection, enabled);
}

typedef SelectItemsBuilder<T> = FutureOr<SelectItemDelegate> Function(
    BuildContext context, String? searchQuery);

class SelectPopup<T> extends StatefulWidget {
  final SelectItemsBuilder<T>? builder;
  final FutureOr<SelectItemDelegate?>? items;
  final TextEditingController? searchController;
  final Widget? searchPlaceholder;
  final WidgetBuilder? emptyBuilder;
  final WidgetBuilder? loadingBuilder;
  final ErrorWidgetBuilder? errorBuilder;
  final double? surfaceBlur;
  final double? surfaceOpacity;
  final bool? autoClose;
  final bool? canUnselect;
  final bool enableSearch;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final bool disableVirtualization;

  const SelectPopup.builder({
    super.key,
    required this.builder,
    this.searchController,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose,
    this.canUnselect,
    this.enableSearch = true,
    this.errorBuilder,
    this.scrollController,
  })  : items = null,
        shrinkWrap = false,
        disableVirtualization = false;

  const SelectPopup({
    super.key,
    this.items,
    this.searchController,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose,
    this.canUnselect,
    this.scrollController,
    this.shrinkWrap = true,
  })  : builder = null,
        enableSearch = false,
        disableVirtualization = false;

  const SelectPopup.noVirtualization({
    super.key,
    FutureOr<SelectItemList?>? this.items,
    this.searchController,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose,
    this.canUnselect,
    this.scrollController,
  })  : builder = null,
        enableSearch = false,
        disableVirtualization = true,
        shrinkWrap = false;

  /// A method used to implement SelectPopupBuilder
  SelectPopup<T> call(BuildContext context) {
    return this;
  }

  @override
  State<SelectPopup<T>> createState() => _SelectPopupState<T>();
}

mixin SelectPopupHandle {
  bool isSelected(Object? value);
  void selectItem(Object? value, bool selected);
  bool get hasSelection;
  static SelectPopupHandle of(BuildContext context) {
    return Data.of<SelectPopupHandle>(context);
  }
}

class _SelectPopupState<T> extends State<SelectPopup<T>>
    with SelectPopupHandle {
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  SelectData? _selectData;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
    _scrollController = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // because the controller did not get notified when a scroll position is attached
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant SelectPopup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchController != oldWidget.searchController) {
      _searchController = widget.searchController ?? TextEditingController();
    }
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController = widget.scrollController ?? ScrollController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectData = Data.maybeOf<SelectData>(context);
  }

  @override
  bool get hasSelection => _selectData?.hasSelection ?? false;

  @override
  bool isSelected(Object? value) {
    return _selectData?.isSelected(value) ?? false;
  }

  @override
  void selectItem(Object? value, bool selected) {
    _selectData?.onChanged(value, selected);
    if (widget.autoClose ?? _selectData?.autoClose == true) {
      closeOverlay(context, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Data<SelectPopupHandle>.inherit(
      data: this,
      child: ModalContainer(
        clipBehavior: Clip.hardEdge,
        surfaceBlur: widget.surfaceBlur,
        surfaceOpacity: widget.surfaceOpacity,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.enableSearch)
              TextField(
                controller: _searchController,
                border: false,
                features: [
                  InputFeature.leading(
                    const Icon(
                      LucideIcons.search,
                    ).iconSmall().iconMutedForeground(),
                  ),
                ],
                placeholder: widget.searchPlaceholder,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12) *
                        scaling,
              ),
            Flexible(
              child: ListenableBuilder(
                  listenable: _searchController,
                  builder: (context, _) {
                    return CachedValueWidget(
                        value: _searchController.text.isEmpty
                            ? null
                            : _searchController.text,
                        builder: (context, searchQuery) {
                          return FutureOrBuilder<SelectItemDelegate?>(
                              future: widget.builder != null
                                  ? widget.builder!.call(context, searchQuery)
                                  : widget.items != null
                                      ? widget.items!
                                      : SelectItemDelegate.empty,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  Widget? loadingBuilder =
                                      widget.loadingBuilder?.call(context);
                                  if (loadingBuilder != null) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        if (widget.enableSearch)
                                          const Divider(),
                                        Flexible(
                                          child: loadingBuilder,
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                }
                                if (snapshot.hasError) {
                                  Widget? errorBuilder =
                                      widget.errorBuilder?.call(
                                    context,
                                    snapshot.error!,
                                    snapshot.stackTrace,
                                  );
                                  if (errorBuilder != null) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        if (widget.enableSearch)
                                          const Divider(),
                                        Flexible(
                                          child: errorBuilder,
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                }
                                if (snapshot.hasData &&
                                    snapshot.data?.estimatedChildCount != 0) {
                                  var data = snapshot.data!;
                                  return CachedValueWidget(
                                    value: data,
                                    builder: (context, data) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (widget.enableSearch)
                                            const Divider(),
                                          Flexible(
                                            child: Stack(
                                              fit: StackFit.passthrough,
                                              children: [
                                                if (widget
                                                    .disableVirtualization)
                                                  SingleChildScrollView(
                                                    controller:
                                                        _scrollController,
                                                    padding:
                                                        const EdgeInsets.all(
                                                                4) *
                                                            scaling,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        for (var i = 0;
                                                            i <
                                                                (data as SelectItemList)
                                                                    .children
                                                                    .length;
                                                            i++)
                                                          data.build(
                                                              context, i),
                                                      ],
                                                    ),
                                                  )
                                                else
                                                  ListView.builder(
                                                    controller:
                                                        _scrollController,
                                                    padding:
                                                        const EdgeInsets.all(
                                                                4) *
                                                            scaling,
                                                    itemBuilder: data.build,
                                                    shrinkWrap:
                                                        widget.shrinkWrap,
                                                    itemCount: data
                                                        .estimatedChildCount,
                                                  ),
                                                ListenableBuilder(
                                                  listenable: _scrollController,
                                                  builder: (context, child) {
                                                    return Visibility(
                                                      visible: _scrollController
                                                              .offset >
                                                          0,
                                                      child: Positioned(
                                                        top: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: HoverActivity(
                                                          hitTestBehavior:
                                                              HitTestBehavior
                                                                  .translucent,
                                                          debounceDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      16),
                                                          onHover: () {
                                                            // decrease scroll offset
                                                            var value =
                                                                _scrollController
                                                                        .offset -
                                                                    8;
                                                            value = value.clamp(
                                                              0.0,
                                                              _scrollController
                                                                  .position
                                                                  .maxScrollExtent,
                                                            );
                                                            _scrollController
                                                                .jumpTo(
                                                              value,
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4) *
                                                                    scaling,
                                                            child: const Icon(
                                                              RadixIcons
                                                                  .chevronUp,
                                                            ).iconX3Small(),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                ListenableBuilder(
                                                  listenable: _scrollController,
                                                  builder: (context, child) {
                                                    return Visibility(
                                                      visible: _scrollController
                                                              .hasClients &&
                                                          _scrollController
                                                              .position
                                                              .hasContentDimensions &&
                                                          _scrollController
                                                                  .offset <
                                                              _scrollController
                                                                  .position
                                                                  .maxScrollExtent,
                                                      child: Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: HoverActivity(
                                                          hitTestBehavior:
                                                              HitTestBehavior
                                                                  .translucent,
                                                          debounceDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      16),
                                                          onHover: () {
                                                            // increase scroll offset
                                                            var value =
                                                                _scrollController
                                                                        .offset +
                                                                    8;
                                                            value = value.clamp(
                                                              0.0,
                                                              _scrollController
                                                                  .position
                                                                  .maxScrollExtent,
                                                            );
                                                            _scrollController
                                                                .jumpTo(
                                                              value,
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4) *
                                                                    scaling,
                                                            child: const Icon(
                                                              RadixIcons
                                                                  .chevronDown,
                                                            ).iconX3Small(),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                Widget? emptyBuilder =
                                    widget.emptyBuilder?.call(
                                  context,
                                );
                                if (emptyBuilder != null) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (widget.enableSearch) const Divider(),
                                      Flexible(
                                        child: emptyBuilder,
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              });
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class SelectItemDelegate with CachedValue {
  static const empty = EmptySelectItem();
  const SelectItemDelegate();
  Widget? build(BuildContext context, int index);
  int? get estimatedChildCount => null;
  @override
  bool shouldRebuild(covariant SelectItemDelegate oldDelegate);
}

class EmptySelectItem extends SelectItemDelegate {
  const EmptySelectItem();

  @override
  Widget? build(BuildContext context, int index) => null;

  @override
  int get estimatedChildCount => 0;

  @override
  bool shouldRebuild(covariant EmptySelectItem oldDelegate) {
    return false;
  }
}

typedef SelectItemWidgetBuilder = Widget Function(
    BuildContext context, int index);

class SelectItemBuilder extends SelectItemDelegate {
  final SelectItemWidgetBuilder builder;
  final int? childCount;

  const SelectItemBuilder({
    required this.builder,
    this.childCount,
  });

  @override
  Widget build(BuildContext context, int index) {
    return builder(context, index);
  }

  @override
  int? get estimatedChildCount => childCount;

  @override
  bool shouldRebuild(covariant SelectItemBuilder oldDelegate) {
    return oldDelegate.builder != builder &&
        oldDelegate.childCount != childCount;
  }
}

class SelectItemList extends SelectItemDelegate {
  final List<Widget> children;

  const SelectItemList({
    required this.children,
  });

  @override
  Widget build(BuildContext context, int index) {
    return children[index];
  }

  @override
  int get estimatedChildCount => children.length;

  @override
  bool shouldRebuild(covariant SelectItemList oldDelegate) {
    return !listEquals(oldDelegate.children, children);
  }
}
