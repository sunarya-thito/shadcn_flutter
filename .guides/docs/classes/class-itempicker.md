---
title: "Class: ItemPicker"
description: "A widget for selecting items from a collection using various presentation modes."
---

```dart
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
  const ItemPicker({super.key, required this.items, required this.builder, this.value, this.onChanged, this.layout, this.placeholder, this.title, this.mode, this.constraints});
  Widget build(BuildContext context);
}
```
