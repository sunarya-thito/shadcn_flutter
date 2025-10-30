---
title: "Class: DrawerSwiperHandler"
description: "Drawer-style swiper handler with backdrop transformation."
---

```dart
/// Drawer-style swiper handler with backdrop transformation.
///
/// Creates swipers that behave like drawers with backdrop scaling,
/// drag handles, and full interaction support.
///
/// Example:
/// ```dart
/// Swiper(
///   handler: SwiperHandler.drawer,
///   position: OverlayPosition.left,
///   builder: (context) => DrawerContent(),
///   child: MenuButton(),
/// )
/// ```
class DrawerSwiperHandler extends SwiperHandler {
  /// Creates a drawer-style swiper handler.
  const DrawerSwiperHandler();
  DrawerOverlayCompleter openSwiper({required BuildContext context, required WidgetBuilder builder, required OverlayPosition position, bool? expands, bool? draggable, bool? barrierDismissible, WidgetBuilder? backdropBuilder, bool? useSafeArea, bool? showDragHandle, BorderRadiusGeometry? borderRadius, Size? dragHandleSize, bool? transformBackdrop, double? surfaceOpacity, double? surfaceBlur, Color? barrierColor});
}
```
