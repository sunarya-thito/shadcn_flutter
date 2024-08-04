import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_platform_interface/shadcn_flutter_platform_interface.dart';

import 'components/control/scrollview.dart';

class ShadcnApp extends StatefulWidget {
  const ShadcnApp({
    super.key,
    this.navigatorKey,
    this.home,
    Map<String, WidgetBuilder> this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    required this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
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
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        routerConfig = null;

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
    required this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
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
  })  : assert(routerDelegate != null || routerConfig != null),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null;

  final GlobalKey<NavigatorState>? navigatorKey;

  final Widget? home;

  final Map<String, WidgetBuilder>? routes;

  final String? initialRoute;

  final RouteFactory? onGenerateRoute;

  final InitialRouteListFactory? onGenerateInitialRoutes;

  final RouteFactory? onUnknownRoute;

  final NotificationListenerCallback<NavigationNotification>?
      onNavigationNotification;

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
  final Color? color;
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

  @override
  State<ShadcnApp> createState() => _ShadcnAppState();
}

class ShadcnScrollBehavior extends ScrollBehavior {
  const ShadcnScrollBehavior();

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
  late HeroController _heroController;

  void _dispatchAppInitialized() {
    AbstractPlatformImplementations.instance.onAppInitialized();
  }

  bool get _usesRouter =>
      widget.routerDelegate != null || widget.routerConfig != null;

  @override
  void initState() {
    super.initState();
    // _heroController = ShadcnApp.createMaterialHeroController();
    _heroController = HeroController(
      createRectTween: (begin, end) {
        return ShadcnRectArcTween(begin: begin, end: end);
      },
    );
    Future.delayed(const Duration(milliseconds: 10), _dispatchAppInitialized);
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
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
    final ThemeData theme = widget.theme;
    return DataMessengerRoot(
      child: ScrollViewInterceptor(
        child: ShadcnSkeletonizerConfigLayer(
          theme: theme,
          child: mergeAnimatedTextStyle(
            duration: kDefaultDuration,
            style: TextStyle(
              color: theme.colorScheme.foreground,
            ),
            child: AnimatedIconTheme.merge(
              duration: kDefaultDuration,
              data: IconThemeData(
                color: theme.colorScheme.foreground,
              ),
              child: Theme(
                data: theme,
                child: AdaptiveScaler(
                  builder: AdaptiveScaler.defaultScaling,
                  child: ToastLayer(
                    child: SortableLayer(
                      child: widget.builder != null
                          ? Builder(
                              builder: (BuildContext context) {
                                return widget.builder!(context, child);
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
    result = Focus(
      canRequestFocus: false,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is! KeyDownEvent ||
            event.logicalKey != LogicalKeyboardKey.escape) {
          return KeyEventResult.ignored;
        }
        // return Tooltip.dismissAllToolTips()
        //     ? KeyEventResult.handled
        //     : KeyEventResult.ignored;
        return KeyEventResult.ignored;
      },
      child: result,
    );
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
          color: m.Colors.transparent,
          child: m.ScaffoldMessenger(
            child: ScrollConfiguration(
              behavior: (widget.scrollBehavior ?? const ShadcnScrollBehavior())
                  .copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
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
    Key? key,
    this.textStyle,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return mergeAnimatedTextStyle(
      style: textStyle ??
          theme.typography.sans.copyWith(
            color: theme.colorScheme.foreground,
          ),
      child: AnimatedIconTheme(
        data: IconThemeData(
          color: theme.colorScheme.foreground,
        ),
        duration: kDefaultDuration,
        child: child,
      ),
      duration: kDefaultDuration,
    );
  }
}

class _GlobalPointerListener extends c.StatefulWidget {
  final Widget child;

  const _GlobalPointerListener({
    Key? key,
    required this.child,
  }) : super(key: key);

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
      child = Data(
        data: PointerData(position: _position!),
        child: child,
      );
    }
    return child;
  }
}
