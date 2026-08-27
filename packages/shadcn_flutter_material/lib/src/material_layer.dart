import 'package:material_ui/material_ui.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Derives a Material [material.ThemeData] from a shadcn_flutter [ThemeData].
///
/// The shadcn color scheme is used as the seed for a Material 3 color scheme so
/// that Material widgets sitting next to shadcn_flutter components pick up the
/// same primary, secondary, surface and error colors, and the same brightness.
///
/// Pass the result to [MaterialLayer.theme] if you want to tweak it, or let
/// [MaterialLayer] call this for you.
///
/// Example:
/// ```dart
/// final materialTheme = materialThemeFor(Theme.of(context)).copyWith(
///   splashFactory: NoSplash.splashFactory,
/// );
/// ```
material.ThemeData materialThemeFor(ThemeData theme) {
  return material.ThemeData.from(
    colorScheme: material.ColorScheme.fromSeed(
      seedColor: theme.colorScheme.primary,
      brightness: theme.brightness,
      surface: theme.colorScheme.background,
      primary: theme.colorScheme.primary,
      secondary: theme.colorScheme.secondary,
      error: theme.colorScheme.destructive,
    ),
  );
}

/// Installs everything Material widgets need in order to build.
///
/// Material widgets require a [material.Theme] ancestor, a [material.Material]
/// ancestor for ink and elevation, and a [material.ScaffoldMessenger] for
/// snack bars. `ShadcnApp` no longer provides any of these — this widget does.
///
/// The Material theme defaults to [materialThemeFor] applied to the ambient
/// shadcn theme, so Material widgets follow the shadcn theme (including
/// light/dark switches) without any extra wiring.
///
/// Most apps get this for free by using [MaterialShadcnApp]. Use [MaterialLayer]
/// directly when you only need Material widgets in one subtree, or when you are
/// composing `ShadcnApp` yourself:
///
/// ```dart
/// ShadcnApp(
///   localizationsDelegates: kMaterialLocalizationsDelegates,
///   builder: (context, child) => MaterialLayer(child: child!),
///   home: const HomePage(),
/// );
/// ```
///
/// See also:
///  * [MaterialShadcnApp], which wraps `ShadcnApp` with this layer already
///    applied and the Material localizations registered.
///  * `CupertinoLayer` from `package:shadcn_flutter_cupertino`, the equivalent
///    for Cupertino widgets.
class MaterialLayer extends StatelessWidget {
  /// The subtree that may contain Material widgets.
  final Widget child;

  /// The Material theme to install.
  ///
  /// Defaults to [materialThemeFor] applied to the ambient shadcn theme.
  final material.ThemeData? theme;

  /// Background color painted by the [material.Material] ancestor.
  ///
  /// Defaults to transparent, which lets the shadcn background show through.
  final Color? background;

  /// Whether to install a [material.ScaffoldMessenger].
  ///
  /// Required by `ScaffoldMessenger.of(context).showSnackBar(...)`. Set to
  /// false if an ancestor already provides one.
  final bool scaffoldMessenger;

  /// Creates a Material compatibility layer around [child].
  const MaterialLayer({
    super.key,
    required this.child,
    this.theme,
    this.background,
    this.scaffoldMessenger = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = material.Material(
      color: background ?? const Color(0x00000000),
      child: child,
    );
    if (scaffoldMessenger) {
      result = material.ScaffoldMessenger(child: result);
    }
    return material.Theme(
      data: theme ?? materialThemeFor(Theme.of(context)),
      child: result,
    );
  }
}

/// The localizations delegates Material widgets need.
///
/// Add these to `ShadcnApp.localizationsDelegates` whenever Material widgets
/// are used; without them, widgets that call `MaterialLocalizations.of` (date
/// pickers, text selection toolbars, tooltips and more) assert at build time.
///
/// [MaterialShadcnApp] adds them automatically.
///
/// For translations beyond English, add `GlobalMaterialLocalizations.delegate`
/// from `package:flutter_localizations` ahead of these.
const List<LocalizationsDelegate<dynamic>> kMaterialLocalizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
      material.DefaultMaterialLocalizations.delegate,
    ];
