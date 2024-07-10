library shadcn_flutter_independent;

import 'package:shadcn_flutter_platform_interface/shadcn_flutter_platform_interface.dart';

class FallbackPlatformImplementations extends AbstractPlatformImplementations {
  static void register() {
    AbstractPlatformImplementations.instance =
        FallbackPlatformImplementations();
  }

  @override
  void onAppInitialized() {
    // Do nothing
  }
}
