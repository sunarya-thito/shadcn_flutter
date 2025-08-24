import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Builder function for creating custom keyboard key display widgets.
///
/// This function is called for each keyboard key that needs to be displayed
/// in a keyboard shortcut widget. It allows complete customization of how
/// individual keys are rendered visually.
///
/// Parameters:
/// - [context] (BuildContext): Build context for accessing theme and localization
/// - [key] (LogicalKeyboardKey): The keyboard key to display
///
/// Returns: Widget - A widget representing the keyboard key
///
/// Example:
/// ```dart
/// KeyboardShortcutDisplayBuilder customKeyBuilder = (context, key) {
///   return Container(
///     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
///     decoration: BoxDecoration(
///       color: Colors.grey.shade200,
///       borderRadius: BorderRadius.circular(4),
///       border: Border.all(color: Colors.grey.shade400),
///     ),
///     child: Text(
///       key.debugName ?? key.keyLabel,
///       style: TextStyle(fontFamily: 'monospace'),
///     ),
///   );
/// };
/// ```
typedef KeyboardShortcutDisplayBuilder = Widget Function(
  BuildContext context,
  LogicalKeyboardKey key,
);

/// Theme configuration for keyboard shortcut display components.
///
/// [KeyboardShortcutTheme] provides styling options for keyboard shortcut
/// widgets including spacing between keys, padding within key displays, and
/// shadow effects. It ensures consistent visual presentation of keyboard
/// shortcuts across the application.
///
/// The theme focuses on creating keyboard key representations that are
/// immediately recognizable and visually distinct, helping users understand
/// keyboard shortcuts at a glance.
///
/// Example:
/// ```dart
/// ComponentTheme<KeyboardShortcutTheme>(
///   data: KeyboardShortcutTheme(
///     spacing: 4.0,
///     keyPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
///     keyShadow: [
///       BoxShadow(
///         color: Colors.black26,
///         offset: Offset(0, 2),
///         blurRadius: 4,
///       ),
///     ],
///   ),
///   child: KeyboardShortcut(keys: [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyS]),
/// )
/// ```
class KeyboardShortcutTheme {
  /// Horizontal spacing between individual key displays.
  ///
  /// Controls the gap between adjacent keyboard keys in the shortcut display.
  /// Proper spacing helps users distinguish individual keys and improves
  /// visual clarity. When null, uses a default spacing appropriate for
  /// the current theme.
  final double? spacing;

  /// Internal padding applied to each keyboard key display.
  ///
  /// Controls the space between the key label and the key's visual border.
  /// Adequate padding ensures key labels are readable and the keys appear
  /// properly sized. When null, uses default padding based on key size.
  final EdgeInsetsGeometry? keyPadding;

  /// Shadow effects applied to keyboard key displays.
  ///
  /// Creates depth and visual separation for keyboard keys, making them
  /// appear as physical keyboard keys. When null, uses subtle default
  /// shadows that provide depth without being distracting.
  final List<BoxShadow>? keyShadow;

  /// Creates a [KeyboardShortcutTheme] with optional styling properties.
  ///
  /// All parameters are optional and fall back to theme defaults when null.
  /// Use this constructor to customize the appearance of keyboard shortcut
  /// displays to match your application's design system.
  ///
  /// Parameters:
  /// - [spacing]: Gap between individual key displays
  /// - [keyPadding]: Internal padding for each key
  /// - [keyShadow]: Shadow effects for key depth
  const KeyboardShortcutTheme({
    this.spacing,
    this.keyPadding,
    this.keyShadow,
  });

  /// Creates a copy with the given values replaced.
  KeyboardShortcutTheme copyWith({
    ValueGetter<double?>? spacing,
    ValueGetter<EdgeInsetsGeometry?>? keyPadding,
    ValueGetter<List<BoxShadow>?>? keyShadow,
  }) {
    return KeyboardShortcutTheme(
      spacing: spacing == null ? this.spacing : spacing(),
      keyPadding: keyPadding == null ? this.keyPadding : keyPadding(),
      keyShadow: keyShadow == null ? this.keyShadow : keyShadow(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KeyboardShortcutTheme &&
        other.spacing == spacing &&
        other.keyPadding == keyPadding &&
        listEquals(other.keyShadow, keyShadow);
  }

  @override
  int get hashCode => Object.hash(spacing, keyPadding, keyShadow);
}

/// Handle for managing custom keyboard key display rendering.
///
/// [KeyboardShortcutDisplayHandle] wraps a [KeyboardShortcutDisplayBuilder]
/// function to provide a convenient interface for rendering custom keyboard
/// key displays. It acts as a bridge between the shortcut widget and custom
/// key rendering logic.
///
/// This handle allows components to customize how individual keyboard keys
/// are displayed while maintaining a consistent interface for key rendering
/// across different shortcut contexts.
///
/// Example:
/// ```dart
/// final customHandle = KeyboardShortcutDisplayHandle(
///   (context, key) => Container(
///     padding: EdgeInsets.all(6),
///     decoration: BoxDecoration(
///       color: Theme.of(context).colorScheme.secondary,
///       borderRadius: BorderRadius.circular(4),
///     ),
///     child: Text(key.keyLabel),
///   ),
/// );
/// 
/// // Use with keyboard shortcut widgets
/// final display = customHandle.buildKeyboardDisplay(context, LogicalKeyboardKey.enter);
/// ```
class KeyboardShortcutDisplayHandle {
  /// The builder function for creating keyboard key displays.
  final KeyboardShortcutDisplayBuilder _builder;

  /// Creates a [KeyboardShortcutDisplayHandle] with the specified builder.
  ///
  /// Parameters:
  /// - [_builder] (KeyboardShortcutDisplayBuilder): Function to render key displays
  const KeyboardShortcutDisplayHandle(this._builder);

  /// Builds a widget representation of the specified keyboard key.
  ///
  /// Uses the internal builder function to create a visual representation
  /// of the keyboard key appropriate for the current context and theme.
  ///
  /// Parameters:
  /// - [context] (BuildContext): Build context for theme access
  /// - [key] (LogicalKeyboardKey): The key to display
  ///
  /// Returns: Widget - The visual representation of the keyboard key
  Widget buildKeyboardDisplay(BuildContext context, LogicalKeyboardKey key) {
    return _builder(context, key);
  }
}

class KeyboardShortcutDisplayMapper extends StatefulWidget {
  static Widget _defaultBuilder(BuildContext context, LogicalKeyboardKey key) {
    switch (key) {
      case LogicalKeyboardKey.control:
      case LogicalKeyboardKey.controlLeft:
      case LogicalKeyboardKey.controlRight:
        return const Text('Ctrl');
      case LogicalKeyboardKey.shift:
      case LogicalKeyboardKey.shiftLeft:
      case LogicalKeyboardKey.shiftRight:
        return const Text('Shift');
      case LogicalKeyboardKey.alt:
      case LogicalKeyboardKey.altLeft:
      case LogicalKeyboardKey.altRight:
        return const Text('Alt');
      case LogicalKeyboardKey.meta:
      case LogicalKeyboardKey.metaLeft:
      case LogicalKeyboardKey.metaRight:
        return const Text('⌘');
      case LogicalKeyboardKey.enter:
        return const Text('↵');
      case LogicalKeyboardKey.arrowLeft:
        return const Text('←');
      case LogicalKeyboardKey.arrowRight:
        return const Text('→');
      case LogicalKeyboardKey.arrowUp:
        return const Text('↑');
      case LogicalKeyboardKey.arrowDown:
        return const Text('↓');
      default:
        return Text(key.keyLabel);
    }
  }

  final KeyboardShortcutDisplayBuilder builder;
  final Widget child;

  const KeyboardShortcutDisplayMapper({
    super.key,
    this.builder = _defaultBuilder,
    required this.child,
  });

  @override
  State<KeyboardShortcutDisplayMapper> createState() =>
      _KeyboardShortcutDisplayMapperState();
}

class _KeyboardShortcutDisplayMapperState
    extends State<KeyboardShortcutDisplayMapper> {
  late KeyboardShortcutDisplayHandle _handle;

  @override
  void initState() {
    super.initState();
    _handle = KeyboardShortcutDisplayHandle(widget.builder);
  }

  @override
  void didUpdateWidget(covariant KeyboardShortcutDisplayMapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.builder != widget.builder) {
      _handle = KeyboardShortcutDisplayHandle(widget.builder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: _handle,
      child: widget.child,
    );
  }
}

/// A widget that displays keyboard shortcuts in a visually appealing format.
///
/// Renders keyboard key combinations as styled keyboard key representations,
/// typically used in tooltips, help text, or UI elements that need to
/// communicate keyboard shortcuts to users. The display automatically
/// formats keys with appropriate spacing and visual styling.
///
/// Supports both direct key specification through a list of [LogicalKeyboardKey]
/// objects and automatic conversion from [ShortcutActivator] instances.
/// Keys are displayed as individual key representations with configurable
/// spacing between them.
///
/// The component integrates with the keyboard shortcut theming system
/// and adapts its appearance based on the current theme and scaling settings.
/// Visual styling matches platform conventions for keyboard key representations.
///
/// Example:
/// ```dart
/// KeyboardDisplay(
///   keys: [
///     LogicalKeyboardKey.controlLeft,
///     LogicalKeyboardKey.keyS,
///   ],
///   spacing: 4.0,
/// )
/// ```
class KeyboardDisplay extends StatelessWidget {
  /// List of keyboard keys to display when using direct key specification.
  final List<LogicalKeyboardKey>? _keys;

  /// Shortcut activator to convert to keyboard keys for display.
  final ShortcutActivator? _activator;

  /// Spacing between individual keyboard key displays.
  ///
  /// Controls the horizontal gap between adjacent key representations.
  /// When null, uses theme-appropriate default spacing.
  final double? spacing;

  /// Creates a [KeyboardDisplay] from a list of keyboard keys.
  ///
  /// Displays the specified keyboard keys as styled key representations
  /// with appropriate spacing. This constructor allows direct control
  /// over which keys are displayed.
  ///
  /// Parameters:
  /// - [keys] (List<LogicalKeyboardKey>, required): Keys to display
  /// - [spacing] (double?, optional): Gap between key displays
  ///
  /// Example:
  /// ```dart
  /// KeyboardDisplay(
  ///   keys: [LogicalKeyboardKey.alt, LogicalKeyboardKey.tab],
  ///   spacing: 6.0,
  /// )
  /// ```
  const KeyboardDisplay({
    super.key,
    required List<LogicalKeyboardKey> keys,
    this.spacing,
  })  : _keys = keys,
        _activator = null;

  /// Creates a [KeyboardDisplay] from a shortcut activator.
  ///
  /// Automatically extracts the keyboard keys from the provided
  /// [ShortcutActivator] and displays them as styled key representations.
  /// This constructor is convenient when working with Flutter's shortcut system.
  ///
  /// Parameters:
  /// - [activator] (ShortcutActivator, required): Shortcut to extract keys from
  /// - [spacing] (double?, optional): Gap between key displays
  ///
  /// Example:
  /// ```dart
  /// KeyboardDisplay.fromActivator(
  ///   activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
  ///   spacing: 4.0,
  /// )
  /// ```
  const KeyboardDisplay.fromActivator({
    super.key,
    required ShortcutActivator activator,
    this.spacing,
  })  : _keys = null,
        _activator = activator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<KeyboardShortcutTheme>(context);
    var keys = _keys ?? shortcutActivatorToKeySet(_activator!);
    final spacing = styleValue(
        widgetValue: this.spacing,
        themeValue: compTheme?.spacing,
        defaultValue: 2 * theme.scaling);
    return Row(
            mainAxisSize: MainAxisSize.min,
            children: keys
                .map((key) => KeyboardKeyDisplay(keyboardKey: key))
                .toList())
        .gap(spacing);
  }
}

/// A widget that displays a single keyboard key in a styled format.
///
/// Renders an individual keyboard key as a styled representation that
/// resembles a physical keyboard key. Used internally by [KeyboardDisplay]
/// but can also be used standalone for displaying individual keys.
///
/// The key display automatically formats the key label based on the
/// [LogicalKeyboardKey] and applies appropriate styling including
/// padding, shadows, and theme-consistent appearance.
///
/// Example:
/// ```dart
/// KeyboardKeyDisplay(
///   keyboardKey: LogicalKeyboardKey.controlLeft,
///   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
/// )
/// ```
class KeyboardKeyDisplay extends StatelessWidget {
  /// The keyboard key to display.
  ///
  /// Specifies which keyboard key should be rendered. The display
  /// automatically formats the key label and applies appropriate styling.
  final LogicalKeyboardKey keyboardKey;

  /// Internal padding applied within the key display.
  ///
  /// Controls spacing around the key label text. When null,
  /// uses theme-appropriate default padding for key displays.
  final EdgeInsetsGeometry? padding;

  /// Box shadows applied to the key display for depth effect.
  ///
  /// Creates visual depth to simulate the appearance of physical
  /// keyboard keys. When null, uses theme default shadows.
  final List<BoxShadow>? boxShadow;

  /// Creates a [KeyboardKeyDisplay] for the specified keyboard key.
  ///
  /// The [keyboardKey] parameter is required and determines which
  /// key is displayed. Visual appearance can be customized through
  /// the optional padding and shadow parameters.
  ///
  /// Parameters:
  /// - [keyboardKey] (LogicalKeyboardKey, required): Key to display
  /// - [padding] (EdgeInsetsGeometry?, optional): Internal padding
  /// - [boxShadow] (List<BoxShadow>?, optional): Shadow effects
  ///
  /// Example:
  /// ```dart
  /// KeyboardKeyDisplay(
  ///   keyboardKey: LogicalKeyboardKey.escape,
  ///   padding: EdgeInsets.all(6),
  /// )
  /// ```
  const KeyboardKeyDisplay({
    super.key,
    required this.keyboardKey,
    this.padding,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final displayMapper = Data.of<KeyboardShortcutDisplayHandle>(context);
    final theme = Theme.of(context);
    final directionality = Directionality.of(context);
    final compTheme = ComponentTheme.maybeOf<KeyboardShortcutTheme>(context);
    final padding = styleValue(
                widgetValue: this.padding,
                themeValue: compTheme?.keyPadding,
                defaultValue:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 4))
            .resolve(directionality) *
        theme.scaling;
    return Card(
      padding: padding,
      borderRadius: theme.borderRadiusMd,
      fillColor: theme.colorScheme.background.scaleAlpha(0.7),
      filled: true,
      child: displayMapper.buildKeyboardDisplay(context, keyboardKey),
    );
  }
}

List<LogicalKeyboardKey> shortcutActivatorToKeySet(
    ShortcutActivator activator) {
  List<LogicalKeyboardKey> keys = [];
  if (activator is CharacterActivator) {
    if (activator.control) {
      keys.add(LogicalKeyboardKey.control);
    }
    if (activator.alt) {
      keys.add(LogicalKeyboardKey.alt);
    }
    if (activator.meta) {
      keys.add(LogicalKeyboardKey.meta);
    }
    keys.add(LogicalKeyboardKey(activator.character.codeUnitAt(0)));
  }
  if (activator is SingleActivator) {
    if (activator.control) {
      keys.add(LogicalKeyboardKey.control);
    }
    if (activator.alt) {
      keys.add(LogicalKeyboardKey.alt);
    }
    if (activator.meta) {
      keys.add(LogicalKeyboardKey.meta);
    }
    if (activator.shift) {
      keys.add(LogicalKeyboardKey.shift);
    }
    keys.add(activator.trigger);
  }
  if (activator is LogicalKeySet) {
    for (final trigger in activator.triggers) {
      keys.add(trigger);
    }
  }
  return keys;
}
