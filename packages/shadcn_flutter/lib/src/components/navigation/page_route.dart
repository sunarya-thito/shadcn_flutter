import '../../../shadcn_flutter.dart';

/// How long a [ShadcnPageRoute] takes to push or pop.
const Duration kDefaultPageTransitionDuration = Duration(milliseconds: 300);

/// Applies the shadcn page transition: a fade combined with a short vertical
/// slide.
///
/// Shared by [ShadcnPageRoute] and [ShadcnPage] so a route and a declarative
/// page look identical. Deliberately built from a single [SlideTransition] so
/// pages add exactly one [Transform] to the tree, the same as the Material
/// route this replaced.
class ShadcnPageTransition extends StatelessWidget {
  /// Drives the incoming page.
  final Animation<double> animation;

  /// The page content.
  final Widget child;

  /// Creates a shadcn page transition.
  const ShadcnPageTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  static final Animatable<double> _fadeIn = CurveTween(
    curve: Curves.easeOutCubic,
  );
  static final Animatable<Offset> _slideIn = Tween<Offset>(
    begin: const Offset(0, 0.02),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeOutCubic));

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.drive(_fadeIn),
      child: SlideTransition(position: animation.drive(_slideIn), child: child),
    );
  }
}

/// A modal route that displays a full-screen page with the shadcn transition.
///
/// This is shadcn_flutter's replacement for `MaterialPageRoute`, and is the
/// default route type [ShadcnApp] builds for [ShadcnApp.routes] and
/// [ShadcnApp.home]. It depends on nothing outside `package:flutter/widgets.dart`.
///
/// Example:
/// ```dart
/// Navigator.of(context).push(
///   ShadcnPageRoute(builder: (context) => const SettingsPage()),
/// );
/// ```
///
/// See also:
///  * [ShadcnPage], the [Page] equivalent for declarative navigation (Router,
///    go_router, and friends).
class ShadcnPageRoute<T> extends PageRoute<T> {
  /// Builds the primary content of the route.
  final WidgetBuilder builder;

  /// Whether the route obscures routes behind it, see [opaque].
  final bool _opaque;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  final String? barrierLabel;

  /// Creates a page route that renders [builder] with the shadcn transition.
  ///
  /// Parameters:
  /// - [builder] (`WidgetBuilder`, required): builds the page content.
  /// - [settings] (`RouteSettings?`, optional): name and arguments of the route.
  /// - [maintainState] (`bool`, default `true`): keep the page's state alive
  ///   while it is covered by another route.
  /// - [fullscreenDialog] (`bool`, default `false`): present the page as a
  ///   modal dialog rather than as the next page in a flow.
  /// - [_opaque] (`bool`, default `true`): whether routes behind this one should
  ///   stop being built once the transition finishes.
  /// - [transitionDuration] (`Duration`, default
  ///   [kDefaultPageTransitionDuration]): length of the push and pop animation.
  /// - [barrierLabel] (`String?`, optional): semantics label for the barrier.
  ShadcnPageRoute({
    required this.builder,
    super.settings,
    this.maintainState = true,
    super.fullscreenDialog,
    this._opaque = true,
    this.transitionDuration = kDefaultPageTransitionDuration,
    this.barrierLabel,
  });

  @override
  bool get opaque => _opaque;

  @override
  Color? get barrierColor => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ShadcnPageTransition(animation: animation, child: child);
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) =>
      nextRoute is ShadcnPageRoute;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}

/// A [Page] that creates a [ShadcnPageRoute].
///
/// This is shadcn_flutter's replacement for `MaterialPage`, for use with
/// declarative navigation APIs such as [Navigator.pages] or `go_router`.
///
/// Example:
/// ```dart
/// Navigator(
///   pages: [
///     ShadcnPage(key: ValueKey('home'), child: const HomePage()),
///     if (showSettings)
///       ShadcnPage(key: ValueKey('settings'), child: const SettingsPage()),
///   ],
///   onDidRemovePage: (page) => ...,
/// );
/// ```
class ShadcnPage<T> extends Page<T> {
  /// The content to show for this page.
  final Widget child;

  /// Whether to keep the page's state alive while it is covered.
  final bool maintainState;

  /// Whether the page is presented as a modal dialog.
  final bool fullscreenDialog;

  /// How long the push and pop animation runs for.
  final Duration transitionDuration;

  /// Creates a page backed by a [ShadcnPageRoute].
  const ShadcnPage({
    required this.child,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.transitionDuration = kDefaultPageTransitionDuration,
    super.key,
    super.canPop,
    super.onPopInvoked,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return ShadcnPageRoute<T>(
      builder: (context) => child,
      settings: this,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
    );
  }
}
