---
title: "Class: ShadcnApp"
description: "The main application widget for shadcn_flutter."
---

```dart
/// The main application widget for shadcn_flutter.
///
/// ShadcnApp provides a Material-style app structure with shadcn theming.
/// It wraps the Flutter [WidgetsApp] and provides theme management,
/// navigation, and other app-level configurations.
class ShadcnApp extends StatefulWidget {
  /// Creates a ShadcnApp with navigator-based routing.
  ///
  /// This constructor is used for apps that use named routes and
  /// a Navigator for navigation.
  const ShadcnApp({super.key, this.navigatorKey, this.home, this.routes = const {}, this.initialRoute, this.onGenerateRoute, this.onGenerateInitialRoutes, this.onUnknownRoute, this.onNavigationNotification, this.navigatorObservers = const [], this.builder, this.title = '', this.onGenerateTitle, this.color, this.background, this.theme = const ThemeData(), this.locale, this.localizationsDelegates, this.localeListResolutionCallback, this.localeResolutionCallback, this.supportedLocales = const [Locale('en', 'US')], this.debugShowMaterialGrid = false, this.showPerformanceOverlay = false, this.showSemanticsDebugger = false, this.debugShowCheckedModeBanner = true, this.shortcuts, this.actions, this.restorationScopeId, this.scrollBehavior, this.materialTheme, this.cupertinoTheme, this.scaling, this.disableBrowserContextMenu = true, this.initialRecentColors = const [], this.maxRecentColors = 10, this.onRecentColorsChanged, this.pixelSnap = true, this.enableScrollInterception = true, this.darkTheme, this.themeMode = ThemeMode.system, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = true});
  /// Creates a ShadcnApp with router-based routing.
  ///
  /// This constructor is used for apps that use the Router API
  /// for declarative navigation.
  const ShadcnApp.router({super.key, this.routeInformationProvider, this.routeInformationParser, this.routerDelegate, this.routerConfig, this.backButtonDispatcher, this.builder, this.title = '', this.onGenerateTitle, this.onNavigationNotification, this.color, this.background, this.theme = const ThemeData(), this.locale, this.localizationsDelegates, this.localeListResolutionCallback, this.localeResolutionCallback, this.supportedLocales = const [Locale('en', 'US')], this.debugShowMaterialGrid = false, this.showPerformanceOverlay = false, this.showSemanticsDebugger = false, this.debugShowCheckedModeBanner = true, this.shortcuts, this.actions, this.restorationScopeId, this.scrollBehavior, this.materialTheme, this.cupertinoTheme, this.scaling, this.disableBrowserContextMenu = true, this.initialRecentColors = const [], this.maxRecentColors = 50, this.onRecentColorsChanged, this.pixelSnap = true, this.enableScrollInterception = false, this.darkTheme, this.themeMode = ThemeMode.system, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = true});
  /// A key to use when building the [Navigator].
  final GlobalKey<NavigatorState>? navigatorKey;
  /// The scaling strategy for the app.
  final AdaptiveScaling? scaling;
  /// The widget for the default route of the app.
  final Widget? home;
  /// The application's top-level routing table.
  final Map<String, WidgetBuilder>? routes;
  /// The name of the first route to show.
  final String? initialRoute;
  /// The route generator callback used when the app is navigated to a named route.
  final RouteFactory? onGenerateRoute;
  /// The route generator callback used to generate initial routes.
  final InitialRouteListFactory? onGenerateInitialRoutes;
  /// Called when [onGenerateRoute] fails to generate a route.
  final RouteFactory? onUnknownRoute;
  /// Called when a navigation notification is dispatched.
  final NotificationListenerCallback<NavigationNotification>? onNavigationNotification;
  /// The list of observers for the [Navigator] created for this app.
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
  /// A builder that wraps the app's content.
  final TransitionBuilder? builder;
  /// A one-line description used by the device to identify the app.
  final String title;
  /// A callback that produces the app title based on the context.
  final GenerateAppTitle? onGenerateTitle;
  /// The theme data for the app.
  final ThemeData theme;
  /// The dark theme data for the app.
  final ThemeData? darkTheme;
  /// Determines which theme will be used by the app.
  final ThemeMode themeMode;
  /// The primary color to use for the app's widgets.
  final Color? color;
  /// The background color for the app.
  final Color? background;
  /// The initial locale for this app's [Localizations] widget.
  final Locale? locale;
  /// The delegates for this app's [Localizations] widget.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  /// Callback that receives the list of locales and returns the best match.
  final LocaleListResolutionCallback? localeListResolutionCallback;
  /// Callback that receives locale and supported locales and returns the best match.
  final LocaleResolutionCallback? localeResolutionCallback;
  /// The list of locales that this app has been localized for.
  final Iterable<Locale> supportedLocales;
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
  /// Whether to show the Material grid in debug mode.
  final bool debugShowMaterialGrid;
  /// The Material theme to use for Material widgets.
  final m.ThemeData? materialTheme;
  /// The Cupertino theme to use for Cupertino widgets.
  final c.CupertinoThemeData? cupertinoTheme;
  /// Whether to disable the browser context menu.
  final bool disableBrowserContextMenu;
  /// The initial list of recent colors.
  final List<Color> initialRecentColors;
  /// The maximum number of recent colors to track.
  final int maxRecentColors;
  /// Called when the list of recent colors changes.
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  /// Whether to snap widgets to physical pixels.
  final bool pixelSnap;
  /// Whether to enable scroll interception.
  final bool enableScrollInterception;
  /// The overlay handler for popovers.
  final OverlayHandler? popoverHandler;
  /// The overlay handler for tooltips.
  final OverlayHandler? tooltipHandler;
  /// The overlay handler for menus.
  final OverlayHandler? menuHandler;
  /// Whether to animate theme changes.
  final bool enableThemeAnimation;
  State<ShadcnApp> createState();
}
```
