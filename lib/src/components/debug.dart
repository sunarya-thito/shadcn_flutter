import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

const kDebugStickerVisible = true;
const kDebugContainerVisible = true;

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

extension DebugContainer on Widget {
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
