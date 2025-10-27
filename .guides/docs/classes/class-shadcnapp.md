---
title: "Class: ShadcnApp"
description: "Reference for ShadcnApp"
---

```dart
class ShadcnApp extends StatefulWidget {
  const ShadcnApp({super.key, this.navigatorKey, this.home, this.routes = const {}, this.initialRoute, this.onGenerateRoute, this.onGenerateInitialRoutes, this.onUnknownRoute, this.onNavigationNotification, this.navigatorObservers = const [], this.builder, this.title = '', this.onGenerateTitle, this.color, this.background, this.theme = const ThemeData(), this.locale, this.localizationsDelegates, this.localeListResolutionCallback, this.localeResolutionCallback, this.supportedLocales = const [Locale('en', 'US')], this.debugShowMaterialGrid = false, this.showPerformanceOverlay = false, this.showSemanticsDebugger = false, this.debugShowCheckedModeBanner = true, this.shortcuts, this.actions, this.restorationScopeId, this.scrollBehavior, this.materialTheme, this.cupertinoTheme, this.scaling, this.disableBrowserContextMenu = true, this.initialRecentColors = const [], this.maxRecentColors = 10, this.onRecentColorsChanged, this.pixelSnap = true, this.enableScrollInterception = true, this.darkTheme = const ThemeData.dark(), this.themeMode = ThemeMode.system, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = true});
  const ShadcnApp.router({super.key, this.routeInformationProvider, this.routeInformationParser, this.routerDelegate, this.routerConfig, this.backButtonDispatcher, this.builder, this.title = '', this.onGenerateTitle, this.onNavigationNotification, this.color, this.background, this.theme = const ThemeData(), this.locale, this.localizationsDelegates, this.localeListResolutionCallback, this.localeResolutionCallback, this.supportedLocales = const [Locale('en', 'US')], this.debugShowMaterialGrid = false, this.showPerformanceOverlay = false, this.showSemanticsDebugger = false, this.debugShowCheckedModeBanner = true, this.shortcuts, this.actions, this.restorationScopeId, this.scrollBehavior, this.materialTheme, this.cupertinoTheme, this.scaling, this.disableBrowserContextMenu = true, this.initialRecentColors = const [], this.maxRecentColors = 50, this.onRecentColorsChanged, this.pixelSnap = true, this.enableScrollInterception = false, this.darkTheme = const ThemeData.dark(), this.themeMode = ThemeMode.system, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = true});
  final GlobalKey<NavigatorState>? navigatorKey;
  final AdaptiveScaling? scaling;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final NotificationListenerCallback<NavigationNotification>? onNavigationNotification;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final RouterConfig<Object>? routerConfig;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Color? color;
  final Color? background;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;
  final m.ThemeData? materialTheme;
  final c.CupertinoThemeData? cupertinoTheme;
  final bool disableBrowserContextMenu;
  final List<Color> initialRecentColors;
  final int maxRecentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  final bool pixelSnap;
  final bool enableScrollInterception;
  final OverlayHandler? popoverHandler;
  final OverlayHandler? tooltipHandler;
  final OverlayHandler? menuHandler;
  final bool enableThemeAnimation;
  State<ShadcnApp> createState();
}
```
