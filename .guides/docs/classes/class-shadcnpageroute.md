---
title: "Class: ShadcnPageRoute"
description: "A modal route that displays a full-screen page with the shadcn transition.   This is shadcn_flutter's replacement for `MaterialPageRoute`, and is the  default route type [ShadcnApp] builds for [ShadcnApp.routes] and  [ShadcnApp.home]. It depends on nothing outside `package:flutter/widgets.dart`.   Example:  ```dart  Navigator.of(context).push(    ShadcnPageRoute(builder: (context) => const SettingsPage()),  );  ```   See also:   * [ShadcnPage], the [Page] equivalent for declarative navigation (Router,     go_router, and friends)."
---

```dart
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
  final bool maintainState;
  final Duration transitionDuration;
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
  /// - [opaque] (`bool`, default `true`): whether routes behind this one should
  ///   stop being built once the transition finishes.
  /// - [transitionDuration] (`Duration`, default
  ///   [kDefaultPageTransitionDuration]): length of the push and pop animation.
  /// - [barrierLabel] (`String?`, optional): semantics label for the barrier.
  ShadcnPageRoute({required this.builder, super.settings, this.maintainState = true, super.fullscreenDialog, bool opaque = true, this.transitionDuration = kDefaultPageTransitionDuration, this.barrierLabel});
  bool get opaque;
  Color? get barrierColor;
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute);
  String get debugLabel;
}
```
