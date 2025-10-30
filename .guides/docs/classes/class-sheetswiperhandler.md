---
title: "Class: SheetSwiperHandler"
description: "Sheet-style swiper handler with minimal styling."
---

```dart
/// Sheet-style swiper handler with minimal styling.
///
/// Creates swipers that behave like sheets with edge-to-edge content,
/// minimal decoration, and optional drag interaction.
///
/// Example:
/// ```dart
/// Swiper(
///   handler: SwiperHandler.sheet,
///   position: OverlayPosition.bottom,
///   builder: (context) => BottomSheetContent(),
///   child: ActionButton(),
/// )
/// ```
class SheetSwiperHandler extends SwiperHandler {
  /// Creates a sheet-style swiper handler.
  const SheetSwiperHandler();
  DrawerOverlayCompleter openSwiper({required BuildContext context, required WidgetBuilder builder, required OverlayPosition position, bool? expands, bool? draggable, bool? barrierDismissible, WidgetBuilder? backdropBuilder, bool? useSafeArea, bool? showDragHandle, BorderRadiusGeometry? borderRadius, Size? dragHandleSize, bool? transformBackdrop, double? surfaceOpacity, double? surfaceBlur, Color? barrierColor});
}
```
