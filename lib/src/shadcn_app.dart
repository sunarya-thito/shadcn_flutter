import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'platform_interface.dart'
    if (dart.library.js_interop) 'platform/platform_implementations_web.dart';

/// The main application widget for shadcn_flutter apps.
///
/// [ShadcnApp] is the root widget for applications built with the shadcn_flutter
/// framework. It provides comprehensive configuration for theming, navigation,
/// internationalization, and framework-specific features like color management,
/// scroll interception, and overlay handling.
///
/// The app supports both traditional route-based navigation and modern declarative
/// routing through Flutter's Router API. It integrates shadcn_flutter theming
/// with Material and Cupertino themes for seamless cross-platform development.
///
/// ## Features
///
/// - **Multi-theme support**: Light/dark theme switching with smooth animations
/// - **Color management**: Recent colors tracking for color pickers
/// - **Enhanced scrolling**: Desktop-optimized scroll interception
/// - **Overlay management**: Integrated popover, tooltip, and menu handling
/// - **Pixel snapping**: Crisp rendering on all screen densities
/// - **Adaptive scaling**: Responsive scaling based on platform and user preferences
///
/// Example usage:
/// ```dart
/// ShadcnApp(
///   title: 'My App',
///   theme: ThemeData.light(),
///   darkTheme: ThemeData.dark(),
///   themeMode: ThemeMode.system,
///   home: const HomeScreen(),
///   enableThemeAnimation: true,
/// )
/// ```
class ShadcnApp extends StatefulWidget {
  /// Creates a [ShadcnApp] with traditional route-based navigation.
  ///
  /// This constructor provides the classic navigation approach using named routes
  /// and route generators, similar to MaterialApp but with shadcn_flutter enhancements.
  ///
  /// Parameters:
  /// - [key]: Optional widget key for the app widget
  /// - [navigatorKey]: Global key for accessing the navigator state
  /// - [home]: The default widget displayed when the app starts
  /// - [routes]: Map of named routes to their respective builders
  /// - [initialRoute]: Name of the initial route to display
  /// - [onGenerateRoute]: Function to generate routes dynamically
  /// - [onGenerateInitialRoutes]: Function to generate initial route stack
  /// - [onUnknownRoute]: Fallback for unrecognized route names
  /// - [onNavigationNotification]: Listener for navigation events
  /// - [navigatorObservers]: List of observers for navigation changes
  /// - [builder]: Custom builder for the app's main widget tree
  /// - [title]: Application title shown in system UI
  /// - [onGenerateTitle]: Function to generate localized titles
  /// - [color]: Primary color for system UI elements
  /// - [background]: Background color for the app
  /// - [theme]: Required shadcn_flutter theme configuration
  /// - [darkTheme]: Optional dark theme configuration
  /// - [themeMode]: Controls light/dark theme selection
  /// - [locale]: Locale for the app (overrides system locale)
  /// - [localizationsDelegates]: Delegates for app localization
  /// - [localeListResolutionCallback]: Custom locale list resolution
  /// - [localeResolutionCallback]: Custom locale resolution
  /// - [supportedLocales]: List of supported app locales
  /// - [debugShowMaterialGrid]: Shows Material Design baseline grid
  /// - [showPerformanceOverlay]: Displays performance metrics overlay
  /// - [showSemanticsDebugger]: Shows accessibility information
  /// - [debugShowCheckedModeBanner]: Shows debug mode banner
  /// - [shortcuts]: Global keyboard shortcuts for the app
  /// - [actions]: Global intent actions for the app
  /// - [restorationScopeId]: State restoration identifier
  /// - [scrollBehavior]: Custom scroll behavior configuration
  /// - [materialTheme]: Material theme for Material widgets
  /// - [cupertinoTheme]: Cupertino theme for iOS-style widgets
  /// - [scaling]: Adaptive scaling configuration for responsive design
  /// - [disableBrowserContextMenu]: Disables right-click context menu on web
  /// - [initialRecentColors]: Initial list of recent colors for color pickers
  /// - [maxRecentColors]: Maximum number of recent colors to remember
  /// - [onRecentColorsChanged]: Callback when recent colors list changes
  /// - [pixelSnap]: Enables pixel-perfect rendering for crisp visuals
  /// - [enableScrollInterception]: Enables enhanced desktop scroll behavior
  /// - [popoverHandler]: Custom handler for popover overlays
  /// - [tooltipHandler]: Custom handler for tooltip overlays  
  /// - [menuHandler]: Custom handler for menu overlays
  /// - [enableThemeAnimation]: Enables smooth animations during theme changes
  const ShadcnApp({
    super.key,
    this.navigatorKey,
    this.home,
    this.routes = const {},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    this.navigatorObservers = const [],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.background,
    required this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.materialTheme,
    this.cupertinoTheme,
    this.scaling,
    this.disableBrowserContextMenu = true,
    this.initialRecentColors = const [],
    this.maxRecentColors = 10,
    this.onRecentColorsChanged,
    this.pixelSnap = true,
    this.enableScrollInterception = true,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.popoverHandler,
    this.tooltipHandler,
    this.menuHandler,
    this.enableThemeAnimation = true,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null;

  /// Creates a [ShadcnApp] with modern declarative routing using Flutter's Router API.
  ///
  /// This constructor enables advanced routing features like URL synchronization,
  /// browser history support, and deep linking through Flutter's Router API.
  ///
  /// Parameters:
  /// - [key]: Optional widget key for the app widget
  /// - [routeInformationProvider]: Provides route information from the platform
  /// - [routeInformationParser]: Parses route information into app-specific objects
  /// - [routerDelegate]: Manages the router's widget stack and state
  /// - [routerConfig]: Complete router configuration (alternative to individual components)
  /// - [backButtonDispatcher]: Handles system back button behavior
  /// - [builder]: Custom builder for the app's main widget tree
  /// - [title]: Application title shown in system UI
  /// - [onGenerateTitle]: Function to generate localized titles
  /// - [onNavigationNotification]: Listener for navigation events
  /// - [color]: Primary color for system UI elements
  /// - [background]: Background color for the app
  /// - [theme]: Required shadcn_flutter theme configuration
  /// - [darkTheme]: Optional dark theme configuration
  /// - [themeMode]: Controls light/dark theme selection
  /// - [locale]: Locale for the app (overrides system locale)
  /// - [localizationsDelegates]: Delegates for app localization
  /// - [localeListResolutionCallback]: Custom locale list resolution
  /// - [localeResolutionCallback]: Custom locale resolution
  /// - [supportedLocales]: List of supported app locales
  /// - [debugShowMaterialGrid]: Shows Material Design baseline grid
  /// - [showPerformanceOverlay]: Displays performance metrics overlay
  /// - [showSemanticsDebugger]: Shows accessibility information
  /// - [debugShowCheckedModeBanner]: Shows debug mode banner
  /// - [shortcuts]: Global keyboard shortcuts for the app
  /// - [actions]: Global intent actions for the app
  /// - [restorationScopeId]: State restoration identifier
  /// - [scrollBehavior]: Custom scroll behavior configuration
  /// - [materialTheme]: Material theme for Material widgets
  /// - [cupertinoTheme]: Cupertino theme for iOS-style widgets
  /// - [scaling]: Adaptive scaling configuration for responsive design
  /// - [disableBrowserContextMenu]: Disables right-click context menu on web
  /// - [initialRecentColors]: Initial list of recent colors for color pickers
  /// - [maxRecentColors]: Maximum number of recent colors to remember (default 50)
  /// - [onRecentColorsChanged]: Callback when recent colors list changes
  /// - [pixelSnap]: Enables pixel-perfect rendering for crisp visuals
  /// - [enableScrollInterception]: Enables enhanced desktop scroll behavior (default false)
  /// - [popoverHandler]: Custom handler for popover overlays
  /// - [tooltipHandler]: Custom handler for tooltip overlays
  /// - [menuHandler]: Custom handler for menu overlays
  /// - [enableThemeAnimation]: Enables smooth animations during theme changes
  const ShadcnApp.router({
    super.key,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.onNavigationNotification,
    this.color,
    this.background,
    required this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.materialTheme,
    this.cupertinoTheme,
    this.scaling,
    this.disableBrowserContextMenu = true,
    this.initialRecentColors = const [],
    this.maxRecentColors = 50,
    this.onRecentColorsChanged,
    this.pixelSnap = true,
    this.enableScrollInterception = false,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.popoverHandler,
    this.tooltipHandler,
    this.menuHandler,
    this.enableThemeAnimation = true,
  })  : assert(routerDelegate != null || routerConfig != null),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null;

  /// Global key for accessing the navigator state programmatically.
  ///
  /// Used in traditional navigation mode to control navigation imperatively,
  /// such as pushing routes or showing dialogs from outside the widget tree.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Configuration for adaptive UI scaling based on platform and user preferences.
  ///
  /// Enables responsive design that adapts to different screen sizes, pixel
  /// densities, and accessibility settings across platforms.
  final AdaptiveScaling? scaling;

  /// The default widget to display when the app starts.
  ///
  /// Only used in traditional navigation mode. If provided, this widget
  /// becomes the root of the navigation stack.
  final Widget? home;

  /// Map of named routes to their respective widget builders.
  ///
  /// Only used in traditional navigation mode. Provides static routing
  /// configuration for known routes in the application.
  final Map<String, WidgetBuilder>? routes;

  /// The name of the initial route to display when the app starts.
  ///
  /// Only used in traditional navigation mode. Must correspond to a key
  /// in the [routes] map or be handled by [onGenerateRoute].
  final String? initialRoute;

  /// Function to generate routes dynamically based on route settings.
  ///
  /// Only used in traditional navigation mode. Called when a named route
  /// is requested but not found in the static [routes] map.
  final RouteFactory? onGenerateRoute;

  /// Function to generate the initial route stack when the app starts.
  ///
  /// Only used in traditional navigation mode. Allows customization of
  /// the initial navigation stack beyond a single route.
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// Fallback route generator for unrecognized route names.
  ///
  /// Only used in traditional navigation mode. Called when both [routes]
  /// and [onGenerateRoute] fail to handle a route request.
  final RouteFactory? onUnknownRoute;

  /// Callback invoked when navigation events occur in the app.
  ///
  /// Receives [NavigationNotification] events that bubble up from
  /// navigation actions throughout the widget tree.
  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

  /// List of observers that monitor navigation changes.
  ///
  /// Only used in traditional navigation mode. Observers receive callbacks
  /// for route push, pop, replace, and other navigation events.
  final List<NavigatorObserver>? navigatorObservers;

  /// Provider for route information from the platform.
  ///
  /// Only used in router mode. Typically handles URL changes from the
  /// browser or deep links from the operating system.
  final RouteInformationProvider? routeInformationProvider;

  /// Parser that converts route information into app-specific objects.
  ///
  /// Only used in router mode. Converts URL strings or platform route
  /// information into typed route configurations.
  final RouteInformationParser<Object>? routeInformationParser;

  /// Delegate that builds the widget tree for the current route state.
  ///
  /// Only used in router mode. Manages the navigation stack and responds
  /// to route configuration changes from the parser.
  final RouterDelegate<Object>? routerDelegate;

  /// Handler for platform back button behavior.
  ///
  /// Only used in router mode. Customizes how system back button presses
  /// are handled by the router.
  final BackButtonDispatcher? backButtonDispatcher;

  /// Complete router configuration object.
  ///
  /// Only used in router mode. Alternative to providing individual router
  /// components, encapsulating all routing behavior in a single object.
  final RouterConfig<Object>? routerConfig;

  /// Custom builder that wraps the main application widget tree.
  ///
  /// Receives the built navigator and can wrap it with additional widgets
  /// like providers, inherited widgets, or global overlays.
  final TransitionBuilder? builder;

  /// The title of the application shown in the operating system UI.
  ///
  /// Appears in window titles, task switchers, and accessibility tools.
  /// Can be overridden with [onGenerateTitle] for localization.
  final String title;

  /// Function to generate localized application titles.
  ///
  /// Called with the current locale context to provide translated
  /// application titles based on the active localization.
  final GenerateAppTitle? onGenerateTitle;

  /// The primary shadcn_flutter theme configuration for the application.
  ///
  /// Defines colors, typography, spacing, and component styling for
  /// the entire app. Required parameter that forms the foundation
  /// of the app's visual design.
  final ThemeData theme;
  
  /// Optional dark theme configuration for the application.
  ///
  /// When provided, the app can switch between light and dark themes
  /// based on the [themeMode] setting and system preferences.
  final ThemeData? darkTheme;
  
  /// Controls when to use light or dark theme variants.
  ///
  /// Can be set to always light, always dark, or follow system settings.
  /// Works in conjunction with [theme] and [darkTheme] configurations.
  final ThemeMode themeMode;
  
  /// Primary color hint for the operating system UI.
  ///
  /// Used by the platform to style system UI elements like status bars
  /// and navigation bars to complement the application's design.
  final Color? color;
  
  /// Background color for the application window.
  ///
  /// Sets the default background color for the entire application. When null,
  /// uses the theme's surface color or system default.
  final Color? background;
  
  /// Locale configuration for the application.
  ///
  /// When specified, overrides the system locale. When null, the app
  /// uses the system locale or the first supported locale.
  final Locale? locale;

  /// Localization delegates for internationalization support.
  ///
  /// Provides localized strings, date formatting, and other locale-specific
  /// resources. Include framework localization delegates as needed.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  
  /// Callback for resolving locale from a list of system locales.
  ///
  /// Called when the system provides multiple preferred locales. Should
  /// return the best matching locale from [supportedLocales].
  final LocaleListResolutionCallback? localeListResolutionCallback;
  
  /// Callback for resolving a single locale from system preferences.
  ///
  /// Called when the system provides a single preferred locale. Should
  /// return the best matching locale from [supportedLocales].
  final LocaleResolutionCallback? localeResolutionCallback;
  
  /// List of locales supported by the application.
  ///
  /// Used by locale resolution callbacks to determine the best locale
  /// match. Defaults to English (US) if not specified.
  final Iterable<Locale> supportedLocales;
  
  /// Whether to display Flutter's performance overlay.
  ///
  /// Shows frame timing information, including rasterization and UI thread
  /// performance. Useful for identifying performance bottlenecks.
  final bool showPerformanceOverlay;
  
  /// Whether to display Flutter's semantics debugger.
  ///
  /// Shows accessibility information like semantic labels, actions, and
  /// tree structure. Helps debug accessibility implementations.
  final bool showSemanticsDebugger;
  
  /// Whether to show the debug mode banner in debug builds.
  ///
  /// The banner appears in the top-right corner to indicate debug mode.
  /// Set to false to hide the banner in development.
  final bool debugShowCheckedModeBanner;
  
  /// Global keyboard shortcuts available throughout the application.
  ///
  /// Maps shortcut key combinations to Intent objects that trigger actions.
  /// These shortcuts work regardless of the current focus.
  final Map<ShortcutActivator, Intent>? shortcuts;
  
  /// Global actions that can be triggered by shortcuts or other means.
  ///
  /// Maps Intent types to Action objects that handle the actual behavior.
  /// Used in conjunction with [shortcuts] for keyboard handling.
  final Map<Type, Action<Intent>>? actions;
  
  /// Unique identifier for state restoration.
  ///
  /// Used by Flutter's state restoration system to save and restore app
  /// state across app launches. Should be unique per app.
  final String? restorationScopeId;
  
  /// Custom scroll behavior for scrollable widgets in the app.
  ///
  /// Defines platform-specific scrolling physics, scrollbar appearance,
  /// and overscroll indicators. When null, uses ShadcnScrollBehavior.
  final ScrollBehavior? scrollBehavior;
  
  /// Whether to display Material Design's baseline grid overlay.
  ///
  /// Shows the 4dp baseline grid used in Material Design for alignment.
  /// Useful for ensuring proper spacing and alignment in development.
  final bool debugShowMaterialGrid;
  
  /// Material theme configuration for Material widgets.
  ///
  /// Applied to Material widgets like buttons, text fields, and dialogs
  /// when they appear within the app. Complements shadcn_flutter theming.
  final m.ThemeData? materialTheme;
  
  /// Cupertino theme configuration for iOS-style widgets.
  ///
  /// Applied to Cupertino widgets when they appear within the app.
  /// Provides iOS-style theming alongside shadcn_flutter components.
  final c.CupertinoThemeData? cupertinoTheme;
  
  /// Whether to disable the browser's context menu on web platforms.
  ///
  /// When true, prevents the default right-click context menu from appearing
  /// in web browsers. Useful for custom context menu implementations.
  final bool disableBrowserContextMenu;
  
  /// Initial list of recently used colors for color picker components.
  ///
  /// These colors appear in color picker interfaces as quick selection options.
  /// The list is maintained automatically as users select colors.
  final List<Color> initialRecentColors;
  
  /// Maximum number of recent colors to remember.
  ///
  /// When the recent colors list exceeds this limit, older colors are
  /// removed automatically. Defaults to 10.
  final int maxRecentColors;
  
  /// Callback invoked when the recent colors list changes.
  ///
  /// Called whenever users select new colors or the recent colors list
  /// is modified. Use this to persist recent colors across app sessions.
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  
  /// Whether to enable pixel-perfect rendering for crisp visuals.
  ///
  /// When true, widget positioning and sizing is snapped to physical pixels
  /// to avoid sub-pixel rendering blur. Recommended for crisp UI appearance.
  final bool pixelSnap;
  
  /// Whether to enable enhanced desktop scroll behavior.
  ///
  /// When true, activates desktop-optimized scrolling features like
  /// scroll wheel interception and enhanced scroll physics.
  final bool enableScrollInterception;
  
  /// Custom handler for popover overlays.
  ///
  /// Allows customization of popover display behavior, positioning,
  /// and lifecycle. When null, uses the default popover implementation.
  final OverlayHandler? popoverHandler;
  
  /// Custom handler for tooltip overlays.
  ///
  /// Allows customization of tooltip display behavior, positioning,
  /// and timing. When null, uses the default tooltip implementation.
  final OverlayHandler? tooltipHandler;
  
  /// Custom handler for menu overlays.
  ///
  /// Allows customization of context menu and dropdown menu display
  /// behavior. When null, uses the default menu implementation.
  final OverlayHandler? menuHandler;
  
  /// Whether to enable smooth animations during theme changes.
  ///
  /// When true, provides animated transitions when switching between
  /// light and dark themes or other theme changes.
  final bool enableThemeAnimation;

  @override
  State<ShadcnApp> createState() => _ShadcnAppState();
}

/// Custom scroll behavior implementation for shadcn_flutter applications.
///
/// [ShadcnScrollBehavior] provides platform-appropriate scrolling physics and
/// visual feedback optimized for the shadcn_flutter design system. It implements
/// bouncing scroll physics across all platforms and provides platform-specific
/// scrollbar and overscroll indicator styling.
///
/// ## Platform Adaptations
///
/// **Desktop platforms** (Linux, macOS, Windows):
/// - Shows scrollbars for vertical scrolling
/// - No overscroll indicators (clean desktop experience)
///
/// **Mobile platforms** (Android, iOS):
/// - No scrollbars (touch-first interface)
/// - Platform-appropriate overscroll indicators
///
/// ## Physics and Feedback
///
/// - **Bouncing physics**: Provides elastic scroll behavior across all platforms
/// - **Stretching overscroll**: Android-style stretching indication
/// - **Glowing overscroll**: Fallback glow effect for other platforms
/// - **Theme integration**: Overscroll colors match the application theme
///
/// This behavior is automatically applied to all scrollable widgets within
/// [ShadcnApp] unless overridden by custom scroll behavior configuration.
class ShadcnScrollBehavior extends ScrollBehavior {
  const ShadcnScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    // When modifying this function, consider modifying the implementation in
    // the base class ScrollBehavior as well.
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        switch (getPlatform(context)) {
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            return Scrollbar(
              controller: details.controller,
              child: child,
            );
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.iOS:
            return child;
        }
    }
  }

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    // When modifying this function, consider modifying the implementation in
    // the base class ScrollBehavior as well.
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        return StretchingOverscrollIndicator(
          axisDirection: details.direction,
          clipBehavior: details.decorationClipBehavior ?? Clip.hardEdge,
          child: child,
        );
      case TargetPlatform.fuchsia:
        break;
    }
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Theme.of(context).colorScheme.secondary,
      child: child,
    );
  }
}

class _ShadcnAppState extends State<ShadcnApp> {
  final ShadcnFlutterPlatformImplementations _platform =
      ShadcnFlutterPlatformImplementations();
  late HeroController _heroController;

  void _dispatchAppInitialized() {
    _platform.onAppInitialized();
  }

  bool get _usesRouter =>
      widget.routerDelegate != null || widget.routerConfig != null;

  @override
  void initState() {
    super.initState();
    _platform.onThemeChanged(widget.theme);
    // _heroController = ShadcnApp.createMaterialHeroController();
    _heroController = HeroController(
      createRectTween: (begin, end) {
        return ShadcnRectArcTween(begin: begin, end: end);
      },
    );
    // Future.delayed(const Duration(milliseconds: 10), _dispatchAppInitialized);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dispatchAppInitialized();
    });
    if (kIsWeb) {
      if (widget.disableBrowserContextMenu) {
        BrowserContextMenu.disableContextMenu();
      } else {
        BrowserContextMenu.enableContextMenu();
      }
    }
  }

  @override
  void didUpdateWidget(covariant ShadcnApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kIsWeb &&
        widget.disableBrowserContextMenu !=
            oldWidget.disableBrowserContextMenu) {
      if (widget.disableBrowserContextMenu) {
        BrowserContextMenu.disableContextMenu();
      } else {
        BrowserContextMenu.enableContextMenu();
      }
    }
    if (widget.theme != oldWidget.theme) {
      _platform.onThemeChanged(widget.theme);
    }
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates {
    return <LocalizationsDelegate<dynamic>>[
      if (widget.localizationsDelegates != null)
        ...widget.localizationsDelegates!,
      m.DefaultMaterialLocalizations.delegate,
      c.DefaultCupertinoLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
      ShadcnLocalizationsDelegate.delegate,
    ];
  }

  Widget _builder(BuildContext context, Widget? child) {
    return ShadcnLayer(
      theme: widget.theme,
      scaling: widget.scaling,
      initialRecentColors: widget.initialRecentColors,
      maxRecentColors: widget.maxRecentColors,
      onRecentColorsChanged: widget.onRecentColorsChanged,
      builder: widget.builder,
      enableScrollInterception: widget.enableScrollInterception,
      darkTheme: widget.darkTheme,
      popoverHandler: widget.popoverHandler,
      tooltipHandler: widget.tooltipHandler,
      menuHandler: widget.menuHandler,
      themeMode: widget.themeMode,
      enableThemeAnimation: widget.enableThemeAnimation,
      child: child,
    );
  }

  Widget _buildWidgetApp(BuildContext context) {
    final Color primaryColor = widget.color ?? widget.theme.colorScheme.primary;
    if (_usesRouter) {
      return WidgetsApp.router(
        key: GlobalObjectKey(this),
        routeInformationProvider: widget.routeInformationProvider,
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        routerConfig: widget.routerConfig,
        backButtonDispatcher: widget.backButtonDispatcher,
        builder: _builder,
        title: widget.title,
        onGenerateTitle: widget.onGenerateTitle,
        textStyle: widget.theme.typography.sans.copyWith(
          color: widget.theme.colorScheme.foreground,
        ),
        color: primaryColor,
        locale: widget.locale,
        localizationsDelegates: _localizationsDelegates,
        localeResolutionCallback: widget.localeResolutionCallback,
        localeListResolutionCallback: widget.localeListResolutionCallback,
        supportedLocales: widget.supportedLocales,
        showPerformanceOverlay: widget.showPerformanceOverlay,
        // checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
        // checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
        showSemanticsDebugger: widget.showSemanticsDebugger,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        restorationScopeId: widget.restorationScopeId,
      );
    }

    return WidgetsApp(
      key: GlobalObjectKey(this),
      navigatorKey: widget.navigatorKey,
      navigatorObservers: widget.navigatorObservers!,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return MaterialPageRoute<T>(settings: settings, builder: builder);
      },
      home: widget.home,
      routes: widget.routes!,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
      onUnknownRoute: widget.onUnknownRoute,
      onNavigationNotification: widget.onNavigationNotification,
      builder: _builder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      textStyle: widget.theme.typography.sans.copyWith(
        color: widget.theme.colorScheme.foreground,
      ),
      color: primaryColor,
      locale: widget.locale,
      localizationsDelegates: _localizationsDelegates,
      localeResolutionCallback: widget.localeResolutionCallback,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      supportedLocales: widget.supportedLocales,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget result = _buildWidgetApp(context);
    assert(() {
      if (widget.debugShowMaterialGrid) {
        result = GridPaper(
          color: const Color(0xE0F9BBE0),
          interval: 8.0,
          subdivisions: 1,
          child: result,
        );
      }
      return true;
    }());
    return m.Theme(
      data: widget.materialTheme ??
          m.ThemeData.from(
            colorScheme: m.ColorScheme.fromSeed(
              seedColor: widget.theme.colorScheme.primary,
              brightness: widget.theme.brightness,
              surface: widget.theme.colorScheme.background,
              primary: widget.theme.colorScheme.primary,
              secondary: widget.theme.colorScheme.secondary,
              error: widget.theme.colorScheme.destructive,
            ),
          ),
      child: c.CupertinoTheme(
        data: widget.cupertinoTheme ??
            c.CupertinoThemeData(
              brightness: widget.theme.brightness,
              primaryColor: widget.theme.colorScheme.primary,
              barBackgroundColor: widget.theme.colorScheme.accent,
              scaffoldBackgroundColor: widget.theme.colorScheme.background,
              applyThemeToAll: true,
              primaryContrastingColor:
                  widget.theme.colorScheme.primaryForeground,
            ),
        child: m.Material(
          color: widget.background ?? m.Colors.transparent,
          child: m.ScaffoldMessenger(
            child: ScrollConfiguration(
              behavior: (widget.scrollBehavior ?? const ShadcnScrollBehavior()),
              child: HeroControllerScope(
                controller: _heroController,
                child: result,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShadcnLayer extends StatelessWidget {
  final Widget? child;
  final ThemeData theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final AdaptiveScaling? scaling;
  final List<Color> initialRecentColors;
  final int maxRecentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  final Widget Function(BuildContext context, Widget? child)? builder;
  final bool enableScrollInterception;
  final OverlayHandler? popoverHandler;
  final OverlayHandler? tooltipHandler;
  final OverlayHandler? menuHandler;
  final bool enableThemeAnimation;

  const ShadcnLayer({
    super.key,
    required this.theme,
    this.scaling,
    this.child,
    this.initialRecentColors = const [],
    this.maxRecentColors = 50,
    this.onRecentColorsChanged,
    this.builder,
    this.enableScrollInterception = false,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.popoverHandler,
    this.tooltipHandler,
    this.menuHandler,
    this.enableThemeAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    var appScaling = scaling ?? AdaptiveScaler.defaultScaling(theme);
    var platformBrightness = MediaQuery.platformBrightnessOf(context);
    var mobileMode = isMobile(theme.platform);
    final scaledTheme = themeMode == ThemeMode.dark ||
            (themeMode == ThemeMode.system &&
                platformBrightness == Brightness.dark)
        ? appScaling.scale(darkTheme ?? theme)
        : appScaling.scale(theme);
    return OverlayManagerLayer(
      menuHandler: menuHandler ??
          (mobileMode
              ? const SheetOverlayHandler()
              : const PopoverOverlayHandler()),
      popoverHandler: popoverHandler ??
          (mobileMode
              ? const SheetOverlayHandler()
              : const PopoverOverlayHandler()),
      tooltipHandler: tooltipHandler ??
          (mobileMode
              ? const FixedTooltipOverlayHandler()
              : const PopoverOverlayHandler()),
      child: ShadcnAnimatedTheme(
        duration: kDefaultDuration,
        data: scaledTheme,
        child: Builder(builder: (context) {
          var theme = Theme.of(context);
          return DataMessengerRoot(
            child: ScrollViewInterceptor(
              enabled: enableScrollInterception,
              child: ShadcnSkeletonizerConfigLayer(
                theme: theme,
                child: DefaultTextStyle.merge(
                  style: theme.typography.base.copyWith(
                    color: theme.colorScheme.foreground,
                  ),
                  child: IconTheme.merge(
                    data: theme.iconTheme.medium.copyWith(
                      color: theme.colorScheme.foreground,
                    ),
                    child: RecentColorsScope(
                      initialRecentColors: initialRecentColors,
                      maxRecentColors: maxRecentColors,
                      onRecentColorsChanged: onRecentColorsChanged,
                      child: ColorPickingLayer(
                        child: KeyboardShortcutDisplayMapper(
                          child: ToastLayer(
                            child: builder != null
                                ? Builder(
                                    builder: (BuildContext context) {
                                      return builder!(context, child);
                                    },
                                  )
                                : child ?? const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ShadcnAnimatedTheme extends StatelessWidget {
  final Widget child;
  final ThemeData data;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  const ShadcnAnimatedTheme({
    super.key,
    required this.data,
    required this.duration,
    this.curve = Curves.linear,
    this.onEnd,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (duration == Duration.zero) {
      return Theme(
        data: data,
        child: child,
      );
    }
    return AnimatedTheme(
      data: data,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}

class ShadcnRectArcTween extends RectTween {
  ShadcnRectArcTween({
    super.begin,
    super.end,
  });

  bool _dirty = true;

  void _initialize() {
    assert(begin != null);
    assert(end != null);
    final Offset centersVector = end!.center - begin!.center;
    final _BorderRadiusCorner diagonal = _findMax<_BorderRadiusCorner>(
        _allDiagonals,
        (_BorderRadiusCorner d) => _diagonalSupport(centersVector, d));
    _beginArc = ShadcnPointArcTween(
      begin: _cornerFor(begin!, diagonal.beginId),
      end: _cornerFor(end!, diagonal.beginId),
    );
    _endArc = ShadcnPointArcTween(
      begin: _cornerFor(begin!, diagonal.endId),
      end: _cornerFor(end!, diagonal.endId),
    );
    _dirty = false;
  }

  double _diagonalSupport(Offset centersVector, _BorderRadiusCorner diagonal) {
    final Offset delta = _cornerFor(begin!, diagonal.endId) -
        _cornerFor(begin!, diagonal.beginId);
    final double length = delta.distance;
    return centersVector.dx * delta.dx / length +
        centersVector.dy * delta.dy / length;
  }

  Offset _cornerFor(Rect rect, _CornerType id) {
    return switch (id) {
      _CornerType.topLeft => rect.topLeft,
      _CornerType.topRight => rect.topRight,
      _CornerType.bottomLeft => rect.bottomLeft,
      _CornerType.bottomRight => rect.bottomRight,
    };
  }

  ShadcnPointArcTween? get beginArc {
    if (begin == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _beginArc;
  }

  late ShadcnPointArcTween _beginArc;
  ShadcnPointArcTween? get endArc {
    if (end == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _endArc;
  }

  late ShadcnPointArcTween _endArc;

  @override
  set begin(Rect? value) {
    if (value != begin) {
      super.begin = value;
      _dirty = true;
    }
  }

  @override
  set end(Rect? value) {
    if (value != end) {
      super.end = value;
      _dirty = true;
    }
  }

  @override
  Rect lerp(double t) {
    if (_dirty) {
      _initialize();
    }
    if (t == 0.0) {
      return begin!;
    }
    if (t == 1.0) {
      return end!;
    }
    return Rect.fromPoints(_beginArc.lerp(t), _endArc.lerp(t));
  }
}

T _findMax<T>(Iterable<T> input, _KeyFunc<T> keyFunc) {
  late T maxValue;
  double? maxKey;
  for (final T value in input) {
    final double key = keyFunc(value);
    if (maxKey == null || key > maxKey) {
      maxValue = value;
      maxKey = key;
    }
  }
  return maxValue;
}

const List<_BorderRadiusCorner> _allDiagonals = <_BorderRadiusCorner>[
  _BorderRadiusCorner(_CornerType.topLeft, _CornerType.bottomRight),
  _BorderRadiusCorner(_CornerType.bottomRight, _CornerType.topLeft),
  _BorderRadiusCorner(_CornerType.topRight, _CornerType.bottomLeft),
  _BorderRadiusCorner(_CornerType.bottomLeft, _CornerType.topRight),
];

typedef _KeyFunc<T> = double Function(T input);

enum _CornerType { topLeft, topRight, bottomLeft, bottomRight }

class _BorderRadiusCorner {
  const _BorderRadiusCorner(this.beginId, this.endId);
  final _CornerType beginId;
  final _CornerType endId;
}

const double _kOnAxisDelta = 2.0;

class ShadcnPointArcTween extends Tween<Offset> {
  ShadcnPointArcTween({
    super.begin,
    super.end,
  });

  bool _dirty = true;

  void _initialize() {
    assert(this.begin != null);
    assert(this.end != null);

    final Offset begin = this.begin!;
    final Offset end = this.end!;

    // An explanation with a diagram can be found at https://goo.gl/vMSdRg
    final Offset delta = end - begin;
    final double deltaX = delta.dx.abs();
    final double deltaY = delta.dy.abs();
    final double distanceFromAtoB = delta.distance;
    final Offset c = Offset(end.dx, begin.dy);

    double sweepAngle() => 2.0 * asin(distanceFromAtoB / (2.0 * _radius!));

    if (deltaX > _kOnAxisDelta && deltaY > _kOnAxisDelta) {
      if (deltaX < deltaY) {
        _radius =
            distanceFromAtoB * distanceFromAtoB / (c - begin).distance / 2.0;
        _center = Offset(end.dx + _radius! * (begin.dx - end.dx).sign, end.dy);
        if (begin.dx < end.dx) {
          _beginAngle = sweepAngle() * (begin.dy - end.dy).sign;
          _endAngle = 0.0;
        } else {
          _beginAngle = pi + sweepAngle() * (end.dy - begin.dy).sign;
          _endAngle = pi;
        }
      } else {
        _radius =
            distanceFromAtoB * distanceFromAtoB / (c - end).distance / 2.0;
        _center =
            Offset(begin.dx, begin.dy + (end.dy - begin.dy).sign * _radius!);
        if (begin.dy < end.dy) {
          _beginAngle = -pi / 2.0;
          _endAngle = _beginAngle! + sweepAngle() * (end.dx - begin.dx).sign;
        } else {
          _beginAngle = pi / 2.0;
          _endAngle = _beginAngle! + sweepAngle() * (begin.dx - end.dx).sign;
        }
      }
      assert(_beginAngle != null);
      assert(_endAngle != null);
    } else {
      _beginAngle = null;
      _endAngle = null;
    }
    _dirty = false;
  }

  Offset? get center {
    if (begin == null || end == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _center;
  }

  Offset? _center;
  double? get radius {
    if (begin == null || end == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _radius;
  }

  double? _radius;
  double? get beginAngle {
    if (begin == null || end == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _beginAngle;
  }

  double? _beginAngle;
  double? get endAngle {
    if (begin == null || end == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _beginAngle;
  }

  double? _endAngle;

  @override
  set begin(Offset? value) {
    if (value != begin) {
      super.begin = value;
      _dirty = true;
    }
  }

  @override
  set end(Offset? value) {
    if (value != end) {
      super.end = value;
      _dirty = true;
    }
  }

  @override
  Offset lerp(double t) {
    if (_dirty) {
      _initialize();
    }
    if (t == 0.0) {
      return begin!;
    }
    if (t == 1.0) {
      return end!;
    }
    if (_beginAngle == null || _endAngle == null) {
      return Offset.lerp(begin, end, t)!;
    }
    final double angle = lerpDouble(_beginAngle, _endAngle, t)!;
    final double x = cos(angle) * _radius!;
    final double y = sin(angle) * _radius!;
    return _center! + Offset(x, y);
  }
}

class ShadcnUI extends StatelessWidget {
  final TextStyle? textStyle;
  final Widget child;

  const ShadcnUI({
    super.key,
    this.textStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedDefaultTextStyle(
      style: textStyle ??
          theme.typography.sans.copyWith(
            color: theme.colorScheme.foreground,
          ),
      duration: kDefaultDuration,
      child: IconTheme(
        data: IconThemeData(
          color: theme.colorScheme.foreground,
        ),
        child: child,
      ),
    );
  }
}

class _GlobalPointerListener extends c.StatefulWidget {
  final Widget child;

  const _GlobalPointerListener({
    required this.child,
  });

  @override
  c.State<_GlobalPointerListener> createState() =>
      _GlobalPointerListenerState();
}

class PointerData {
  final Offset position;

  PointerData({
    required this.position,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointerData && other.position == position;
  }

  @override
  int get hashCode => position.hashCode;

  @override
  String toString() => 'PointerData(position: $position)';
}

class _GlobalPointerListenerState extends c.State<_GlobalPointerListener> {
  final GlobalKey _key = GlobalKey();
  Offset? _position;
  @override
  Widget build(c.BuildContext context) {
    Widget child = MouseRegion(
      key: _key,
      onEnter: (event) {
        setState(() {
          _position = event.position;
        });
      },
      onExit: (event) {
        setState(() {
          _position = null;
        });
      },
      onHover: (event) {
        setState(() {
          _position = event.position;
        });
      },
      child: widget.child,
    );
    if (_position != null) {
      child = Data.inherit(
        data: PointerData(position: _position!),
        child: child,
      );
    }
    return child;
  }
}
