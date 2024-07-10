import 'package:shadcn_flutter_platform_interface/shadcn_flutter_platform_interface.dart';

class PlatformImplementations extends AbstractPlatformImplementations {
  static void register() {
    AbstractPlatformImplementations.instance = PlatformImplementations();
  }

  @override
  void onAppInitialized() {}
}
