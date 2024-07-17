library shadcn_flutter_independent;

import 'package:shadcn_flutter_platform_interface/shadcn_flutter_platform_interface.dart';

class IndependentPlatformImplementations
    extends AbstractPlatformImplementations {
  static void registerWith() {
    AbstractPlatformImplementations.instance =
        IndependentPlatformImplementations();
  }

  @override
  void onAppInitialized() {
    // Do nothing
  }
}
