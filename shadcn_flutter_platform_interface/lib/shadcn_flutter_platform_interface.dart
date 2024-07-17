library shadcn_flutter_platform_interface;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AbstractPlatformImplementations extends PlatformInterface {
  static final Object _token = Object();
  AbstractPlatformImplementations() : super(token: _token);

  static AbstractPlatformImplementations get instance {
    assert(
        _instance != null,
        'PlatformImplementations.instance has not been set yet. '
        'Please make sure you have called PlatformImplementations.register()');
    return _instance!;
  }

  static set instance(AbstractPlatformImplementations instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  static AbstractPlatformImplementations? _instance;

  void onAppInitialized();
}
