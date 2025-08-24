import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Whether debug stickers should be visible when [debugPostSticker] is called.
/// 
/// Controls the global visibility of debug overlay stickers. When false,
/// calls to [debugPostSticker] will be ignored, providing a simple way to
/// disable all debug stickers without removing debug code.
/// 
/// This constant should typically be set to false in production builds
/// or when debug overlays interfere with normal application usage.
const kDebugStickerVisible = true;

/// Whether debug container borders should be visible when using [DebugContainer.debugContainer].
/// 
/// Controls the global visibility of debug container highlighting. When false,
/// the [debugContainer] extension method returns widgets unchanged, effectively
/// disabling debug container visualization.
/// 
/// This constant provides a simple way to disable debug container highlighting
/// across the entire application without removing debug code.
const kDebugContainerVisible = true;

/// Posts a temporary colored overlay sticker for debugging widget positioning.
/// 
/// Creates a temporary visual indicator that appears as a semi-transparent colored
/// rectangle with text overlay. The sticker automatically disappears after 2 seconds,
/// making it useful for debugging layout issues, hit testing, or widget positioning
/// without permanently affecting the UI.
/// 
/// The sticker is non-interactive (uses [IgnorePointer]) and appears above all
/// other content in the overlay. This function should only be used in debug
/// builds and will assert if called outside debug mode.
/// 
/// ## Use Cases
/// 
/// - Debugging widget positioning and bounds
/// - Visualizing layout calculations
/// - Identifying render object locations
/// - Testing overlay positioning
/// - Debugging gesture detection areas
/// 
/// ## Parameters
/// 
/// - [context] (BuildContext): Build context for accessing the overlay
/// - [rect] (Rect): Position and size of the sticker in global coordinates
/// - [color] (Color): Background color of the sticker overlay
/// - [text] (String): Text content to display on the sticker
/// 
/// ## Behavior
/// 
/// The sticker is automatically removed after 2 seconds. Multiple stickers can
/// be posted simultaneously and will overlap based on their [rect] positioning.
/// 
/// ## Safety
/// 
/// - Only available in debug mode (asserts in release mode)
/// - Controlled by [kDebugStickerVisible] constant
/// - Non-interactive overlay that won't interfere with app functionality
/// 
/// Example:
/// ```dart
/// void _debugShowWidgetBounds(RenderBox renderBox, BuildContext context) {
///   final bounds = renderBox.localToGlobal(Offset.zero) & renderBox.size;
///   debugPostSticker(context, bounds, Colors.red, 'Widget Bounds');
/// }
/// 
/// // Usage in build method for debugging
/// @override
/// Widget build(BuildContext context) {
///   WidgetsBinding.instance.addPostFrameCallback((_) {
///     final renderBox = context.findRenderObject() as RenderBox?;
///     if (renderBox != null) {
///       _debugShowWidgetBounds(renderBox, context);
///     }
///   });
///   
///   return MyWidget();
/// }
/// ```
void debugPostSticker(
    BuildContext context, Rect rect, Color color, String text) {
  if (!kDebugStickerVisible) {
    return;
  }
  assert(kDebugMode, 'debugPostSticker should only be called in debug mode');
  OverlayEntry entry = OverlayEntry(
    builder: (context) {
      return Positioned(
        left: rect.left,
        top: rect.top,
        width: rect.width,
        height: rect.height,
        child: IgnorePointer(
          child: Opacity(
            opacity: 0.2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
  Overlay.of(context).insert(entry);
  Timer(const Duration(seconds: 2), () {
    entry.remove();
  });
}

/// Extension methods for adding debug visualization to any widget.
/// 
/// DebugContainer provides convenient methods for adding visual debugging
/// aids to widgets during development. These methods help identify widget
/// boundaries, layout issues, and visual hierarchy problems.
/// 
/// The extension is designed to be easily added and removed from widget
/// trees without affecting production builds when controlled by the
/// [kDebugContainerVisible] constant.
/// 
/// Example:
/// ```dart
/// Widget build(BuildContext context) {
///   return Column(
///     children: [
///       Text('Debug me').debugContainer(Colors.blue),
///       Container(...).debugContainer(), // Uses default red color
///       Row(...).debugContainer(Colors.green),
///     ],
///   );
/// }
/// ```
extension DebugContainer on Widget {
  /// Wraps the widget with a colored container for debugging layout and positioning.
  /// 
  /// Creates a visual border around the widget using a colored [Container].
  /// This helps identify widget boundaries, debug layout issues, and understand
  /// the visual hierarchy during development.
  /// 
  /// The debug container is controlled by the [kDebugContainerVisible] constant.
  /// When false, this method returns the widget unchanged, allowing debug
  /// containers to be easily disabled across the entire application.
  /// 
  /// ## Parameters
  /// 
  /// - [color] (Color, default: Colors.red): Background color for the debug container
  /// 
  /// ## Usage Patterns
  /// 
  /// **Basic debugging**: Add a red border to see widget bounds
  /// ```dart
  /// Text('Debug me').debugContainer()
  /// ```
  /// 
  /// **Color coding**: Use different colors to identify different widget types
  /// ```dart
  /// // Color-code different types of widgets
  /// userInfo.debugContainer(Colors.blue),    // User widgets
  /// navBar.debugContainer(Colors.green),     // Navigation widgets
  /// content.debugContainer(Colors.orange),  // Content widgets
  /// ```
  /// 
  /// **Layout debugging**: Identify spacing and alignment issues
  /// ```dart
  /// Column(
  ///   children: widgets
  ///       .map((w) => w.debugContainer(Colors.purple))
  ///       .toList(),
  /// ).debugContainer(Colors.yellow) // Column container
  /// ```
  /// 
  /// ## Performance Notes
  /// 
  /// Debug containers add an extra [Container] widget to the tree, which has
  /// minimal performance impact but should be disabled in production builds
  /// by setting [kDebugContainerVisible] to false.
  /// 
  /// ## Production Safety
  /// 
  /// When [kDebugContainerVisible] is false, this method returns the widget
  /// unchanged, ensuring no debug artifacts appear in production builds.
  /// 
  /// Returns:
  /// - In debug mode with [kDebugContainerVisible] true: Widget wrapped in colored container
  /// - Otherwise: Original widget unchanged
  Widget debugContainer([Color color = Colors.red]) {
    if (!kDebugContainerVisible) {
      return this;
    }
    return Container(
      color: color,
      child: this,
    );
  }
}
