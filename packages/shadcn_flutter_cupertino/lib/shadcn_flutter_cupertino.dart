/// Cupertino interop for shadcn_flutter.
///
/// `package:shadcn_flutter` itself no longer depends on Cupertino — it is built
/// on `package:flutter/widgets.dart` alone. Add this package when an app needs
/// Cupertino widgets (`CupertinoPageScaffold`, `CupertinoNavigationBar`,
/// `showCupertinoDialog`, `CupertinoIcons`, …) alongside shadcn_flutter
/// components.
///
/// The quickest way in is [CupertinoShadcnApp], a drop-in replacement for
/// `ShadcnApp` that registers the Cupertino localizations and installs the
/// Cupertino theme:
///
/// ```dart
/// import 'package:shadcn_flutter/shadcn_flutter.dart';
/// import 'package:shadcn_flutter_cupertino/shadcn_flutter_cupertino.dart';
///
/// void main() {
///   runApp(
///     CupertinoShadcnApp(
///       theme: ThemeData(colorScheme: ColorSchemes.lightZinc(), radius: 0.5),
///       home: CupertinoPageScaffold(
///         navigationBar: const CupertinoNavigationBar(
///           middle: Text('Hybrid app'),
///         ),
///         child: const Center(child: PrimaryButton(child: Text('shadcn'))),
///       ),
///     ),
///   );
/// }
/// ```
///
/// For Cupertino widgets in only part of an app, keep `ShadcnApp` and wrap that
/// subtree in a [CupertinoLayer].
///
/// This library re-exports only the handful of Cupertino symbols that do not
/// collide with shadcn_flutter's own. For everything else, import
/// `package:cupertino_ui/cupertino_ui.dart` with a prefix.
library;

export 'package:cupertino_ui/cupertino_ui.dart'
    show
        // Cupertino's icon font; shadcn_flutter ships LucideIcons, RadixIcons
        // and BootstrapIcons instead.
        CupertinoIcons,
        // Route and page types, the Cupertino counterparts to ShadcnPageRoute
        // and ShadcnPage.
        CupertinoPage,
        CupertinoPageRoute,
        // Text selection controls that shadcn_flutter used to re-export.
        // The Material-free default is shadcnTextSelectionHandleControls.
        cupertinoDesktopTextSelectionControls,
        cupertinoDesktopTextSelectionHandleControls,
        cupertinoTextSelectionControls,
        cupertinoTextSelectionHandleControls;

export 'src/cupertino_context_menu.dart';
export 'src/cupertino_layer.dart';
export 'src/cupertino_shadcn_app.dart';
