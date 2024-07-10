library shadcn_flutter_web;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shadcn_flutter_platform_interface/shadcn_flutter_platform_interface.dart';

class WebPlatformImplementations extends AbstractPlatformImplementations {
  static void registerWith(Registrar? registrar) {
    AbstractPlatformImplementations.instance = WebPlatformImplementations();
  }

  @override
  void onAppInitialized() {
    globalContext.callMethod("onAppReady".toJS);
  }
}
