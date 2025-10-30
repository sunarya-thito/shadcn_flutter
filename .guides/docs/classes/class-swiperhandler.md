---
title: "Class: SwiperHandler"
description: "Abstract handler interface for swiper overlay implementations."
---

```dart
/// Abstract handler interface for swiper overlay implementations.
///
/// Defines the contract for creating different types of swiper overlays,
/// with built-in implementations for drawer-style and sheet-style swipers.
///
/// Features:
/// - Pluggable swiper behavior patterns
/// - Built-in drawer and sheet implementations  
/// - Consistent API across swiper types
/// - Configurable overlay properties
///
/// Example:
/// ```dart
/// // Use built-in handlers
/// const SwiperHandler.drawer
/// const SwiperHandler.sheet
/// ```
abstract class SwiperHandler {
  /// Handler for drawer-style swipers with backdrop transformation.
  static const SwiperHandler drawer = DrawerSwiperHandler();
  /// Handler for sheet-style swipers with minimal styling.
  static const SwiperHandler sheet = SheetSwiperHandler();
  /// Creates a swiper handler.
  const SwiperHandler();
  /// Creates a swiper overlay with the specified configuration.
  ///
  /// Parameters vary by implementation but commonly include position,
  /// builder, and visual/behavioral properties.
  ///
  /// Returns:
  /// A [DrawerOverlayCompleter] for managing the swiper lifecycle.
  DrawerOverlayCompleter openSwiper({required BuildContext context, required WidgetBuilder builder, required OverlayPosition position, bool? expands, bool? draggable, bool? barrierDismissible, WidgetBuilder? backdropBuilder, bool? useSafeArea, bool? showDragHandle, BorderRadiusGeometry? borderRadius, Size? dragHandleSize, bool? transformBackdrop, double? surfaceOpacity, double? surfaceBlur, Color? barrierColor});
}
```
