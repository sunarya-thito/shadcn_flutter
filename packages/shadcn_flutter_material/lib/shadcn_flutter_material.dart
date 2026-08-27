/// Material Design interop for shadcn_flutter.
///
/// `package:shadcn_flutter` itself no longer depends on Material — it is built
/// on `package:flutter/widgets.dart` alone. Add this package when an app needs
/// Material widgets (`Scaffold`, `AppBar`, `showDialog`, `Icons`, …) alongside
/// shadcn_flutter components.
///
/// The quickest way in is [MaterialShadcnApp], a drop-in replacement for
/// `ShadcnApp` that registers the Material localizations and installs the
/// Material theme, `Material` and `ScaffoldMessenger` ancestors:
///
/// ```dart
/// import 'package:shadcn_flutter/shadcn_flutter.dart';
/// import 'package:shadcn_flutter_material/shadcn_flutter_material.dart';
///
/// void main() {
///   runApp(
///     MaterialShadcnApp(
///       theme: ThemeData(colorScheme: ColorSchemes.lightZinc(), radius: 0.5),
///       home: Scaffold(
///         appBar: AppBar(title: const Text('Hybrid app')),
///         body: const Center(child: PrimaryButton(child: Text('shadcn'))),
///       ),
///     ),
///   );
/// }
/// ```
///
/// For Material widgets in only part of an app, keep `ShadcnApp` and wrap that
/// subtree in a [MaterialLayer].
///
/// Importing both this library and `package:shadcn_flutter/shadcn_flutter.dart`
/// unprefixed is deliberate: this library re-exports only the handful of
/// Material symbols that do not collide with shadcn_flutter's own (see
/// [Icons]). For everything else, import
/// `package:material_ui/material_ui.dart` with a prefix.
library;

export 'package:material_ui/material_ui.dart'
    show
        // Material's icon font; shadcn_flutter ships LucideIcons, RadixIcons
        // and BootstrapIcons instead, and no longer re-exports this one.
        Icons,
        // Route and page types that used to be re-exported by shadcn_flutter.
        // ShadcnPageRoute and ShadcnPage are the Material-free equivalents.
        MaterialPage,
        MaterialPageRoute,
        // Sliver app bar has no shadcn_flutter equivalent.
        SliverAppBar;

export 'src/material_context_menu.dart';
export 'src/material_layer.dart';
export 'src/material_shadcn_app.dart';
