import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Derives a [cupertino.CupertinoThemeData] from a shadcn_flutter [ThemeData].
///
/// Maps the shadcn color scheme onto the Cupertino theme so that Cupertino
/// widgets sitting next to shadcn_flutter components share the same primary,
/// bar, scaffold and contrasting colors, and the same brightness.
///
/// Pass the result to [CupertinoLayer.theme] if you want to tweak it, or let
/// [CupertinoLayer] call this for you.
cupertino.CupertinoThemeData cupertinoThemeFor(ThemeData theme) {
  return cupertino.CupertinoThemeData(
    brightness: theme.brightness,
    primaryColor: theme.colorScheme.primary,
    barBackgroundColor: theme.colorScheme.accent,
    scaffoldBackgroundColor: theme.colorScheme.background,
    applyThemeToAll: true,
    primaryContrastingColor: theme.colorScheme.primaryForeground,
  );
}

/// Installs everything Cupertino widgets need in order to build.
///
/// Cupertino widgets read from a [cupertino.CupertinoTheme] ancestor, which
/// `ShadcnApp` no longer provides. This widget does, defaulting to
/// [cupertinoThemeFor] applied to the ambient shadcn theme so Cupertino widgets
/// follow the shadcn theme (including light/dark switches) with no extra wiring.
///
/// Most apps get this for free by using [CupertinoShadcnApp]. Use
/// [CupertinoLayer] directly when you only need Cupertino widgets in one
/// subtree, or when you are composing `ShadcnApp` yourself:
///
/// ```dart
/// ShadcnApp(
///   localizationsDelegates: kCupertinoLocalizationsDelegates,
///   builder: (context, child) => CupertinoLayer(child: child!),
///   home: const HomePage(),
/// );
/// ```
///
/// See also:
///  * [CupertinoShadcnApp], which wraps `ShadcnApp` with this layer already
///    applied and the Cupertino localizations registered.
///  * `MaterialLayer` from `package:shadcn_flutter_material`, the equivalent
///    for Material widgets.
class CupertinoLayer extends StatelessWidget {
  /// The subtree that may contain Cupertino widgets.
  final Widget child;

  /// The Cupertino theme to install.
  ///
  /// Defaults to [cupertinoThemeFor] applied to the ambient shadcn theme.
  final cupertino.CupertinoThemeData? theme;

  /// Creates a Cupertino compatibility layer around [child].
  const CupertinoLayer({super.key, required this.child, this.theme});

  @override
  Widget build(BuildContext context) {
    return cupertino.CupertinoTheme(
      data: theme ?? cupertinoThemeFor(Theme.of(context)),
      child: child,
    );
  }
}

/// The localizations delegates Cupertino widgets need.
///
/// Add these to `ShadcnApp.localizationsDelegates` whenever Cupertino widgets
/// are used; without them, widgets that call `CupertinoLocalizations.of` (date
/// pickers, text selection toolbars and more) assert at build time.
///
/// [CupertinoShadcnApp] adds them automatically.
///
/// For translations beyond English, add `GlobalCupertinoLocalizations.delegate`
/// from `package:flutter_localizations` ahead of these.
const List<LocalizationsDelegate<dynamic>> kCupertinoLocalizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
      cupertino.DefaultCupertinoLocalizations.delegate,
    ];
