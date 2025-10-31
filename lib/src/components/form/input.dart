import 'dart:async';

import 'package:flutter/services.dart' show Clipboard, LogicalKeyboardKey;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Position where an input feature is displayed.
///
/// Determines whether an input feature (icon, button, widget) appears on
/// the leading (left/start) or trailing (right/end) side of the input.
enum InputFeaturePosition {
  /// Display the feature on the leading side.
  leading,

  /// Display the feature on the trailing side.
  trailing,
}

/// Adds a hint/info button to the input field with a popover.
///
/// Displays an icon button that shows a popover with additional information
/// when clicked. Optionally supports keyboard shortcuts (F1) to open the hint.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputHintFeature(
///       popupBuilder: (context) => const Text('Enter your email'),
///       icon: Icon(Icons.help),
///     ),
///   ],
/// )
/// ```
class InputHintFeature extends InputFeature {
  /// Builder for the hint popover content.
  final WidgetBuilder popupBuilder;

  /// Custom icon to display (defaults to info icon).
  final Widget? icon;

  /// Position of the hint button.
  final InputFeaturePosition position;

  /// Whether to enable keyboard shortcut (F1) to show the hint.
  final bool enableShortcuts;

  /// Creates an [InputHintFeature].
  ///
  /// Parameters:
  /// - [popupBuilder] (`WidgetBuilder`, required): Builds the hint content.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the hint icon.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [enableShortcuts] (`bool`, default: `true`): Enable F1 keyboard shortcut.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputHintFeature({
    super.visibility,
    super.skipFocusTraversal,
    required this.popupBuilder,
    this.position = InputFeaturePosition.trailing,
    this.icon,
    this.enableShortcuts = true,
  });

  @override
  InputFeatureState createState() => _InputHintFeatureState();
}

class _InputHintFeatureState extends InputFeatureState<InputHintFeature> {
  final _popoverController = PopoverController();
  void _showPopup(BuildContext context) {
    _popoverController.show(
      context: context,
      builder: feature.popupBuilder,
      alignment: AlignmentDirectional.topCenter,
      anchorAlignment: AlignmentDirectional.bottomCenter,
    );
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield Builder(builder: (context) {
        return IconButton.text(
          icon: feature.icon ?? const Icon(LucideIcons.info),
          onPressed: () => _showPopup(context),
          density: ButtonDensity.compact,
        );
      });
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.info),
        onPressed: () => _showPopup(context),
        density: ButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts() sync* {
    if (feature.enableShortcuts) {
      yield const MapEntry(
        SingleActivator(LogicalKeyboardKey.f1),
        InputShowHintIntent(),
      );
    }
  }

  @override
  Iterable<MapEntry<Type, Action<Intent>>> buildActions() sync* {
    if (feature.enableShortcuts) {
      yield MapEntry(
        InputShowHintIntent,
        CallbackContextAction<InputShowHintIntent>(
          onInvoke: (intent, [context]) {
            if (context == null) {
              throw FlutterError(
                  'CallbackContextAction was invoked without a valid BuildContext. '
                  'This likely indicates a problem in the action system. '
                  'Context must not be null when invoking InputShowHintIntent.');
            }
            _showPopup(context);
            return true;
          },
        ),
      );
    }
  }
}

/// Intent to show an input hint popover.
///
/// Used in keyboard shortcut actions to trigger the hint display.
class InputShowHintIntent extends Intent {
  /// Creates an [InputShowHintIntent].
  const InputShowHintIntent();
}

/// Mode for password visibility toggling.
///
/// Determines whether the password visibility toggle holds (shows while pressed)
/// or toggles (switches state on each press).
enum PasswordPeekMode {
  /// Show password only while button is held down.
  hold,

  /// Toggle password visibility on each press.
  toggle,
}

/// Adds a password visibility toggle feature to the input field.
///
/// Provides a button that allows users to toggle between showing and hiding
/// password text. Supports both hold-to-reveal and toggle modes.
///
/// Example:
/// ```dart
/// TextField(
///   obscureText: true,
///   features: [
///     InputPasswordToggleFeature(
///       mode: PasswordPeekMode.toggle,
///     ),
///   ],
/// )
/// ```
class InputPasswordToggleFeature extends InputFeature {
  /// The mode for password peeking behavior.
  final PasswordPeekMode mode;

  /// Position of the toggle button.
  final InputFeaturePosition position;

  /// Icon to display when password is hidden.
  final Widget? icon;

  /// Icon to display when password is shown.
  final Widget? iconShow;

  /// Creates an [InputPasswordToggleFeature].
  ///
  /// Parameters:
  /// - [mode] (`PasswordPeekMode`, default: `PasswordPeekMode.toggle`):
  ///   Toggle or hold behavior.
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the toggle.
  /// - [icon] (`Widget?`, optional): Custom icon for hidden state.
  /// - [iconShow] (`Widget?`, optional): Custom icon for visible state.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputPasswordToggleFeature({
    super.visibility,
    this.icon,
    this.iconShow,
    this.mode = PasswordPeekMode.toggle,
    this.position = InputFeaturePosition.trailing,
    super.skipFocusTraversal,
  });

  @override
  InputFeatureState createState() => _InputPasswordToggleFeatureState();
}

class _InputPasswordToggleFeatureState
    extends InputFeatureState<InputPasswordToggleFeature> {
  bool? _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      if (_obscureText == null) {
        _obscureText = true;
      } else {
        _obscureText = null;
      }
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield _buildIconButton();
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield _buildIconButton();
    }
  }

  Widget _buildIcon() {
    if (_obscureText == true || input.obscureText) {
      return feature.icon ?? const Icon(LucideIcons.eye);
    }
    return feature.iconShow ?? const Icon(LucideIcons.eyeOff);
  }

  Widget _buildIconButton() {
    if (feature.mode == PasswordPeekMode.hold) {
      return IconButton.text(
        icon: _buildIcon(),
        onTapDown: (_) {
          setState(() {
            _obscureText = null;
          });
        },
        onTapUp: (_) {
          setState(() {
            _obscureText = true;
          });
        },
        enabled: true,
        density: ButtonDensity.compact,
      );
    }
    return IconButton.text(
      icon: _buildIcon(),
      onPressed: _toggleObscureText,
      density: ButtonDensity.compact,
    );
  }

  @override
  TextField interceptInput(TextField input) {
    return input.copyWith(
      obscureText: () => _obscureText ?? false,
    );
  }
}

/// Adds a clear button to the input field.
///
/// Provides a button that clears all text from the input when pressed.
/// Commonly used to improve user experience by offering quick text removal.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputClearFeature(
///       position: InputFeaturePosition.trailing,
///     ),
///   ],
/// )
/// ```
class InputClearFeature extends InputFeature {
  /// Position of the clear button.
  final InputFeaturePosition position;

  /// Custom icon for the clear button.
  final Widget? icon;

  /// Creates an [InputClearFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the clear button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputClearFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = InputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputClearFeatureState();
}

class _InputClearFeatureState extends InputFeatureState<InputClearFeature> {
  void _clear() {
    controller.text = '';
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.x),
        onPressed: _clear,
        density: ButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.x),
        onPressed: _clear,
        density: ButtonDensity.compact,
      );
    }
  }
}

/// Adds a revalidate button to the input field.
///
/// Provides a button that triggers form validation when pressed.
/// Useful for manually triggering validation after user input.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputRevalidateFeature(),
///   ],
/// )
/// ```
class InputRevalidateFeature extends InputFeature {
  /// Position of the revalidate button.
  final InputFeaturePosition position;

  /// Custom icon for the revalidate button.
  final Widget? icon;

  /// Creates an [InputRevalidateFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the revalidate button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputRevalidateFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = InputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputRevalidateFeatureState();
}

class _InputRevalidateFeatureState
    extends InputFeatureState<InputRevalidateFeature> {
  void _revalidate() {
    var formFieldHandle = Data.maybeFind<FormFieldHandle>(context);
    if (formFieldHandle != null) {
      formFieldHandle.revalidate();
    }
  }

  Widget _buildIcon() {
    return FormPendingBuilder(
      builder: (context, futures, _) {
        if (futures.isEmpty) {
          return IconButton.text(
            icon: feature.icon ?? const Icon(LucideIcons.refreshCw),
            onPressed: _revalidate,
            density: ButtonDensity.compact,
          );
        }

        var futureAll = Future.wait(futures.values);
        return FutureBuilder(
          future: futureAll,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return IconButton.text(
                icon: RepeatedAnimationBuilder(
                  start: 0.0,
                  end: 360.0,
                  duration: const Duration(seconds: 1),
                  child: feature.icon ?? const Icon(LucideIcons.refreshCw),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: degToRad(value),
                      child: child,
                    );
                  },
                ),
                onPressed: null,
                density: ButtonDensity.compact,
              );
            }
            return IconButton.text(
              icon: feature.icon ?? const Icon(LucideIcons.refreshCw),
              onPressed: _revalidate,
              density: ButtonDensity.compact,
            );
          },
        );
      },
    );
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield _buildIcon();
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield _buildIcon();
    }
  }
}

/// A callback that provides suggestions based on a query string.
///
/// Parameters:
/// - [query] (`String`): The current input text to generate suggestions for.
///
/// Returns: `FutureOr<Iterable<String>>` — The list of suggestion strings.
typedef SuggestionBuilder = FutureOr<Iterable<String>> Function(String query);

/// Adds autocomplete functionality to the input field.
///
/// Displays a popover with suggestions as the user types. Suggestions are
/// provided by the [querySuggestions] callback and can be selected to fill
/// the input.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputAutoCompleteFeature(
///       querySuggestions: (query) async {
///         return ['apple', 'apricot', 'avocado']
///             .where((s) => s.startsWith(query));
///       },
///       child: const Text('Fruits'),
///     ),
///   ],
/// )
/// ```
class InputAutoCompleteFeature extends InputFeature {
  /// Callback to provide suggestions for a given query.
  final SuggestionBuilder querySuggestions;

  /// Child widget displayed in the suggestion list.
  final Widget child;

  /// Constraints for the popover size.
  final BoxConstraints? popoverConstraints;

  /// Width constraint for the popover.
  final PopoverConstraint? popoverWidthConstraint;

  /// Anchor alignment for the popover.
  final AlignmentDirectional? popoverAnchorAlignment;

  /// Popover alignment relative to the anchor.
  final AlignmentDirectional? popoverAlignment;

  /// Autocomplete mode (e.g., popover or inline).
  final AutoCompleteMode mode;

  /// Creates an [InputAutoCompleteFeature].
  ///
  /// Parameters:
  /// - [querySuggestions] (`SuggestionBuilder`, required): Provides suggestions.
  /// - [child] (`Widget`, required): Content for suggestion items.
  /// - [popoverConstraints] (`BoxConstraints?`, optional): Size constraints.
  /// - [popoverWidthConstraint] (`PopoverConstraint?`, optional): Width constraint.
  /// - [popoverAnchorAlignment] (`AlignmentDirectional?`, optional): Anchor alignment.
  /// - [popoverAlignment] (`AlignmentDirectional?`, optional): Popover alignment.
  /// - [mode] (`AutoCompleteMode`, required): Autocomplete display mode.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAutoCompleteFeature({
    super.visibility,
    super.skipFocusTraversal,
    required this.querySuggestions,
    required this.child,
    this.popoverConstraints,
    this.popoverWidthConstraint,
    this.popoverAnchorAlignment,
    this.popoverAlignment,
    this.mode = AutoCompleteMode.replaceWord,
  });

  @override
  InputFeatureState createState() => _AutoCompleteFeatureState();
}

class _AutoCompleteFeatureState
    extends InputFeatureState<InputAutoCompleteFeature> {
  final GlobalKey _key = GlobalKey();
  final ValueNotifier<FutureOr<Iterable<String>>?> _suggestions =
      ValueNotifier(null);

  @override
  void onTextChanged(String text) {
    _suggestions.value = feature.querySuggestions(text);
  }

  @override
  Widget wrap(Widget child) {
    return ListenableBuilder(
      listenable: _suggestions,
      builder: (context, child) {
        var suggestions = _suggestions.value;
        if (suggestions is Future<Iterable<String>>) {
          return FutureBuilder(
            future: suggestions,
            builder: (context, snapshot) {
              return AutoComplete(
                key: _key,
                suggestions:
                    snapshot.hasData ? snapshot.requireData.toList() : const [],
                popoverConstraints: feature.popoverConstraints,
                popoverWidthConstraint: feature.popoverWidthConstraint,
                popoverAnchorAlignment: feature.popoverAnchorAlignment,
                popoverAlignment: feature.popoverAlignment,
                mode: feature.mode,
                child: child!,
              );
            },
          );
        }
        return AutoComplete(
          key: _key,
          suggestions: suggestions == null ? const [] : suggestions.toList(),
          popoverConstraints: feature.popoverConstraints,
          popoverWidthConstraint: feature.popoverWidthConstraint,
          popoverAnchorAlignment: feature.popoverAnchorAlignment,
          popoverAlignment: feature.popoverAlignment,
          mode: feature.mode,
          child: child!,
        );
      },
      child: child,
    );
  }
}

/// Adds spinner controls (increment/decrement) to numeric input fields.
///
/// Provides up/down buttons to adjust numeric values in fixed steps.
/// Optionally supports gesture-based adjustments (e.g., drag to change value).
///
/// Example:
/// ```dart
/// TextField(
///   keyboardType: TextInputType.number,
///   features: [
///     InputSpinnerFeature(
///       step: 5.0,
///       enableGesture: true,
///     ),
///   ],
/// )
/// ```
class InputSpinnerFeature extends InputFeature {
  /// The amount to increment or decrement on each step.
  final double step;

  /// Whether to enable gesture-based value adjustment.
  final bool enableGesture;

  /// Default value when the input is invalid or empty.
  final double? invalidValue;

  /// Creates an [InputSpinnerFeature].
  ///
  /// Parameters:
  /// - [step] (`double`, default: `1.0`): Increment/decrement step size.
  /// - [enableGesture] (`bool`, default: `true`): Enable drag gestures.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputSpinnerFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.step = 1.0,
    this.enableGesture = true,
    this.invalidValue = 0.0,
  });

  @override
  InputFeatureState createState() => _InputSpinnerFeatureState();
}

class _InputSpinnerFeatureState extends InputFeatureState<InputSpinnerFeature> {
  void _replaceText(UnaryOperator<String> replacer) {
    var controller = this.controller;
    var text = controller.text;
    var newText = replacer(text);
    if (newText != text) {
      controller.text = newText;
      input.onChanged?.call(newText);
    }
  }

  void _increase() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(feature.invalidValue!);
        }
        return text;
      }
      return _newText(value + feature.step);
    });
  }

  String _newText(double value) {
    String newText = value.toString();
    if (newText.contains('.')) {
      while (newText.endsWith('0')) {
        newText = newText.substring(0, newText.length - 1);
      }
      if (newText.endsWith('.')) {
        newText = newText.substring(0, newText.length - 1);
      }
    }
    return newText;
  }

  void _decrease() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(feature.invalidValue!);
        }
        return text;
      }
      return _newText(value - feature.step);
    });
  }

  Widget _wrapGesture(Widget child) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          _increase();
        } else {
          _decrease();
        }
      },
      child: child,
    );
  }

  Widget _buildButtons() {
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton.text(
            icon: Transform.translate(
              offset: Offset(0, -1 * theme.scaling),
              child: Transform.scale(
                alignment: Alignment.center,
                scale: 1.5,
                child: const Icon(LucideIcons.chevronUp),
              ),
            ),
            onPressed: _increase,
            density: ButtonDensity.compact,
            size: ButtonSize.xSmall,
          ),
          IconButton.text(
            icon: Transform.translate(
              offset: Offset(0, 1 * theme.scaling),
              child: Transform.scale(
                alignment: Alignment.center,
                scale: 1.5,
                child: const Icon(LucideIcons.chevronDown),
              ),
            ),
            onPressed: _decrease,
            density: ButtonDensity.compact,
            size: ButtonSize.xSmall,
          ),
        ],
      );
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.enableGesture) {
      yield _wrapGesture(_buildButtons());
    } else {
      yield _buildButtons();
    }
  }
}

/// Adds a copy button to the input field.
///
/// Provides a button that copies the current input text to the clipboard.
/// Useful for allowing users to easily copy generated or displayed content.
///
/// Example:
/// ```dart
/// TextField(
///   controller: TextEditingController(text: 'Copy me!'),
///   features: [
///     InputCopyFeature(),
///   ],
/// )
/// ```
class InputCopyFeature extends InputFeature {
  /// Position of the copy button.
  final InputFeaturePosition position;

  /// Custom icon for the copy button.
  final Widget? icon;

  /// Creates an [InputCopyFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the copy button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputCopyFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = InputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputCopyFeatureState();
}

class _InputCopyFeatureState extends InputFeatureState<InputCopyFeature> {
  void _copy() {
    Actions.invoke(context, const TextFieldSelectAllAndCopyIntent());
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.copy),
        onPressed: _copy,
        density: ButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.copy),
        onPressed: _copy,
        density: ButtonDensity.compact,
      );
    }
  }
}

/// Adds a custom widget to the leading (left) side of the input field.
///
/// Allows you to place any widget before the input text, such as icons,
/// labels, or other decorative elements.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputLeadingFeature(
///       Icon(Icons.search),
///     ),
///   ],
/// )
/// ```
class InputLeadingFeature extends InputFeature {
  /// The widget to display on the leading side.
  final Widget prefix;

  /// Creates an [InputLeadingFeature].
  ///
  /// Parameters:
  /// - [prefix] (`Widget`, required): The widget to show before the input.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputLeadingFeature(
    this.prefix, {
    super.visibility,
    super.skipFocusTraversal,
  });

  @override
  InputFeatureState createState() => _InputLeadingFeatureState();
}

class _InputLeadingFeatureState extends InputFeatureState<InputLeadingFeature> {
  @override
  Iterable<Widget> buildLeading() sync* {
    yield feature.prefix;
  }
}

/// Adds a custom widget to the trailing (right) side of the input field.
///
/// Allows you to place any widget after the input text, such as icons,
/// buttons, or other decorative elements.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputTrailingFeature(
///       Icon(Icons.arrow_forward),
///     ),
///   ],
/// )
/// ```
class InputTrailingFeature extends InputFeature {
  /// The widget to display on the trailing side.
  final Widget suffix;

  /// Creates an [InputTrailingFeature].
  ///
  /// Parameters:
  /// - [suffix] (`Widget`, required): The widget to show after the input.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputTrailingFeature(
    this.suffix, {
    super.visibility,
    super.skipFocusTraversal,
  });

  @override
  InputFeatureState createState() => _InputTrailingFeatureState();
}

class _InputTrailingFeatureState
    extends InputFeatureState<InputTrailingFeature> {
  @override
  Iterable<Widget> buildTrailing() sync* {
    yield feature.suffix;
  }
}

/// Adds a paste button to the input field.
///
/// Provides a button that pastes content from the clipboard into the input.
/// Useful for improving user experience when entering copied data.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputPasteFeature(
///       position: InputFeaturePosition.trailing,
///     ),
///   ],
/// )
/// ```
class InputPasteFeature extends InputFeature {
  /// Position of the paste button.
  final InputFeaturePosition position;

  /// Custom icon for the paste button.
  final Widget? icon;

  /// Creates an [InputPasteFeature].
  ///
  /// Parameters:
  /// - [position] (`InputFeaturePosition`, default: `InputFeaturePosition.trailing`):
  ///   Where to place the paste button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`InputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputPasteFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = InputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputPasteFeatureState();
}

class _InputPasteFeatureState extends InputFeatureState<InputPasteFeature> {
  void _paste() {
    var clipboardData = Clipboard.getData('text/plain');
    clipboardData.then((value) {
      if (value != null) {
        var text = value.text;
        if (text != null && text.isNotEmpty && context.mounted) {
          Actions.invoke(context, TextFieldAppendTextIntent(text: text));
        }
      }
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.clipboard),
        onPressed: _paste,
        density: ButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield IconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.clipboard),
        onPressed: _paste,
        density: ButtonDensity.compact,
      );
    }
  }
}
