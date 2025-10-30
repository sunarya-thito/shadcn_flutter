---
title: "Class: SelectPopup"
description: "A popup widget for displaying selectable items in a dropdown."
---

```dart
/// A popup widget for displaying selectable items in a dropdown.
///
/// Provides a searchable, scrollable list of items with various display modes.
class SelectPopup<T> extends StatefulWidget {
  /// Builder function for dynamically generating select items.
  final SelectItemsBuilder<T>? builder;
  /// Static list of select items to display.
  final FutureOr<SelectItemDelegate?>? items;
  /// Controller for the search input field.
  final TextEditingController? searchController;
  /// Placeholder widget for the search field.
  final Widget? searchPlaceholder;
  /// Builder for empty state display.
  final WidgetBuilder? emptyBuilder;
  /// Builder for loading state display.
  final WidgetBuilder? loadingBuilder;
  /// Builder for error state display.
  final ErrorWidgetBuilder? errorBuilder;
  /// Blur amount for the popup surface.
  final double? surfaceBlur;
  /// Opacity for the popup surface.
  final double? surfaceOpacity;
  /// Whether to auto-close the popup after selection.
  final bool? autoClose;
  /// Whether selected items can be unselected.
  final bool? canUnselect;
  /// Whether search functionality is enabled.
  final bool enableSearch;
  /// Controller for the items scroll view.
  final ScrollController? scrollController;
  /// Whether the list should shrink-wrap its contents.
  final bool shrinkWrap;
  /// Whether to disable item virtualization.
  final bool disableVirtualization;
  /// Creates a select popup with a dynamic builder.
  const SelectPopup.builder({super.key, required this.builder, this.searchController, this.searchPlaceholder, this.emptyBuilder, this.loadingBuilder, this.surfaceBlur, this.surfaceOpacity, this.autoClose, this.canUnselect, this.enableSearch = true, this.errorBuilder, this.scrollController});
  /// Creates a select popup with static items.
  const SelectPopup({super.key, this.items, this.searchController, this.searchPlaceholder, this.emptyBuilder, this.loadingBuilder, this.errorBuilder, this.surfaceBlur, this.surfaceOpacity, this.autoClose, this.canUnselect, this.scrollController, this.shrinkWrap = true});
  /// Creates a select popup without virtualization optimization.
  const SelectPopup.noVirtualization({super.key, FutureOr<SelectItemList?>? this.items, this.searchController, this.searchPlaceholder, this.emptyBuilder, this.loadingBuilder, this.errorBuilder, this.surfaceBlur, this.surfaceOpacity, this.autoClose, this.canUnselect, this.scrollController});
  /// A method used to implement SelectPopupBuilder
  SelectPopup<T> call(BuildContext context);
  State<SelectPopup<T>> createState();
}
```
