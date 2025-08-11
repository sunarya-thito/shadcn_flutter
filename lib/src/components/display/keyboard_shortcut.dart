import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef KeyboardShortcutDisplayBuilder = Widget Function(
  BuildContext context,
  LogicalKeyboardKey key,
);

/// Theme for keyboard shortcut displays.
class KeyboardShortcutTheme {
  /// Spacing between keys.
  final double? spacing;

  /// Padding inside each key display.
  final EdgeInsetsGeometry? keyPadding;

  /// Shadow applied to key displays.
  final List<BoxShadow>? keyShadow;

  /// Creates a [KeyboardShortcutTheme].
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

class KeyboardShortcutDisplayHandle {
  final KeyboardShortcutDisplayBuilder _builder;

  const KeyboardShortcutDisplayHandle(this._builder);

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

class KeyboardDisplay extends StatelessWidget {
  final List<LogicalKeyboardKey>? _keys;
  final ShortcutActivator? _activator;
  final double? spacing;

  const KeyboardDisplay({
    super.key,
    required List<LogicalKeyboardKey> keys,
    this.spacing,
  })  : _keys = keys,
        _activator = null;

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

class KeyboardKeyDisplay extends StatelessWidget {
  final LogicalKeyboardKey keyboardKey;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;

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
