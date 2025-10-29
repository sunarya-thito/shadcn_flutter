import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget for selecting items from a collection using various presentation modes.
///
/// This widget provides a flexible item selection interface that can display
/// items in different layouts (grid, list) and presentation modes (dialog, popover).
/// It's suitable for scenarios where users need to pick from a predefined set
/// of items like colors, icons, templates, or any custom objects.
///
/// The ItemPicker uses a delegate pattern to provide items, allowing for both
/// static lists and dynamic item generation. Items are displayed using a
/// custom builder function that determines how each item appears in the picker.
///
/// Example:
/// ```dart
/// ItemPicker<Color>(
///   items: ItemList([Colors.red, Colors.green, Colors.blue]),
///   value: Colors.red,
///   builder: (context, color, isSelected) {
///     return Container(
///       width: 40,
///       height: 40,
///       decoration: BoxDecoration(
///         color: color,
///         shape: BoxShape.circle,
///         border: isSelected ? Border.all(width: 2) : null,
///       ),
///     );
///   },
///   onChanged: (color) => print('Selected color: $color'),
/// );
/// ```
class ItemPicker<T> extends StatelessWidget {
  /// Delegate providing the collection of items to display for selection.
  ///
  /// This delegate abstracts the item source, supporting both static lists
  /// through [ItemList] and dynamic generation through [ItemBuilder].
  final ItemChildDelegate<T> items;

  /// Builder function that creates the visual representation of each item.
  ///
  /// Called for each item to create its visual representation in the picker.
  /// The builder receives the item value and selection state, allowing
  /// customized appearance based on the current selection.
  final ItemPickerBuilder<T> builder;

  /// The currently selected item, if any.
  ///
  /// When null, no item is selected. The picker highlights this item
  /// visually to indicate the current selection state.
  final T? value;

  /// Callback invoked when the user selects a different item.
  ///
  /// Called when the user taps on an item in the picker. The callback
  /// receives the selected item, or null if the selection is cleared.
  final ValueChanged<T?>? onChanged;

  /// Layout style for arranging items in the picker interface.
  ///
  /// Determines how items are arranged within the picker container,
  /// such as grid or list layout. Defaults to grid layout.
  final ItemPickerLayout? layout;

  /// Widget displayed when no item is currently selected.
  ///
  /// Shown in the picker trigger button when [value] is null.
  /// Provides visual feedback that no selection has been made yet.
  final Widget? placeholder;

  /// Optional title widget for the picker interface.
  ///
  /// Displayed at the top of the picker when shown in dialog mode,
  /// providing context about what the user is selecting.
  final Widget? title;

  /// Presentation mode for the item picker interface.
  ///
  /// Controls whether the picker appears as a modal dialog or a popover
  /// dropdown. Defaults to dialog mode for better item visibility.
  final PromptMode? mode;

  /// Size constraints for the picker interface container.
  ///
  /// Controls the dimensions of the picker when displayed, allowing
  /// customization of the available space for item display.
  final BoxConstraints? constraints;

  /// Creates an [ItemPicker].
  ///
  /// The [items] delegate provides the selectable items, and the [builder]
  /// function determines how each item is visually represented. Various
  /// options control the picker's layout and presentation style.
  ///
  /// Parameters:
  /// - [items] (`ItemChildDelegate<T>`, required): Source of items for selection
  /// - [builder] (`ItemPickerBuilder<T>`, required): Function to build item representations
  /// - [value] (T?, optional): Currently selected item
  /// - [onChanged] (`ValueChanged<T?>?`, optional): Callback for selection changes
  /// - [layout] (ItemPickerLayout?, optional): Arrangement style for items
  /// - [placeholder] (Widget?, optional): Content shown when no item is selected
  /// - [title] (Widget?, optional): Title for the picker interface
  /// - [mode] (PromptMode?, optional): Presentation style (dialog or popover)
  /// - [constraints] (BoxConstraints?, optional): Size constraints for the picker
  ///
  /// Example:
  /// ```dart
  /// ItemPicker<IconData>(
  ///   items: ItemList([Icons.home, Icons.star, Icons.favorite]),
  ///   layout: ItemPickerLayout.grid,
  ///   mode: PromptMode.dialog,
  ///   builder: (context, icon, selected) => Icon(icon),
  ///   onChanged: (icon) => updateIcon(icon),
  /// );
  /// ```
  const ItemPicker({
    super.key,
    required this.items,
    required this.builder,
    this.value,
    this.onChanged,
    this.layout,
    this.placeholder,
    this.title,
    this.mode,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final layout = this.layout ?? ItemPickerLayout.grid;
    final mode = this.mode ?? PromptMode.dialog;
    final constraints = this.constraints;
    return ObjectFormField(
        value: value,
        placeholder: placeholder ?? const SizedBox.shrink(),
        builder: builder,
        dialogTitle: title,
        onChanged: onChanged,
        mode: mode,
        decorate: false,
        editorBuilder: (context, handler) {
          if (mode == PromptMode.dialog) {
            final theme = Theme.of(context);
            return ModalBackdrop(
              borderRadius: theme.borderRadiusXl,
              child: ModalContainer(
                borderRadius: theme.borderRadiusXl,
                padding: EdgeInsets.zero,
                child: _InternalItemPicker<T>(
                  items: items,
                  builder: builder,
                  initialValue: handler.value,
                  layout: layout,
                  title: title,
                  constraints: constraints,
                  onChanged: (value) {
                    closeOverlay(context, value);
                  },
                ),
              ),
            );
          } else {
            return SurfaceCard(
              padding: EdgeInsets.zero,
              child: _InternalItemPicker<T>(
                items: items,
                builder: builder,
                initialValue: handler.value,
                layout: layout,
                title: title,
                constraints: constraints,
                onChanged: (value) {
                  closeOverlay(context, value);
                },
              ),
            );
          }
        });
  }
}

abstract class ItemChildDelegate<T> {
  const ItemChildDelegate();
  int? get itemCount;
  T? operator [](int index);
}

class ItemList<T> extends ItemChildDelegate<T> {
  final List<T> items;
  const ItemList(this.items);
  @override
  int get itemCount => items.length;
  @override
  T operator [](int index) => items[index];
}

class ItemBuilder<T> extends ItemChildDelegate<T> {
  @override
  final int? itemCount;
  final T? Function(int index) itemBuilder;
  const ItemBuilder({this.itemCount, required this.itemBuilder});

  @override
  T? operator [](int index) => itemBuilder(index);
}

typedef ItemPickerBuilder<T> = Widget Function(BuildContext context, T item);

abstract class ItemPickerLayout {
  static const ListItemPickerLayout list = ListItemPickerLayout();
  static const GridItemPickerLayout grid = GridItemPickerLayout();
  const ItemPickerLayout();
  Widget build(
      BuildContext context, ItemChildDelegate items, ItemPickerBuilder builder);
}

class ListItemPickerLayout extends ItemPickerLayout {
  const ListItemPickerLayout();
  @override
  Widget build(BuildContext context, ItemChildDelegate items,
      ItemPickerBuilder builder) {
    final padding = MediaQuery.paddingOf(context);
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: ListView.builder(
        itemCount: items.itemCount,
        padding: padding,
        itemBuilder: (context, index) {
          var item = items[index];
          if (item == null) {
            return null;
          }
          return builder(context, item);
        },
      ),
    );
  }
}

class GridItemPickerLayout extends ItemPickerLayout {
  final int crossAxisCount;
  const GridItemPickerLayout({this.crossAxisCount = 4});

  ItemPickerLayout call({int crossAxisCount = 4}) {
    return GridItemPickerLayout(crossAxisCount: crossAxisCount);
  }

  @override
  Widget build(BuildContext context, ItemChildDelegate items,
      ItemPickerBuilder builder) {
    final theme = Theme.of(context);
    final padding = MediaQuery.paddingOf(context);
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 4.0 * theme.scaling,
          crossAxisSpacing: 4.0 * theme.scaling,
        ),
        padding: padding,
        itemCount: items.itemCount,
        itemBuilder: (context, index) {
          var item = items[index];
          if (item == null) {
            return null;
          }
          return builder(context, item);
        },
      ),
    );
  }
}

Future<T?> showItemPicker<T>(
  BuildContext context, {
  required ItemChildDelegate<T> items,
  required ItemPickerBuilder<T> builder,
  T? initialValue,
  ItemPickerLayout layout = const GridItemPickerLayout(),
  AlignmentGeometry? alignment,
  AlignmentGeometry? anchorAlignment,
  BoxConstraints? constraints,
  Offset? offset,
  Widget? title,
}) {
  final theme = Theme.of(context);
  return showPopover<T>(
    context: context,
    alignment: alignment ?? AlignmentDirectional.topStart,
    anchorAlignment: anchorAlignment ?? AlignmentDirectional.bottomStart,
    offset: offset ?? Offset(0, 8.0 * theme.scaling),
    builder: (context) {
      return SurfaceCard(
        padding: EdgeInsets.zero,
        child: _InternalItemPicker<T>(
          items: items,
          builder: builder,
          initialValue: initialValue,
          layout: layout,
          title: title,
          constraints: constraints,
          onChanged: (value) {
            closeOverlay(context, value);
          },
        ),
      );
    },
  ).future;
}

class _InternalItemPicker<T> extends StatelessWidget {
  final ItemChildDelegate<T> items;
  final ItemPickerBuilder<T> builder;
  final T? initialValue;
  final ItemPickerLayout layout;
  final Widget? title;
  final BoxConstraints? constraints;
  final ValueChanged<T?> onChanged;
  const _InternalItemPicker({
    super.key,
    required this.items,
    required this.builder,
    required this.initialValue,
    required this.layout,
    this.title,
    this.constraints,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.paddingOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.all(16.0 * theme.scaling) +
                EdgeInsets.only(top: padding.top),
            child: title?.large.semiBold,
          ),
        ConstrainedBox(
          constraints: constraints ??
              BoxConstraints(
                maxWidth: 320 * theme.scaling,
                maxHeight: 320 * theme.scaling,
              ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: title != null
                  ? padding.copyWith(top: 0) +
                      const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0) *
                          theme.scaling
                  : padding + const EdgeInsets.all(8) * theme.scaling,
            ),
            child: ItemPickerDialog<T>(
              items: items,
              builder: builder,
              layout: layout,
              value: initialValue,
              onChanged: onChanged,
            ),
          ),
        )
      ],
    );
  }
}

Future<T?> showItemPickerDialog<T>(
  BuildContext context, {
  required ItemChildDelegate<T> items,
  required ItemPickerBuilder<T> builder,
  ItemPickerLayout layout = const GridItemPickerLayout(),
  T? initialValue,
  BoxConstraints? constraints,
  required Widget title,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      return ModalBackdrop(
        borderRadius: theme.borderRadiusXl,
        child: ModalContainer(
          borderRadius: theme.borderRadiusXl,
          padding: EdgeInsets.zero,
          child: _InternalItemPicker<T>(
            items: items,
            builder: builder,
            initialValue: initialValue,
            layout: layout,
            title: title,
            constraints: constraints,
            onChanged: (value) {
              closeOverlay(context, value);
            },
          ),
        ),
      );
    },
  );
}

class ItemPickerDialog<T> extends StatefulWidget {
  final ItemChildDelegate<T> items;
  final ItemPickerBuilder<T> builder;
  final ItemPickerLayout layout;
  final T? value;
  final ValueChanged<T?>? onChanged;
  const ItemPickerDialog({
    super.key,
    required this.items,
    required this.builder,
    this.value,
    this.onChanged,
    this.layout = const GridItemPickerLayout(),
  });

  @override
  State<ItemPickerDialog<T>> createState() => _ItemPickerDialogState<T>();
}

class _ItemPickerDialogState<T> extends State<ItemPickerDialog<T>> {
  void _onChanged(Object? value) {
    widget.onChanged?.call(value as T);
  }

  Widget _buildItem(BuildContext context, Object? item) {
    assert(item is T, 'Item type must be $T');
    return widget.builder(context, item as T);
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: ItemPickerData(
        value: widget.value,
        onChanged: _onChanged,
        layout: widget.layout,
      ),
      child: widget.layout.build(context, widget.items, _buildItem),
    );
  }
}

class ItemPickerData {
  final Object? value;
  final ValueChanged<Object?>? onChanged;
  final ItemPickerLayout layout;
  const ItemPickerData({this.value, this.onChanged, required this.layout});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemPickerData) return false;
    return other.value == value &&
        other.onChanged == onChanged &&
        other.layout == layout;
  }

  @override
  int get hashCode => Object.hash(value, onChanged, layout);
}

class ItemPickerOption<T> extends StatelessWidget {
  final T value;
  final Widget? label;
  final Widget child;
  final AbstractButtonStyle? style;
  final AbstractButtonStyle? selectedStyle;
  const ItemPickerOption({
    super.key,
    required this.value,
    required this.child,
    this.style,
    this.selectedStyle,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<ItemPickerData>(context);
    if (data == null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          Size size = constraints.biggest;
          if (size.width == size.height) {
            return Stack(
              fit: StackFit.passthrough,
              children: [
                child,
                if (label != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(child: label),
                  ),
              ],
            );
          }
          if (label == null) {
            return child;
          }
          return BasicLayout(
            leading: child,
            content: label,
          );
        },
      );
    }
    if (data.layout is ListItemPickerLayout) {
      if (label == null) {
        return Button(
          onPressed:
              data.onChanged == null ? null : () => data.onChanged!(value),
          style: data.value == value
              ? (selectedStyle ?? ButtonVariance.primary)
              : (style ?? ButtonVariance.ghost),
          child: child,
        );
      }
      return Button(
        onPressed: data.onChanged == null ? null : () => data.onChanged!(value),
        leading: child,
        style: data.value == value
            ? (selectedStyle ?? ButtonVariance.primary)
            : (style ?? ButtonVariance.ghost),
        child: label!,
      );
    }
    return IconButton(
      icon: Stack(
        fit: StackFit.passthrough,
        children: [
          child,
          if (label != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(child: label),
            ),
        ],
      ),
      onPressed: data.onChanged == null ? null : () => data.onChanged!(value),
      variance: data.value == value
          ? (selectedStyle ?? ButtonVariance.primary)
          : (style ?? ButtonVariance.ghost),
    );
  }
}
