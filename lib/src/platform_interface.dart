import '../shadcn_flutter.dart';

/// Platform-specific implementation interface for shadcn_flutter framework integration.
///
/// [ShadcnFlutterPlatformImplementations] defines the contract for platform-specific
/// behaviors and lifecycle hooks within the shadcn_flutter framework. Different
/// platforms can provide specialized implementations to handle platform-specific
/// requirements, native integrations, or performance optimizations.
///
/// ## Integration Points
///
/// The interface provides hooks for key framework lifecycle events:
/// - **Application initialization**: Setup platform-specific configurations
/// - **Theme changes**: React to application theme transitions
/// - **Future extensibility**: Additional platform hooks can be added as needed
///
/// ## Implementation Strategy
///
/// Platform implementations should extend this class and override relevant methods
/// to provide platform-specific functionality. The base implementation provides
/// no-op defaults, ensuring forward compatibility when new methods are added.
///
/// ## Use Cases
///
/// Platform implementations typically handle:
/// - Native system integration (status bars, navigation bars)
/// - Platform-specific accessibility features  
/// - Performance optimizations for different platforms
/// - Integration with platform-specific design systems
/// - Custom platform behaviors and interactions
///
/// Example implementation:
/// ```dart
/// class WebShadcnPlatform extends ShadcnFlutterPlatformImplementations {
///   @override
///   void onAppInitialized() {
///     // Setup web-specific configurations
///     html.document.title = 'My App';
///     setupWebAccessibility();
///   }
/// 
///   @override
///   void onThemeChanged(ThemeData theme) {
///     // Update web-specific theme elements
///     updateWebThemeColors(theme);
///     syncBrowserTheme(theme);
///   }
/// }
/// ```
class ShadcnFlutterPlatformImplementations {
  /// Called when the shadcn_flutter application completes initialization.
  ///
  /// This lifecycle hook is invoked after the framework has finished setting up
  /// core systems but before the first widget build. Platform implementations
  /// can use this opportunity to:
  ///
  /// - Configure platform-specific settings
  /// - Initialize native system integrations
  /// - Set up accessibility features
  /// - Register platform-specific services
  /// - Prepare performance monitoring
  ///
  /// The base implementation is a no-op, allowing platforms to selectively
  /// override only the methods they need.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onAppInitialized() {
  ///   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  ///   configureAccessibility();
  ///   initializeAnalytics();
  /// }
  /// ```
  void onAppInitialized() {
    // Base implementation provides no platform-specific behavior
  }

  /// Called when the application theme changes.
  ///
  /// This method is invoked whenever the application's [ThemeData] is updated,
  /// allowing platform implementations to synchronize platform-specific UI
  /// elements with the new theme. Common use cases include:
  ///
  /// - Updating system status bar colors
  /// - Synchronizing browser theme colors (web)
  /// - Adjusting platform navigation elements
  /// - Updating accessibility contrast settings
  /// - Notifying native components of theme changes
  ///
  /// The [theme] parameter contains the new theme data that has been applied
  /// to the application.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onThemeChanged(ThemeData theme) {
  ///   final isDark = theme.brightness == Brightness.dark;
  ///   SystemChrome.setSystemUIOverlayStyle(
  ///     SystemUiOverlayStyle(
  ///       statusBarColor: Colors.transparent,
  ///       statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
  ///     ),
  ///   );
  /// }
  /// ```
  void onThemeChanged(ThemeData theme) {
    // Base implementation provides no platform-specific behavior
  }
}
