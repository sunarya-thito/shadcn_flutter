import 'package:shadcn_flutter/shadcn_flutter.dart';

class DialogRoute<T> extends RawDialogRoute<T> {
  final CapturedData? data;
  DialogRoute({
    required BuildContext context,
    required WidgetBuilder builder,
    CapturedThemes? themes,
    super.barrierColor = const Color.fromRGBO(0, 0, 0, 0.8),
    super.barrierDismissible,
    String? barrierLabel,
    bool useSafeArea = true,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
    this.data,
  }) : super(
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(
              builder: (context) {
                final theme = Theme.of(context);
                final scaling = theme.scaling;
                return Padding(
                  padding: const EdgeInsets.all(16) * scaling,
                  child: builder(context),
                );
              },
            );
            Widget dialog = themes?.wrap(pageChild) ?? pageChild;
            if (data != null) {
              dialog = data.wrap(dialog);
            }
            if (useSafeArea) {
              dialog = SafeArea(child: dialog);
            }
            return dialog;
          },
          barrierLabel: barrierLabel ?? 'Dismiss',
          transitionDuration: const Duration(milliseconds: 150),
          transitionBuilder: _buildShadcnDialogTransitions,
        );
}

Widget _buildShadcnDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation.drive(Tween<double>(begin: 0.9, end: 1.0)),
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ),
    child: FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    ),
  );
}

Future<T?> showDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useSafeArea = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TraversalEdgeBehavior? traversalEdgeBehavior,
}) {
  var navigatorState = Navigator.of(
    context,
    rootNavigator: useRootNavigator,
  );
  final CapturedThemes themes =
      InheritedTheme.capture(from: context, to: navigatorState.context);
  final CapturedData data =
      Data.capture(from: context, to: navigatorState.context);
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    DialogRoute<T>(
      context: context,
      builder: builder,
      themes: themes,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? const Color.fromRGBO(0, 0, 0, 0.8),
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      anchorPoint: anchorPoint,
      data: data,
      traversalEdgeBehavior:
          traversalEdgeBehavior ?? TraversalEdgeBehavior.closedLoop,
    ),
  );
}
