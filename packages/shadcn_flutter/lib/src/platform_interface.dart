import '../shadcn_flutter.dart';

/// Platform-specific implementations for shadcn_flutter.
///
/// This class provides a base interface for platform-specific functionality.
/// Platform-specific implementations should override these methods.
class ShadcnFlutterPlatformImplementations {
  /// Called when the app is initialized.
  ///
  /// Platform implementations can override this to perform initialization tasks.
  void onAppInitialized() {}

  /// Called when the theme changes.
  ///
  /// Platform implementations can override this to respond to theme changes.
  /// The [theme] parameter contains the new theme data.
  void onThemeChanged(ThemeData theme) {}
}
