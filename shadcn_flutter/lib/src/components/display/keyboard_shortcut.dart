import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef KeyboardShortcutDisplayBuilder = Widget Function(
  BuildContext context,
  LogicalKeyboardKey key,
);

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
      default:
        return Text(key.keyLabel);
    }
  }

  final KeyboardShortcutDisplayBuilder builder;
  final Widget child;

  const KeyboardShortcutDisplayMapper({
    Key? key,
    this.builder = _defaultBuilder,
    required this.child,
  }) : super(key: key);

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
    var keys = _keys;
    if (keys == null) {
      keys = [];
      var activator = _activator;
      if (activator is CharacterActivator) {
        if (activator.meta) {
          keys.add(LogicalKeyboardKey.meta);
        }
        if (activator.alt) {
          keys.add(LogicalKeyboardKey.alt);
        }
        if (activator.control) {
          keys.add(LogicalKeyboardKey.control);
        }
        keys.add(LogicalKeyboardKey(activator.character.codeUnitAt(0)));
      }
      if (activator is SingleActivator) {
        if (activator.shift) {
          keys.add(LogicalKeyboardKey.shift);
        }
        if (activator.meta) {
          keys.add(LogicalKeyboardKey.meta);
        }
        if (activator.alt) {
          keys.add(LogicalKeyboardKey.alt);
        }
        if (activator.control) {
          keys.add(LogicalKeyboardKey.control);
        }
        keys.add(activator.trigger);
      }
    }
    return Row(
            mainAxisSize: MainAxisSize.min,
            children: keys
                .map((key) => KeyboardKeyDisplay(keyboardKey: key))
                .toList())
        .gap(spacing ?? (2 * theme.scaling));
  }
}

class KeyboardKeyDisplay extends StatelessWidget {
  final LogicalKeyboardKey keyboardKey;
  final EdgeInsetsGeometry? padding;

  const KeyboardKeyDisplay({
    Key? key,
    required this.keyboardKey,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayMapper = Data.of<KeyboardShortcutDisplayHandle>(context);
    final theme = Theme.of(context);
    return Card(
      padding: padding ??
          (const EdgeInsets.symmetric(horizontal: 6, vertical: 4) *
              theme.scaling),
      boxShadow: [
        BoxShadow(
          color: theme.colorScheme.border,
          blurRadius: 0,
          blurStyle: BlurStyle.solid,
          offset: const Offset(0, -2) * theme.scaling,
        ),
      ],
      child: displayMapper.buildKeyboardDisplay(context, keyboardKey),
    );
  }
}
