---
title: "Class: SelectPopup"
description: "Reference for SelectPopup"
---

```dart
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
  const SelectPopup.builder({super.key, required this.builder, this.searchController, this.searchPlaceholder, this.emptyBuilder, this.loadingBuilder, this.surfaceBlur, this.surfaceOpacity, this.autoClose, this.canUnselect, this.enableSearch = true, this.errorBuilder, this.scrollController});
  const SelectPopup({super.key, this.items, this.searchController, this.searchPlaceholder, this.emptyBuilder, this.loadingBuilder, this.errorBuilder, this.surfaceBlur, this.surfaceOpacity, this.autoClose, this.canUnselect, this.scrollController, this.shrinkWrap = true});
  const SelectPopup.noVirtualization({super.key, FutureOr<SelectItemList?>? this.items, this.searchController, this.searchPlaceholder, this.emptyBuilder, this.loadingBuilder, this.errorBuilder, this.surfaceBlur, this.surfaceOpacity, this.autoClose, this.canUnselect, this.scrollController});
  /// A method used to implement SelectPopupBuilder
  SelectPopup<T> call(BuildContext context);
  State<SelectPopup<T>> createState();
}
```
