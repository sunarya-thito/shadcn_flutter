library shadcn_flutter_platform_interface;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fallback.dart';

abstract class AbstractPlatformImplementations extends PlatformInterface {
  static final Object _token = Object();
  AbstractPlatformImplementations() : super(token: _token);

  static AbstractPlatformImplementations get instance => _instance;

  static set instance(AbstractPlatformImplementations instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  static AbstractPlatformImplementations _instance =
      FallbackPlatformImplementations();

  void onAppInitialized();
}
