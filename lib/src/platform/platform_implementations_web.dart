// must be a relative import
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import '../theme/theme.dart';

class ShadcnFlutterPlatformImplementations {
  void onAppInitialized() {
    globalContext.callMethod("onAppReady".toJS);
  }

  void onThemeChanged(ThemeData theme) {
    globalContext.callMethod(
        "onThemeChanged".toJS, theme.colorScheme.toMap().toJSBox);
  }
}
