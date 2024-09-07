// must be a relative import
import 'dart:js_interop';

import 'package:shadcn_flutter/shadcn_flutter.dart';

@JS("Window")
extension type _Window(JSObject _) implements JSObject {
  // dispatchEvent method
  external void dispatchEvent(JSObject event);
}

@JS("Event")
extension type _Event._(JSObject _) implements JSObject {
  external _Event(String type);
}

@JS("window")
external _Window get _window;

@JS("ShadcnAppThemeChangedEvent")
extension type _ShadcnAppThemeChangedEvent._(JSObject _) implements JSObject {
  external _ShadcnAppThemeChangedEvent(_ShadcnAppTheme theme);
}

@JS("ShadcnAppTheme")
extension type _ShadcnAppTheme._(JSObject _) implements JSObject {
  external _ShadcnAppTheme(
      String background, String foreground, String primary);
}

class ShadcnFlutterPlatformImplementations {
  void onAppInitialized() {
    final event = _Event("shadcn_flutter_app_ready");
    _window.dispatchEvent(event);
  }

  void onThemeChanged(ThemeData theme) {
    final shadcnAppTheme = _ShadcnAppTheme(
      _colorToCssRgba(theme.colorScheme.background),
      _colorToCssRgba(theme.colorScheme.foreground),
      _colorToCssRgba(theme.colorScheme.primary),
    );
    final event = _ShadcnAppThemeChangedEvent(shadcnAppTheme);
    _window.dispatchEvent(event);
  }
}

String _colorToCssRgba(Color color) {
  return 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.opacity})';
}
