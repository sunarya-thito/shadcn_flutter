import 'package:material_ui/material_ui.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'material_layer.dart';

/// A [ShadcnApp] that can also host Material widgets.
///
/// Identical to [ShadcnApp] except that it registers
/// [kMaterialLocalizationsDelegates] and wraps the app in a [MaterialLayer], so
/// `Scaffold`, `AppBar`, `showDialog`, `ScaffoldMessenger` and every other
/// Material widget work inside it. The Material theme follows the shadcn theme
/// unless [materialTheme] overrides it.
///
/// ```dart
/// void main() {
///   runApp(
///     MaterialShadcnApp(
///       theme: ThemeData(
///         colorScheme: ColorSchemes.darkZinc(),
///         radius: 0.5,
///       ),
///       home: const MyHomePage(),
///     ),
///   );
/// }
/// ```
///
/// If you only need Material widgets in part of the app, use plain [ShadcnApp]
/// and wrap that subtree in a [MaterialLayer] instead.
///
/// See also:
///  * `CupertinoShadcnApp` from `package:shadcn_flutter_cupertino`, the
///    equivalent for Cupertino widgets.
class MaterialShadcnApp extends StatelessWidget {
  /// The Material theme to install, overriding the one derived from [theme].
  ///
  /// Leave null to have Material widgets follow the shadcn theme (including
  /// [darkTheme] and [themeMode] switches) automatically.
  final material.ThemeData? materialTheme;

  /// Background color painted by the Material ancestor, see
  /// [MaterialLayer.background].
  final Color? materialBackground;

  /// Whether a [material.ScaffoldMessenger] is installed, see
  /// [MaterialLayer.scaffoldMessenger].
  final bool scaffoldMessenger;

  /// Whether this app was built with the router constructor.
  final bool _usesRouter;

  /// {@macro shadcn_flutter.ShadcnApp.navigatorKey}
  final GlobalKey<NavigatorState>? navigatorKey;

  /// The widget for the default route of the app.
  final Widget? home;

  /// The application's top-level routing table.
  final Map<String, WidgetBuilder>? routes;

  /// The name of the first route to show.
  final String? initialRoute;

  /// Called to generate a route for a given [RouteSettings].
  final RouteFactory? onGenerateRoute;

  /// Called to generate the app's initial routes.
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// Called when [onGenerateRoute] fails to generate a route.
  final RouteFactory? onUnknownRoute;

  /// Called when a navigation notification is dispatched.
  final NotificationListenerCallback<NavigationNotification>?
  onNavigationNotification;

  /// The observers for the [Navigator] created for this app.
  final List<NavigatorObserver>? navigatorObservers;

  /// The route information provider for router-based navigation.
  final RouteInformationProvider? routeInformationProvider;

  /// The route information parser for router-based navigation.
  final RouteInformationParser<Object>? routeInformationParser;

  /// The router delegate for router-based navigation.
  final RouterDelegate<Object>? routerDelegate;

  /// The back button dispatcher for router-based navigation.
  final BackButtonDispatcher? backButtonDispatcher;

  /// The router configuration for router-based navigation.
  final RouterConfig<Object>? routerConfig;

  /// A builder that wraps the app's content, applied inside the
  /// [MaterialLayer].
  final TransitionBuilder? builder;

  /// A one-line description used by the device to identify the app.
  final String title;

  /// A callback that produces the app title based on the context.
  final GenerateAppTitle? onGenerateTitle;

  /// The shadcn theme data for the app.
  final ThemeData theme;

  /// The shadcn dark theme data for the app.
  final ThemeData? darkTheme;

  /// Determines which of [theme] and [darkTheme] is used.
  final ThemeMode themeMode;

  /// The primary color to use for the app's widgets.
  final Color? color;

  /// The background color for the app.
  final Color? background;

  /// The initial locale for this app's [Localizations] widget.
  final Locale? locale;

  /// Additional delegates for this app's [Localizations] widget.
  ///
  /// [kMaterialLocalizationsDelegates] is appended to these automatically.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Callback that receives the list of locales and returns the best match.
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// Callback that receives a locale and supported locales and returns the best
  /// match.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// The list of locales that this app has been localized for.
  final Iterable<Locale> supportedLocales;

  /// Whether to overlay an 8px debug grid on the app in debug mode.
  final bool debugShowGrid;

  /// Whether to show the performance overlay.
  final bool showPerformanceOverlay;

  /// Whether to show the semantics debugger.
  final bool showSemanticsDebugger;

  /// Whether to show the debug banner.
  final bool debugShowCheckedModeBanner;

  /// The default map of shortcuts to intents for the application.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// The default map of intent types to actions for the application.
  final Map<Type, Action<Intent>>? actions;

  /// The identifier to use for state restoration of the app.
  final String? restorationScopeId;

  /// The scroll behavior for the app.
  final ScrollBehavior? scrollBehavior;

  /// The scaling strategy for the app.
  final AdaptiveScaling? scaling;

  /// Whether to disable the browser's own context menu on web.
  final bool disableBrowserContextMenu;

  /// The initial list of recent colors for color pickers.
  final List<Color> initialRecentColors;

  /// The maximum number of recent colors to track.
  final int maxRecentColors;

  /// Called when the list of recent colors changes.
  final ValueChanged<List<Color>>? onRecentColorsChanged;

  /// Whether to snap layout values to physical pixels.
  final bool pixelSnap;

  /// Whether to enable scroll interception.
  final bool enableScrollInterception;

  /// Whether to animate theme changes.
  final bool enableThemeAnimation;

  /// Creates a [MaterialShadcnApp] with navigator-based routing.
  ///
  /// Takes every parameter [ShadcnApp] takes, plus [materialTheme],
  /// [materialBackground] and [scaffoldMessenger] which configure the
  /// [MaterialLayer].
  const MaterialShadcnApp({
    super.key,
    this.materialTheme,
    this.materialBackground,
    this.scaffoldMessenger = true,
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
    this.theme = const ThemeData(),
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowGrid = false,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.scaling,
    this.disableBrowserContextMenu = true,
    this.initialRecentColors = const [],
    this.maxRecentColors = 10,
    this.onRecentColorsChanged,
    this.pixelSnap = true,
    this.enableScrollInterception = true,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.enableThemeAnimation = true,
  }) : _usesRouter = false,
       routeInformationProvider = null,
       routeInformationParser = null,
       routerDelegate = null,
       backButtonDispatcher = null,
       routerConfig = null;

  /// Creates a [MaterialShadcnApp] with router-based routing.
  ///
  /// Mirrors [ShadcnApp.router].
  const MaterialShadcnApp.router({
    super.key,
    this.materialTheme,
    this.materialBackground,
    this.scaffoldMessenger = true,
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
    this.theme = const ThemeData(),
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowGrid = false,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.scaling,
    this.disableBrowserContextMenu = true,
    this.initialRecentColors = const [],
    this.maxRecentColors = 50,
    this.onRecentColorsChanged,
    this.pixelSnap = true,
    this.enableScrollInterception = false,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.enableThemeAnimation = true,
  }) : assert(routerDelegate != null || routerConfig != null),
       _usesRouter = true,
       navigatorObservers = null,
       navigatorKey = null,
       onGenerateRoute = null,
       home = null,
       onGenerateInitialRoutes = null,
       onUnknownRoute = null,
       routes = null,
       initialRoute = null;

  Iterable<LocalizationsDelegate<dynamic>> get _delegates =>
      <LocalizationsDelegate<dynamic>>[
        ...?localizationsDelegates,
        ...kMaterialLocalizationsDelegates,
      ];

  Widget _builder(BuildContext context, Widget? child) {
    return MaterialLayer(
      theme: materialTheme,
      background: materialBackground,
      scaffoldMessenger: scaffoldMessenger,
      child: builder != null
          ? Builder(builder: (context) => builder!(context, child))
          : child ?? const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_usesRouter) {
      return ShadcnApp.router(
        routeInformationProvider: routeInformationProvider,
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate,
        routerConfig: routerConfig,
        backButtonDispatcher: backButtonDispatcher,
        builder: _builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        onNavigationNotification: onNavigationNotification,
        color: color,
        background: background,
        theme: theme,
        locale: locale,
        localizationsDelegates: _delegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowGrid: debugShowGrid,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        scrollBehavior: scrollBehavior,
        scaling: scaling,
        disableBrowserContextMenu: disableBrowserContextMenu,
        initialRecentColors: initialRecentColors,
        maxRecentColors: maxRecentColors,
        onRecentColorsChanged: onRecentColorsChanged,
        pixelSnap: pixelSnap,
        enableScrollInterception: enableScrollInterception,
        darkTheme: darkTheme,
        themeMode: themeMode,
        enableThemeAnimation: enableThemeAnimation,
      );
    }
    return ShadcnApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes ?? const {},
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      onNavigationNotification: onNavigationNotification,
      navigatorObservers: navigatorObservers ?? const [],
      builder: _builder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      background: background,
      theme: theme,
      locale: locale,
      localizationsDelegates: _delegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowGrid: debugShowGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
      scrollBehavior: scrollBehavior,
      scaling: scaling,
      disableBrowserContextMenu: disableBrowserContextMenu,
      initialRecentColors: initialRecentColors,
      maxRecentColors: maxRecentColors,
      onRecentColorsChanged: onRecentColorsChanged,
      pixelSnap: pixelSnap,
      enableScrollInterception: enableScrollInterception,
      darkTheme: darkTheme,
      themeMode: themeMode,
      enableThemeAnimation: enableThemeAnimation,
    );
  }
}
