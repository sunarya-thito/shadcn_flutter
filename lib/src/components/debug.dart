import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Whether debug stickers are visible in the UI.
const kDebugStickerVisible = true;

/// Whether debug containers are visible in the UI.
const kDebugContainerVisible = true;

/// Posts a temporary debug sticker overlay at the specified position.
///
/// Displays a semi-transparent colored box with text at the given [rect] position
/// for 2 seconds, useful for debugging layout and positioning issues.
/// Only active in debug mode when [kDebugStickerVisible] is true.
///
/// Parameters:
/// - [context]: The build context for the overlay.
/// - [rect]: The position and size of the sticker.
/// - [color]: The background color of the sticker.
/// - [text]: The text to display in the sticker.
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

/// Extension that adds debug container wrapping functionality to widgets.
///
/// Provides a [debugContainer] method to wrap widgets with a colored container
/// for debugging layout issues. Only active when [kDebugContainerVisible] is true.
extension DebugContainer on Widget {
  /// Wraps this widget with a colored debug container.
  ///
  /// The container uses the specified [color] (defaults to red) to highlight
  /// the widget's bounds, making it easier to visualize layout during development.
  /// Returns the original widget unchanged if [kDebugContainerVisible] is false.
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
