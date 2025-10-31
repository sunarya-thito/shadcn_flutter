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

/// Abstract delegate for providing items to an item picker.
///
/// Defines an interface for accessing items by index, used by [ItemPickerLayout]
/// to build the list or grid of items. Concrete implementations include
/// [ItemList] for fixed arrays and [ItemBuilder] for lazy generation.
///
/// See also:
/// - [ItemList], which wraps a fixed list of items.
/// - [ItemBuilder], which generates items on demand.
abstract class ItemChildDelegate<T> {
  /// Creates an [ItemChildDelegate].
  const ItemChildDelegate();

  /// The total number of items, or null if infinite or unknown.
  int? get itemCount;

  /// Retrieves the item at the specified index.
  ///
  /// Parameters:
  /// - [index] (`int`, required): The index of the item.
  ///
  /// Returns: The item at the index, or null if not available.
  T? operator [](int index);
}

/// A delegate that wraps a fixed list of items.
///
/// Provides items from a pre-defined `List<T>`.
///
/// Example:
/// ```dart
/// ItemList<String>(['Apple', 'Banana', 'Cherry'])
/// ```
class ItemList<T> extends ItemChildDelegate<T> {
  /// The list of items.
  final List<T> items;

  /// Creates an [ItemList].
  ///
  /// Parameters:
  /// - [items] (`List<T>`, required): The items to provide.
  const ItemList(this.items);

  @override
  int get itemCount => items.length;

  @override
  T operator [](int index) => items[index];
}

/// A delegate that builds items on demand using a builder function.
///
/// Allows lazy generation of items, useful for large or infinite lists.
///
/// Example:
/// ```dart
/// ItemBuilder<int>(
///   itemCount: 100,
///   itemBuilder: (index) => index * 2,
/// )
/// ```
class ItemBuilder<T> extends ItemChildDelegate<T> {
  @override

  /// The total number of items, or null if infinite.
  final int? itemCount;

  /// Builder function that returns an item for the given index.
  final T? Function(int index) itemBuilder;

  /// Creates an [ItemBuilder].
  ///
  /// Parameters:
  /// - [itemCount] (`int?`, optional): Number of items, or null if infinite.
  /// - [itemBuilder] (`T? Function(int)`, required): Function to build items.
  const ItemBuilder({this.itemCount, required this.itemBuilder});

  @override
  T? operator [](int index) => itemBuilder(index);
}

/// A builder function that creates a widget for an item.
///
/// Parameters:
/// - [context] (`BuildContext`, required): The build context.
/// - [item] (`T`, required): The item to display.
///
/// Returns: A widget representing the item.
typedef ItemPickerBuilder<T> = Widget Function(BuildContext context, T item);

/// Abstract base class for item picker layout strategies.
///
/// Defines how items are displayed in an item picker, such as in a list
/// or grid. Provides factory constants for common layouts.
///
/// See also:
/// - [ListItemPickerLayout], which displays items in a vertical list.
/// - [GridItemPickerLayout], which displays items in a grid.
abstract class ItemPickerLayout {
  /// A list layout for item pickers.
  static const ListItemPickerLayout list = ListItemPickerLayout();

  /// A grid layout for item pickers (4 columns by default).
  static const GridItemPickerLayout grid = GridItemPickerLayout();

  /// Creates an [ItemPickerLayout].
  const ItemPickerLayout();

  /// Builds the widget for displaying items.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [items] (`ItemChildDelegate`, required): Delegate providing items.
  /// - [builder] (`ItemPickerBuilder`, required): Function to build each item.
  ///
  /// Returns: A widget displaying the items in this layout.
  Widget build(
      BuildContext context, ItemChildDelegate items, ItemPickerBuilder builder);
}

/// A list-based layout for item pickers.
///
/// Displays items in a vertical scrolling list using [ListView.builder].
///
/// Example:
/// ```dart
/// const ListItemPickerLayout()
/// ```
class ListItemPickerLayout extends ItemPickerLayout {
  /// Creates a [ListItemPickerLayout].
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

/// A grid-based layout for item pickers.
///
/// Displays items in a scrollable grid using [GridView.builder]. The number
/// of columns can be configured via [crossAxisCount].
///
/// Example:
/// ```dart
/// GridItemPickerLayout(crossAxisCount: 3)
/// ```
class GridItemPickerLayout extends ItemPickerLayout {
  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Creates a [GridItemPickerLayout].
  ///
  /// Parameters:
  /// - [crossAxisCount] (`int`, default: `4`): The number of grid columns.
  const GridItemPickerLayout({this.crossAxisCount = 4});

  /// Creates a copy of this layout with a different column count.
  ///
  /// Parameters:
  /// - [crossAxisCount] (`int`, default: `4`): The new column count.
  ///
  /// Returns: A new [GridItemPickerLayout] with the specified columns.
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

/// Shows an item picker in a popover overlay.
///
/// Displays a popover with items arranged according to the specified layout,
/// allowing the user to select one item. The popover closes when an item
/// is selected.
///
/// Parameters:
/// - [context] (`BuildContext`, required): The build context.
/// - [items] (`ItemChildDelegate<T>`, required): Delegate providing items.
/// - [builder] (`ItemPickerBuilder<T>`, required): Builds each item widget.
/// - [initialValue] (`T?`, optional): Initially selected item.
/// - [layout] (`ItemPickerLayout`, default: `GridItemPickerLayout()`): Layout strategy.
/// - [alignment] (`AlignmentGeometry?`, optional): Popover alignment.
/// - [anchorAlignment] (`AlignmentGeometry?`, optional): Anchor alignment.
/// - [constraints] (`BoxConstraints?`, optional): Size constraints for the popover.
/// - [offset] (`Offset?`, optional): Offset from anchor.
/// - [title] (`Widget?`, optional): Optional title widget.
///
/// Returns: A `Future<T?>` that completes with the selected item or null.
///
/// Example:
/// ```dart
/// final color = await showItemPicker<Color>(
///   context,
///   items: ItemList([Colors.red, Colors.green, Colors.blue]),
///   builder: (context, color) => ColorTile(color),
/// );
/// ```
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

/// Shows an item picker in a modal dialog.
///
/// Displays a modal dialog with items arranged according to the specified layout,
/// allowing the user to select one item. The dialog closes when an item is selected.
///
/// Parameters:
/// - [context] (`BuildContext`, required): The build context.
/// - [items] (`ItemChildDelegate<T>`, required): Delegate providing items.
/// - [builder] (`ItemPickerBuilder<T>`, required): Builds each item widget.
/// - [layout] (`ItemPickerLayout`, default: `GridItemPickerLayout()`): Layout strategy.
/// - [initialValue] (`T?`, optional): Initially selected item.
/// - [constraints] (`BoxConstraints?`, optional): Size constraints for the dialog.
/// - [title] (`Widget`, required): Dialog title widget.
///
/// Returns: A `Future<T?>` that completes with the selected item or null.
///
/// Example:
/// ```dart
/// final icon = await showItemPickerDialog<IconData>(
///   context,
///   title: Text('Choose Icon'),
///   items: ItemList([Icons.home, Icons.star, Icons.settings]),
///   builder: (context, icon) => Icon(icon),
/// );
/// ```
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

/// A dialog widget for picking an item from a list or grid.
///
/// Internally used by [showItemPicker] and [showItemPickerDialog] to display
/// items and handle selection. Manages the selected value state and notifies
/// listeners when the selection changes.
///
/// Example:
/// ```dart
/// ItemPickerDialog<Color>(
///   items: ItemList([Colors.red, Colors.green]),
///   builder: (context, color) => ColorTile(color),
///   layout: ItemPickerLayout.grid,
///   onChanged: (color) => print(color),
/// )
/// ```
class ItemPickerDialog<T> extends StatefulWidget {
  /// Delegate providing the items to display.
  final ItemChildDelegate<T> items;

  /// Builder function for rendering each item.
  final ItemPickerBuilder<T> builder;

  /// Layout strategy for displaying items.
  final ItemPickerLayout layout;

  /// Currently selected value.
  final T? value;

  /// Called when the selection changes.
  final ValueChanged<T?>? onChanged;

  /// Creates an [ItemPickerDialog].
  ///
  /// Parameters:
  /// - [items] (`ItemChildDelegate<T>`, required): Items to display.
  /// - [builder] (`ItemPickerBuilder<T>`, required): Item widget builder.
  /// - [layout] (`ItemPickerLayout`, default: `GridItemPickerLayout()`): Layout strategy.
  /// - [value] (`T?`, optional): Selected value.
  /// - [onChanged] (`ValueChanged<T?>?`, optional): Selection callback.
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

/// Data provided by [ItemPickerDialog] to its descendants.
///
/// Contains the current selection value, change callback, and layout strategy.
/// Used internally for coordinating state across the item picker tree.
class ItemPickerData {
  /// The currently selected value.
  final Object? value;

  /// Callback invoked when the selection changes.
  final ValueChanged<Object?>? onChanged;

  /// The layout strategy being used.
  final ItemPickerLayout layout;

  /// Creates an [ItemPickerData].
  ///
  /// Parameters:
  /// - [value] (`Object?`, optional): Current selection.
  /// - [onChanged] (`ValueChanged<Object?>?`, optional): Change callback.
  /// - [layout] (`ItemPickerLayout`, required): Layout strategy.
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

/// A selectable option within an item picker.
///
/// Wraps an item with selection behavior, applying different styles based on
/// whether it's currently selected. Commonly used inside [ItemPickerDialog]
/// to create selectable items.
///
/// Example:
/// ```dart
/// ItemPickerOption<Color>(
///   value: Colors.red,
///   child: Container(color: Colors.red, width: 50, height: 50),
/// )
/// ```
class ItemPickerOption<T> extends StatelessWidget {
  /// The value this option represents.
  final T value;

  /// Optional label widget displayed with the option.
  final Widget? label;

  /// The main child widget representing the option.
  final Widget child;

  /// Custom style for the option when not selected.
  final AbstractButtonStyle? style;

  /// Custom style for the option when selected.
  final AbstractButtonStyle? selectedStyle;

  /// Creates an [ItemPickerOption].
  ///
  /// Parameters:
  /// - [value] (`T`, required): The value this option represents.
  /// - [child] (`Widget`, required): The widget to display.
  /// - [style] (`AbstractButtonStyle?`, optional): Style when not selected.
  /// - [selectedStyle] (`AbstractButtonStyle?`, optional): Style when selected.
  /// - [label] (`Widget?`, optional): Optional label widget.
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
