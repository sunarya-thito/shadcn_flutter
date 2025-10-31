import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'platform_interface.dart'
    if (dart.library.js_interop) 'platform/platform_implementations_web.dart';

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
    this.theme = const ThemeData(),
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

  /// Creates a ShadcnApp with router-based routing.
  ///
  /// This constructor is used for apps that use the Router API
  /// for declarative navigation.
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
    this.theme = const ThemeData(),
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
  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

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

  @override
  State<ShadcnApp> createState() => _ShadcnAppState();
}

/// Default scroll behavior for shadcn_flutter applications.
///
/// Provides bouncing physics and platform-appropriate scrollbars.
class ShadcnScrollBehavior extends ScrollBehavior {
  /// Creates a shadcn scroll behavior.
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
          // ignore: unreachable_switch_default
          default:
            return Scrollbar(
              controller: details.controller,
              child: child,
            );
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
      // ignore: unreachable_switch_default
      default:
        return child;
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

/// A layer widget that provides shadcn theme and infrastructure.
///
/// This widget sets up the theming, overlay handlers, scroll behavior,
/// and other infrastructure needed for shadcn_flutter widgets to work correctly.
class ShadcnLayer extends StatelessWidget {
  /// The child widget to wrap with shadcn infrastructure.
  final Widget? child;

  /// The light theme data.
  final ThemeData theme;

  /// The dark theme data.
  final ThemeData? darkTheme;

  /// Determines which theme to use.
  final ThemeMode themeMode;

  /// The scaling strategy for adaptive layouts.
  final AdaptiveScaling? scaling;

  /// The initial list of recent colors.
  final List<Color> initialRecentColors;

  /// The maximum number of recent colors to track.
  final int maxRecentColors;

  /// Called when the list of recent colors changes.
  final ValueChanged<List<Color>>? onRecentColorsChanged;

  /// A builder to wrap the child widget.
  final Widget Function(BuildContext context, Widget? child)? builder;

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

  /// Creates a shadcn layer.
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
                      child: EyeDropperLayer(
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

/// An animated theme widget for shadcn_flutter.
///
/// Animates theme changes over time with smooth transitions.
class ShadcnAnimatedTheme extends StatelessWidget {
  /// The child widget to apply the theme to.
  final Widget child;

  /// The theme data to animate to.
  final ThemeData data;

  /// The duration of the animation.
  final Duration duration;

  /// The curve for the animation.
  final Curve curve;

  /// Called when the animation completes.
  final VoidCallback? onEnd;

  /// Creates an animated theme widget.
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

/// A custom tween for animating rectangles along an arc.
///
/// This tween creates more natural-looking animations for rectangles
/// by moving them along an arc path rather than a straight line.
class ShadcnRectArcTween extends RectTween {
  /// Creates a rectangle arc tween.
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

  /// Gets the arc tween for the beginning point of the rectangle.
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

  /// Gets the arc tween for the ending point of the rectangle.
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

/// A custom tween for animating points along an arc.
///
/// This tween creates curved motion between two points, useful for
/// creating natural-looking animations.
class ShadcnPointArcTween extends Tween<Offset> {
  /// Creates a point arc tween.
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

  /// Gets the center point of the arc between [begin] and [end].
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// The center is computed lazily and cached for performance.
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

  /// Gets the radius of the arc between [begin] and [end].
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// The radius is the distance from the center to either endpoint.
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

  /// Gets the starting angle of the arc in radians.
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// Angle is measured clockwise from the positive x-axis.
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

  /// Gets the ending angle of the arc in radians.
  ///
  /// Returns `null` if either [begin] or [end] is null.
  ///
  /// Angle is measured clockwise from the positive x-axis.
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

/// A widget that provides text and icon styling for shadcn UI components.
///
/// Applies consistent text styles and icon themes to its descendants.
class ShadcnUI extends StatelessWidget {
  /// Optional text style override.
  final TextStyle? textStyle;

  /// The child widget.
  final Widget child;

  /// Creates a ShadcnUI widget.
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

/// Data about the current pointer position.
///
/// Used to track mouse/pointer location in the app.
class PointerData {
  /// The current position of the pointer.
  final Offset position;

  /// Creates pointer data with the given position.
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
