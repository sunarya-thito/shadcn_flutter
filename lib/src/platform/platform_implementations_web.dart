// must be a relative import
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import '../theme/theme.dart';

class ShadcnFlutterPlatformImplementations {
  void onAppInitialized() {
    if (globalContext.has("onAppReady")) {
      globalContext.callMethod("onAppReady".toJS);
    }
  }

  void onThemeChanged(ThemeData theme) {
    if (globalContext.has("onThemeChanged")) {
      globalContext.callMethod(
          "onThemeChanged".toJS, theme.colorScheme.toMap().toJSBox);
    }
  }
}
