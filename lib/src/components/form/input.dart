import 'dart:async';

import 'package:flutter/services.dart' show Clipboard, LogicalKeyboardKey;
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Defines positioning options for input features relative to the text field.
///
/// Input features can be positioned either at the leading (left in LTR layouts)
/// or trailing (right in LTR layouts) edge of the input field. This positioning
/// affects the visual layout and user interaction patterns.
///
/// Used by various input feature implementations to determine their placement
/// within the input field's layout structure.
enum InputFeaturePosition {
  /// Position the feature at the leading edge of the input field.
  ///
  /// In left-to-right layouts, this positions the feature on the left side.
  /// In right-to-left layouts, this positions the feature on the right side.
  leading,

  /// Position the feature at the trailing edge of the input field.
  ///
  /// In left-to-right layouts, this positions the feature on the right side.
  /// In right-to-left layouts, this positions the feature on the left side.
  trailing,
}

/// Input feature that displays contextual hints in a popup interface.
///
/// [InputHintFeature] provides users with additional information or guidance
/// about the input field through a popup that can be triggered by clicking an
/// icon or using keyboard shortcuts (F1 by default).
///
/// The feature integrates seamlessly with the input field's layout system,
/// positioning itself according to the specified [position] and providing
/// consistent visual styling through the button density and icon systems.
///
/// Key capabilities:
/// - Popup-based help content with custom widget builders
/// - Configurable positioning (leading or trailing)
/// - Keyboard shortcut support (F1 by default)
/// - Custom icon override capability
/// - Consistent styling with compact button density
/// - Integration with the popover overlay system
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputHintFeature(
///       popupBuilder: (context) => Container(
///         padding: EdgeInsets.all(16),
///         child: Text('Enter your email address here'),
///       ),
///       icon: Icon(LucideIcons.helpCircle),
///       position: InputFeaturePosition.trailing,
///     ),
///   ],
/// );
/// ```
class InputHintFeature extends InputFeature {
  /// Builder function that creates the popup content when the hint is shown.
  ///
  /// The provided [BuildContext] can be used to access theme data and other
  /// contextual information for styling the hint content. The builder should
  /// return a widget that provides helpful information to the user.
  final WidgetBuilder popupBuilder;

  /// Optional custom icon to display instead of the default info icon.
  ///
  /// When null, displays [LucideIcons.info] as the default hint trigger icon.
  /// The icon should be intuitive and indicate that additional help is available.
  final Widget? icon;

  /// Position of the hint feature within the input field layout.
  ///
  /// Defaults to [InputFeaturePosition.trailing] to place the hint icon
  /// on the trailing edge (right side in LTR layouts).
  final InputFeaturePosition position;

  /// Whether to enable keyboard shortcuts for showing the hint popup.
  ///
  /// When true, pressing F1 will show the hint popup. Defaults to true
  /// for improved accessibility and keyboard navigation support.
  final bool enableShortcuts;

  /// Creates an [InputHintFeature].
  ///
  /// The [popupBuilder] is required and defines the content shown in the hint popup.
  /// The [position] defaults to trailing, [icon] defaults to an info icon, and
  /// [enableShortcuts] defaults to true for F1 key support.
  ///
  /// Example:
  /// ```dart
  /// InputHintFeature(
  ///   popupBuilder: (context) => Padding(
  ///     padding: EdgeInsets.all(12),
  ///     child: Text('Enter a valid email address'),
  ///   ),
  ///   position: InputFeaturePosition.trailing,
  ///   enableShortcuts: true,
  /// );
  /// ```
  const InputHintFeature({
    super.visibility,
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

/// Intent action for triggering input hint display via keyboard shortcuts.
///
/// This intent is used by the action system to handle F1 key presses when
/// [InputHintFeature] has keyboard shortcuts enabled. It enables accessible
/// hint access without requiring mouse interaction.
///
/// The intent integrates with Flutter's action system to provide consistent
/// keyboard navigation patterns across the application.
class InputShowHintIntent extends Intent {
  /// Creates an [InputShowHintIntent].
  ///
  /// This intent carries no additional data as it simply triggers the
  /// hint display action for the currently focused input field.
  const InputShowHintIntent();
}

/// Enumeration of password visibility toggle interaction modes.
///
/// Defines how users can interact with password visibility controls,
/// affecting the behavior of the show/hide password functionality in
/// input fields with password toggle features.
enum PasswordPeekMode {
  /// Hold to show password text temporarily.
  ///
  /// Password text is visible only while the user holds down on the toggle
  /// button. When released, the password becomes obscured again. This mode
  /// provides temporary visibility for verification while maintaining security.
  hold,

  /// Toggle to switch between visible and hidden password text.
  ///
  /// Clicking the toggle button switches the password visibility state
  /// persistently until toggled again. This mode allows sustained visibility
  /// for easier password entry and verification.
  toggle,
}

/// Input feature that provides password visibility toggle functionality.
///
/// [InputPasswordToggleFeature] adds a toggle button to password input fields
/// that allows users to switch between obscured and visible text display.
/// This improves usability while maintaining security by giving users control
/// over password visibility during entry and verification.
///
/// The feature supports two interaction modes:
/// - [PasswordPeekMode.toggle]: Persistent visibility toggle
/// - [PasswordPeekMode.hold]: Temporary visibility while holding
///
/// Key features:
/// - Configurable interaction mode (toggle vs hold)
/// - Custom icon support for both show and hide states
/// - Positioning control (leading or trailing)
/// - Automatic icon state management
/// - Integration with input field obscure text property
///
/// Example:
/// ```dart
/// TextField(
///   obscureText: true,
///   features: [
///     InputPasswordToggleFeature(
///       mode: PasswordPeekMode.toggle,
///       position: InputFeaturePosition.trailing,
///       icon: Icon(LucideIcons.eyeOff),
///       iconShow: Icon(LucideIcons.eye),
///     ),
///   ],
/// );
/// ```
class InputPasswordToggleFeature extends InputFeature {
  /// Interaction mode for the password toggle functionality.
  ///
  /// Determines whether the toggle provides persistent visibility switching
  /// ([PasswordPeekMode.toggle]) or temporary visibility while pressed
  /// ([PasswordPeekMode.hold]).
  final PasswordPeekMode mode;

  /// Position of the password toggle within the input field layout.
  ///
  /// Defaults to [InputFeaturePosition.trailing] to place the toggle
  /// on the trailing edge (right side in LTR layouts).
  final InputFeaturePosition position;

  /// Icon displayed when the password is obscured (hidden).
  ///
  /// When null, uses the default eye-off icon to indicate that clicking
  /// will reveal the password text. Should visually suggest the hidden state.
  final Widget? icon;

  /// Icon displayed when the password is visible (shown).
  ///
  /// When null, uses the default eye icon to indicate that clicking will
  /// hide the password text. Should visually suggest the visible state.
  final Widget? iconShow;

  /// Creates an [InputPasswordToggleFeature].
  ///
  /// The [mode] defaults to [PasswordPeekMode.toggle] for persistent visibility
  /// control. The [position] defaults to trailing for conventional placement.
  /// Icons default to standard eye/eye-off representations when not specified.
  ///
  /// Example:
  /// ```dart
  /// InputPasswordToggleFeature(
  ///   mode: PasswordPeekMode.toggle,
  ///   position: InputFeaturePosition.trailing,
  ///   icon: Icon(LucideIcons.eyeOff),
  ///   iconShow: Icon(LucideIcons.eye),
  /// );
  /// ```
  const InputPasswordToggleFeature({
    super.visibility,
    this.icon,
    this.iconShow,
    this.mode = PasswordPeekMode.toggle,
    this.position = InputFeaturePosition.trailing,
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

/// Input feature that provides a clear button to empty the text field.
///
/// [InputClearFeature] adds a clear button (typically an X icon) that allows
/// users to quickly empty the entire contents of a text field with a single
/// tap. This improves user experience by providing an efficient way to reset
/// input without manually selecting and deleting all text.
///
/// The feature integrates with the text field's controller to clear the text
/// and triggers the onChanged callback to notify listeners of the change.
/// The clear button typically appears when the field contains text and
/// disappears when empty.
///
/// Key features:
/// - Single-tap text clearing functionality
/// - Custom icon support (defaults to X icon)
/// - Configurable positioning (leading or trailing)
/// - Automatic integration with text controllers
/// - Callback notification for text changes
/// - Compact button styling for space efficiency
///
/// Example:
/// ```dart
/// TextField(
///   controller: textController,
///   features: [
///     InputClearFeature(
///       position: InputFeaturePosition.trailing,
///       icon: Icon(LucideIcons.x),
///     ),
///   ],
/// );
/// ```
class InputClearFeature extends InputFeature {
  /// Position of the clear button within the input field layout.
  ///
  /// Defaults to [InputFeaturePosition.trailing] to place the clear button
  /// on the trailing edge (right side in LTR layouts) for conventional placement.
  final InputFeaturePosition position;

  /// Optional custom icon to display instead of the default clear icon.
  ///
  /// When null, displays [LucideIcons.x] as the default clear button icon.
  /// The icon should clearly indicate a clear or remove action.
  final Widget? icon;

  /// Creates an [InputClearFeature].
  ///
  /// The [position] defaults to trailing for conventional clear button placement.
  /// The [icon] defaults to an X icon when not specified.
  ///
  /// Example:
  /// ```dart
  /// InputClearFeature(
  ///   position: InputFeaturePosition.trailing,
  ///   icon: Icon(LucideIcons.x),
  /// );
  /// ```
  const InputClearFeature({
    super.visibility,
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

class InputRevalidateFeature extends InputFeature {
  final InputFeaturePosition position;
  final Widget? icon;
  const InputRevalidateFeature({
    super.visibility,
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

/// Type definition for autocomplete suggestion generation functions.
///
/// Takes a query string and returns either a synchronous [Iterable<String>]
/// or an asynchronous [Future<Iterable<String>>] of suggestion strings.
/// This flexibility allows for both static suggestion lists and dynamic
/// suggestions from databases, APIs, or other async sources.
///
/// The query parameter represents the current input text that suggestions
/// should be based on, enabling context-sensitive and filtered suggestions.
typedef SuggestionBuilder = FutureOr<Iterable<String>> Function(String query);

/// Input feature that provides autocomplete functionality with suggestion dropdown.
///
/// [InputAutoCompleteFeature] adds intelligent text completion capabilities
/// to input fields by showing a dropdown list of suggestions based on the
/// current input. It supports both synchronous and asynchronous suggestion
/// generation, making it suitable for static lists and dynamic data sources.
///
/// The feature integrates with the input field to monitor text changes and
/// displays suggestions in a popover that users can navigate and select from.
/// It supports different completion modes and customizable popup styling.
///
/// Key features:
/// - Async and sync suggestion generation support
/// - Configurable popup positioning and constraints
/// - Multiple autocomplete modes (replace word, append, etc.)
/// - Keyboard navigation and selection
/// - Custom suggestion widget rendering
/// - Efficient suggestion filtering and display
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputAutoCompleteFeature(
///       querySuggestions: (query) async {
///         return await searchAPI(query);
///       },
///       child: ListTile(title: Text('Search')),
///       mode: AutoCompleteMode.replaceWord,
///     ),
///   ],
/// );
/// ```
class InputAutoCompleteFeature extends InputFeature {
  /// Function that generates suggestions based on the current query text.
  ///
  /// Can return either synchronous suggestions as [Iterable<String>] or
  /// asynchronous suggestions as [Future<Iterable<String>>]. The query
  /// parameter contains the current input text for context-aware filtering.
  final SuggestionBuilder querySuggestions;

  /// Widget template for rendering individual suggestion items.
  ///
  /// This widget defines how each suggestion appears in the dropdown list.
  /// Typically uses [ListTile] or similar components for consistent styling.
  final Widget child;

  /// Optional constraints for the suggestion popup size.
  ///
  /// When null, the popup adapts to content size within reasonable bounds.
  /// Use this to control maximum height, width, or aspect ratio of suggestions.
  final BoxConstraints? popoverConstraints;

  /// Width constraint mode for the suggestion popup.
  ///
  /// Determines how the popup width relates to the input field width.
  /// Options include flexible sizing, match parent width, or fixed width.
  final PopoverConstraint? popoverWidthConstraint;

  /// Anchor alignment for positioning the suggestion popup.
  ///
  /// Controls how the popup aligns relative to the input field anchor point.
  /// Typical values include top/bottom and start/end alignments.
  final AlignmentDirectional? popoverAnchorAlignment;

  /// Alignment of the popup relative to its anchor.
  ///
  /// Determines the popup's internal alignment when positioned relative
  /// to the anchor point. Affects how content flows within the popup bounds.
  final AlignmentDirectional? popoverAlignment;

  /// Mode determining how selected suggestions modify the input text.
  ///
  /// Defaults to [AutoCompleteMode.replaceWord] for standard word replacement.
  /// Other modes may append text, replace entire input, or use custom logic.
  final AutoCompleteMode mode;

  /// Creates an [InputAutoCompleteFeature].
  ///
  /// Requires [querySuggestions] to generate suggestions and [child] for
  /// rendering. Other parameters provide popup customization options.
  ///
  /// Example:
  /// ```dart
  /// InputAutoCompleteFeature(
  ///   querySuggestions: (query) => ['apple', 'banana', 'cherry']
  ///       .where((item) => item.contains(query)),
  ///   child: ListTile(title: Text('Fruit')),
  ///   mode: AutoCompleteMode.replaceWord,
  /// );
  /// ```
  const InputAutoCompleteFeature({
    super.visibility,
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

/// Input feature that adds numeric spinner controls for value adjustment.
///
/// [InputSpinnerFeature] adds up/down arrow buttons to numeric input fields
/// that allow users to increment or decrement values by a specified step amount.
/// This improves usability for numeric inputs by providing precise value
/// adjustment without manual typing.
///
/// The feature supports both button-based increments and optional gesture-based
/// adjustment via vertical drag gestures. It handles numeric parsing and
/// formatting automatically, with fallback values for invalid input.
///
/// Key features:
/// - Configurable step increment/decrement amount
/// - Up/down arrow button controls
/// - Optional vertical drag gesture support
/// - Automatic numeric value parsing and validation
/// - Fallback value handling for invalid input
/// - Integration with input field onChanged callbacks
/// - Clean numeric formatting (removes trailing zeros)
///
/// Example:
/// ```dart
/// TextField(
///   keyboardType: TextInputType.number,
///   features: [
///     InputSpinnerFeature(
///       step: 0.5,
///       enableGesture: true,
///       invalidValue: 0.0,
///     ),
///   ],
/// );
/// ```
class InputSpinnerFeature extends InputFeature {
  /// Amount to increment or decrement the value with each step.
  ///
  /// Defaults to 1.0 for integer-like increments. Use smaller values like
  /// 0.1 or 0.01 for decimal precision adjustments. The step size determines
  /// the granularity of value changes via spinner controls.
  final double step;

  /// Whether to enable vertical drag gestures for value adjustment.
  ///
  /// When true, users can drag vertically on the spinner controls to
  /// rapidly adjust values - dragging up increases, dragging down decreases.
  /// Defaults to true for enhanced user interaction.
  final bool enableGesture;

  /// Fallback value used when the input text cannot be parsed as a number.
  ///
  /// When users enter non-numeric text and attempt to use spinner controls,
  /// this value is used instead. Set to null to disable fallback behavior
  /// and preserve invalid text. Defaults to 0.0.
  final double? invalidValue;

  /// Creates an [InputSpinnerFeature].
  ///
  /// The [step] defaults to 1.0 for standard increments, [enableGesture]
  /// defaults to true for drag support, and [invalidValue] defaults to 0.0
  /// for fallback handling of non-numeric input.
  ///
  /// Example:
  /// ```dart
  /// InputSpinnerFeature(
  ///   step: 0.25,
  ///   enableGesture: true,
  ///   invalidValue: 0.0,
  /// );
  /// ```
  const InputSpinnerFeature({
    super.visibility,
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

/// Input feature that provides a copy-to-clipboard button for text content.
///
/// [InputCopyFeature] adds a button that copies the current input field text
/// to the system clipboard when pressed. This improves user experience by
/// providing easy text sharing and copying functionality without manual
/// text selection.
///
/// The feature integrates with Flutter's text field actions to select all
/// text and copy it to the clipboard using standardized text editing
/// commands. It provides consistent behavior across platforms.
///
/// Example:
/// ```dart
/// TextField(
///   controller: textController,
///   readOnly: true,
///   features: [
///     InputCopyFeature(
///       position: InputFeaturePosition.trailing,
///       icon: Icon(LucideIcons.copy),
///     ),
///   ],
/// );
/// ```
class InputCopyFeature extends InputFeature {
  /// Position of the copy button within the input field layout.
  ///
  /// Defaults to [InputFeaturePosition.trailing] for conventional placement
  /// on the trailing edge (right side in LTR layouts).
  final InputFeaturePosition position;

  /// Optional custom icon for the copy button.
  ///
  /// When null, displays [LucideIcons.copy] as the default copy icon.
  /// Should clearly indicate a copy or duplicate action.
  final Widget? icon;

  /// Creates an [InputCopyFeature].
  ///
  /// The [position] defaults to trailing and [icon] defaults to a copy icon.
  ///
  /// Example:
  /// ```dart
  /// InputCopyFeature(
  ///   position: InputFeaturePosition.trailing,
  ///   icon: Icon(LucideIcons.copy),
  /// );
  /// ```
  const InputCopyFeature({
    super.visibility,
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

/// Input feature that adds a custom widget to the leading position.
///
/// [InputLeadingFeature] provides a simple way to add custom widgets
/// (such as icons, labels, or indicators) to the leading edge of input fields.
/// This is useful for field labeling, status indicators, or decorative elements.
///
/// The feature integrates seamlessly with the input field's layout system,
/// positioning the widget consistently with other leading elements and
/// maintaining proper spacing and alignment.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputLeadingFeature(
///       Icon(LucideIcons.search, color: Colors.grey),
///     ),
///   ],
/// );
/// ```
class InputLeadingFeature extends InputFeature {
  /// Widget to display at the leading position of the input field.
  ///
  /// This widget appears on the leading edge (left side in LTR layouts)
  /// of the input field. Common uses include icons, labels, currency
  /// symbols, or status indicators that provide context for the input.
  final Widget prefix;

  /// Creates an [InputLeadingFeature] with the specified prefix widget.
  ///
  /// The [prefix] widget will be positioned at the leading edge of the
  /// input field with appropriate spacing and alignment.
  ///
  /// Example:
  /// ```dart
  /// InputLeadingFeature(
  ///   Icon(LucideIcons.mail, size: 16),
  /// );
  /// ```
  const InputLeadingFeature(
    this.prefix, {
    super.visibility,
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

/// Input feature that adds a custom widget to the trailing position.
///
/// [InputTrailingFeature] provides a simple way to add custom widgets
/// (such as icons, buttons, or indicators) to the trailing edge of input fields.
/// This is useful for action buttons, status indicators, or decorative elements.
///
/// The feature integrates seamlessly with the input field's layout system,
/// positioning the widget consistently with other trailing elements and
/// maintaining proper spacing and alignment.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputTrailingFeature(
///       IconButton(
///         icon: Icon(LucideIcons.send),
///         onPressed: () => _sendMessage(),
///         density: ButtonDensity.compact,
///       ),
///     ),
///   ],
/// );
/// ```
class InputTrailingFeature extends InputFeature {
  /// Widget to display at the trailing position of the input field.
  ///
  /// This widget appears on the trailing edge (right side in LTR layouts)
  /// of the input field. Common uses include action buttons, status
  /// indicators, units of measurement, or interactive controls.
  final Widget suffix;

  /// Creates an [InputTrailingFeature] with the specified suffix widget.
  ///
  /// The [suffix] widget will be positioned at the trailing edge of the
  /// input field with appropriate spacing and alignment.
  ///
  /// Example:
  /// ```dart
  /// InputTrailingFeature(
  ///   Text('USD', style: TextStyle(color: Colors.grey)),
  /// );
  /// ```
  const InputTrailingFeature(
    this.suffix, {
    super.visibility,
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

/// Input feature that provides a paste-from-clipboard button for text input.
///
/// [InputPasteFeature] adds a button that pastes text from the system clipboard
/// into the input field when pressed. This improves user experience by
/// providing easy clipboard integration without manual paste operations.
///
/// The feature integrates with the system clipboard API and automatically
/// appends pasted text to the current input field content using text field
/// actions for proper integration with the text editing system.
///
/// Example:
/// ```dart
/// TextField(
///   features: [
///     InputPasteFeature(
///       position: InputFeaturePosition.trailing,
///       icon: Icon(LucideIcons.clipboard),
///     ),
///   ],
/// );
/// ```
class InputPasteFeature extends InputFeature {
  /// Position of the paste button within the input field layout.
  ///
  /// Defaults to [InputFeaturePosition.trailing] for conventional placement
  /// on the trailing edge (right side in LTR layouts).
  final InputFeaturePosition position;

  /// Optional custom icon for the paste button.
  ///
  /// When null, displays [LucideIcons.clipboard] as the default paste icon.
  /// Should clearly indicate a paste or clipboard action.
  final Widget? icon;

  /// Creates an [InputPasteFeature].
  ///
  /// The [position] defaults to trailing and [icon] defaults to a clipboard icon.
  ///
  /// Example:
  /// ```dart
  /// InputPasteFeature(
  ///   position: InputFeaturePosition.trailing,
  ///   icon: Icon(LucideIcons.clipboard),
  /// );
  /// ```
  const InputPasteFeature({
    super.visibility,
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
