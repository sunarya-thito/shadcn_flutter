import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing [InputOTP] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [InputOTP] widgets, including spacing between OTP input fields
/// and the height of the input containers. These properties can be
/// set at the theme level to provide consistent styling across the application.
class InputOTPTheme {
  /// Horizontal spacing between OTP input fields.
  final double? spacing;

  /// Height of each OTP input container.
  final double? height;

  /// Creates an [InputOTPTheme].
  ///
  /// Parameters:
  /// - [spacing] (`double?`, optional): Space between input fields.
  /// - [height] (`double?`, optional): Height of input containers.
  const InputOTPTheme({this.spacing, this.height});

  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Parameters:
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing value.
  /// - [height] (`ValueGetter<double?>?`, optional): New height value.
  ///
  /// Returns: A new [InputOTPTheme] with updated properties.
  InputOTPTheme copyWith({
    ValueGetter<double?>? spacing,
    ValueGetter<double?>? height,
  }) {
    return InputOTPTheme(
      spacing: spacing == null ? this.spacing : spacing(),
      height: height == null ? this.height : height(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InputOTPTheme &&
        other.spacing == spacing &&
        other.height == height;
  }

  @override
  int get hashCode => Object.hash(spacing, height);
}

class _InputOTPSpacing extends StatelessWidget {
  const _InputOTPSpacing();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<InputOTPTheme>(context);
    return SizedBox(width: compTheme?.spacing ?? theme.scaling * 8);
  }
}

/// Abstract base class for OTP input child elements.
///
/// Defines the interface for children that can be placed within an [InputOTP]
/// widget, including actual input fields, separators, and spacers.
/// Subclasses implement the [build] method to render their content.
///
/// Common factories:
/// - [separator]: Creates a visual separator between OTP groups.
/// - [space]: Creates spacing between OTP input fields.
/// - [empty]: Creates an empty placeholder.
/// - [InputOTPChild.input]: Creates a configurable character input.
/// - [InputOTPChild.character]: Creates a character input with preset filters.
///
/// Example:
/// ```dart
/// InputOTP(
///   children: [
///     InputOTPChild.input(predicate: (cp) => cp >= 48 && cp <= 57),
///     InputOTPChild.space,
///     InputOTPChild.input(),
///   ],
/// )
/// ```
abstract class InputOTPChild {
  /// A visual separator between OTP groups (e.g., a dash or line).
  static InputOTPChild get separator =>
      const WidgetInputOTPChild(OTPSeparator());

  /// Spacing between OTP input fields.
  static InputOTPChild get space =>
      const WidgetInputOTPChild(_InputOTPSpacing());

  /// An empty placeholder that takes no space.
  static InputOTPChild get empty => const WidgetInputOTPChild(SizedBox());

  /// Creates a customizable character input field.
  ///
  /// Parameters:
  /// - [predicate] (`CodepointPredicate?`, optional): Function to validate codepoints.
  /// - [transform] (`CodepointUnaryOperator?`, optional): Function to transform codepoints.
  /// - [obscured] (`bool`, default: `false`): Whether to obscure the input.
  /// - [readOnly] (`bool`, default: `false`): Whether the input is read-only.
  /// - [keyboardType] (`TextInputType?`, optional): Keyboard type for input.
  ///
  /// Returns: A [CharacterInputOTPChild] configured with the specified options.
  factory InputOTPChild.input({
    CodepointPredicate? predicate,
    CodepointUnaryOperator? transform,
    bool obscured = false,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) =>
      CharacterInputOTPChild(
        predicate: predicate,
        transform: transform,
        obscured: obscured,
        readOnly: readOnly,
        keyboardType: keyboardType,
      );

  /// Creates a character input with alphabet and digit filtering.
  ///
  /// Parameters:
  /// - [allowLowercaseAlphabet] (`bool`, default: `false`): Allow lowercase letters.
  /// - [allowUppercaseAlphabet] (`bool`, default: `false`): Allow uppercase letters.
  /// - [allowDigit] (`bool`, default: `false`): Allow numeric digits.
  /// - [obscured] (`bool`, default: `false`): Whether to obscure the input.
  /// - [onlyUppercaseAlphabet] (`bool`, default: `false`): Convert to uppercase only.
  /// - [onlyLowercaseAlphabet] (`bool`, default: `false`): Convert to lowercase only.
  /// - [readOnly] (`bool`, default: `false`): Whether the input is read-only.
  /// - [keyboardType] (`TextInputType?`, optional): Keyboard type for input.
  ///
  /// Returns: A [CharacterInputOTPChild] configured for alphabet/digit input.
  ///
  /// Example:
  /// ```dart
  /// InputOTPChild.character(
  ///   allowDigit: true,
  ///   allowUppercaseAlphabet: true,
  /// )
  /// ```
  factory InputOTPChild.character({
    bool allowLowercaseAlphabet = false,
    bool allowUppercaseAlphabet = false,
    bool allowDigit = false,
    bool obscured = false,
    bool onlyUppercaseAlphabet = false,
    bool onlyLowercaseAlphabet = false,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) {
    assert(!(onlyUppercaseAlphabet && onlyLowercaseAlphabet),
        'onlyUppercaseAlphabet and onlyLowercaseAlphabet cannot be true at the same time');
    keyboardType ??= allowDigit &&
            !allowLowercaseAlphabet &&
            !allowUppercaseAlphabet &&
            !onlyUppercaseAlphabet &&
            !onlyLowercaseAlphabet
        ? TextInputType.number
        : TextInputType.text;
    return CharacterInputOTPChild(
      predicate: (codepoint) {
        if (allowLowercaseAlphabet &&
            CharacterInputOTPChild.isAlphabetLower(codepoint)) {
          return true;
        }
        if (allowUppercaseAlphabet &&
            CharacterInputOTPChild.isAlphabetUpper(codepoint)) {
          return true;
        }
        if (allowDigit && CharacterInputOTPChild.isDigit(codepoint)) {
          return true;
        }
        return false;
      },
      transform: (codepoint) {
        if (onlyUppercaseAlphabet) {
          return CharacterInputOTPChild.lowerToUpper(codepoint);
        }
        if (onlyLowercaseAlphabet) {
          return CharacterInputOTPChild.upperToLower(codepoint);
        }
        return codepoint;
      },
      keyboardType: keyboardType,
      obscured: obscured,
      readOnly: readOnly,
    );
  }

  /// Creates an [InputOTPChild].
  const InputOTPChild();

  /// Builds the widget for this OTP child.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [data] (`InputOTPChildData`, required): Data for building the child.
  ///
  /// Returns: The widget representing this OTP child.
  Widget build(BuildContext context, InputOTPChildData data);

  /// Whether this child can hold a value (i.e., is an input field).
  bool get hasValue;
}

/// A predicate that tests whether a Unicode codepoint is valid.
///
/// Parameters:
/// - [codepoint] (`int`): The Unicode codepoint to test.
///
/// Returns: `true` if the codepoint passes the predicate, `false` otherwise.
typedef CodepointPredicate = bool Function(int codepoint);

/// A function that transforms a Unicode codepoint to another.
///
/// Parameters:
/// - [codepoint] (`int`): The Unicode codepoint to transform.
///
/// Returns: The transformed codepoint.
typedef CodepointUnaryOperator = int Function(int codepoint);

/// A character-based OTP input field with validation and transformation.
///
/// Supports filtering input based on codepoint predicates and transforming
/// input characters (e.g., converting to uppercase). Commonly used for
/// creating numeric or alphanumeric OTP fields.
///
/// Example:
/// ```dart
/// CharacterInputOTPChild(
///   predicate: CharacterInputOTPChild.isDigit,
///   keyboardType: TextInputType.number,
/// )
/// ```
class CharacterInputOTPChild extends InputOTPChild {
  static const int _startAlphabetLower = 97; // 'a'
  static const int _endAlphabetLower = 122; // 'z'
  static const int _startAlphabetUpper = 65; // 'A'
  static const int _endAlphabetUpper = 90; // 'Z'
  static const int _startDigit = 48; // '0'
  static const int _endDigit = 57; // '9'

  /// Tests if the codepoint is a lowercase letter (a-z).
  ///
  /// Parameters:
  /// - [codepoint] (`int`, required): The codepoint to test.
  ///
  /// Returns: `true` if the codepoint is a lowercase letter.
  static bool isAlphabetLower(int codepoint) =>
      codepoint >= _startAlphabetLower && codepoint <= _endAlphabetLower;

  /// Tests if the codepoint is an uppercase letter (A-Z).
  ///
  /// Parameters:
  /// - [codepoint] (`int`, required): The codepoint to test.
  ///
  /// Returns: `true` if the codepoint is an uppercase letter.
  static bool isAlphabetUpper(int codepoint) =>
      codepoint >= _startAlphabetUpper && codepoint <= _endAlphabetUpper;

  /// Converts a lowercase letter to uppercase.
  ///
  /// Parameters:
  /// - [codepoint] (`int`, required): The codepoint to convert.
  ///
  /// Returns: The uppercase codepoint if lowercase, otherwise unchanged.
  static int lowerToUpper(int codepoint) =>
      isAlphabetLower(codepoint) ? codepoint - 32 : codepoint;

  /// Converts an uppercase letter to lowercase.
  ///
  /// Parameters:
  /// - [codepoint] (`int`, required): The codepoint to convert.
  ///
  /// Returns: The lowercase codepoint if uppercase, otherwise unchanged.
  static int upperToLower(int codepoint) =>
      isAlphabetUpper(codepoint) ? codepoint + 32 : codepoint;

  /// Tests if the codepoint is a digit (0-9).
  ///
  /// Parameters:
  /// - [codepoint] (`int`, required): The codepoint to test.
  ///
  /// Returns: `true` if the codepoint is a digit.
  static bool isDigit(int codepoint) =>
      codepoint >= _startDigit && codepoint <= _endDigit;

  /// Predicate to validate allowed codepoints.
  final CodepointPredicate? predicate;

  /// Function to transform codepoints before storing.
  final CodepointUnaryOperator? transform;

  /// Whether to obscure the input character.
  final bool obscured;

  /// Whether the input is read-only.
  final bool readOnly;

  /// The keyboard type to use for input.
  final TextInputType? keyboardType;

  /// Creates a [CharacterInputOTPChild].
  ///
  /// Parameters:
  /// - [predicate] (`CodepointPredicate?`, optional): Validates input codepoints.
  /// - [transform] (`CodepointUnaryOperator?`, optional): Transforms codepoints.
  /// - [obscured] (`bool`, default: `false`): Whether to obscure the character.
  /// - [readOnly] (`bool`, default: `false`): Whether the field is read-only.
  /// - [keyboardType] (`TextInputType?`, optional): Keyboard type for input.
  const CharacterInputOTPChild({
    this.predicate,
    this.transform,
    this.obscured = false,
    this.readOnly = false,
    this.keyboardType,
  });

  @override
  bool get hasValue {
    return true;
  }

  @override
  Widget build(BuildContext context, InputOTPChildData data) {
    return _OTPCharacterInput(
      key: data._key,
      data: data,
      predicate: predicate,
      transform: transform,
      obscured: obscured,
      readOnly: readOnly,
      keyboardType: keyboardType,
    );
  }
}

class _OTPCharacterInput extends StatefulWidget {
  final InputOTPChildData data;
  final CodepointPredicate? predicate;
  final CodepointUnaryOperator? transform;
  final bool obscured;
  final bool readOnly;
  final TextInputType? keyboardType;

  const _OTPCharacterInput({
    super.key,
    required this.data,
    this.predicate,
    this.transform,
    this.obscured = false,
    this.readOnly = false,
    this.keyboardType,
  });

  @override
  State<_OTPCharacterInput> createState() => _OTPCharacterInputState();
}

class _OTPCharacterInputState extends State<_OTPCharacterInput> {
  final TextEditingController _controller = TextEditingController();
  late int? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.data.value;
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    String text = _controller.text;
    if (text.isNotEmpty) {
      int codepoint = text.codeUnitAt(0);
      if (text.length > 1) {
        // forward to the next input
        var currentIndex = widget.data.index;
        var inputs = widget.data._state._children;
        if (currentIndex + 1 < inputs.length) {
          var nextInput = inputs[currentIndex + 1];
          nextInput.key.currentState?._controller.text = text.substring(1);
          if (text.length == 2) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              nextInput.key.currentState?._controller.text = text.substring(1);
            });
          } else {
            nextInput.key.currentState?._controller.text = text.substring(1);
          }
        }
      }
      if (widget.predicate != null && !widget.predicate!(codepoint)) {
        _value = null;
        _controller.clear();
        setState(() {});
        return;
      }
      if (widget.transform != null) {
        codepoint = widget.transform!(codepoint);
      }
      _value = codepoint;
      widget.data.changeValue(codepoint);
      _controller.clear();
      // next focus
      if (widget.data.nextFocusNode != null) {
        widget.data.nextFocusNode!.requestFocus();
      }
      setState(() {});
    }
  }

  BorderRadius getBorderRadiusByRelativeIndex(
      ThemeData theme, int relativeIndex, int groupLength) {
    if (relativeIndex == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(theme.radiusMd),
        bottomLeft: Radius.circular(theme.radiusMd),
      );
    } else if (relativeIndex == groupLength - 1) {
      return BorderRadius.only(
        topRight: Radius.circular(theme.radiusMd),
        bottomRight: Radius.circular(theme.radiusMd),
      );
    } else {
      return BorderRadius.zero;
    }
  }

  Widget getValueWidget(ThemeData theme) {
    if (_value == null) {
      return const SizedBox();
    }
    if (widget.obscured) {
      return Container(
        width: 8 * theme.scaling,
        height: 8 * theme.scaling,
        decoration: BoxDecoration(
          color: theme.colorScheme.foreground,
          shape: BoxShape.circle,
        ),
      );
    }
    return Text(
      String.fromCharCode(_value!),
    ).small().foreground();
  }

  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusScope(
      node: _focusScopeNode,
      onKeyEvent: (node, event) {
        if (event is KeyUpEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            if (widget.data.previousFocusNode != null) {
              widget.data.previousFocusNode!.requestFocus();
            }
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            if (widget.data.nextFocusNode != null) {
              widget.data.nextFocusNode!.requestFocus();
            }
            return KeyEventResult.handled;
          }
          // backspace
          if (event.logicalKey == LogicalKeyboardKey.backspace) {
            if (_value != null) {
              widget.data.changeValue(null);
              _value = null;
              setState(() {});
            } else {
              if (widget.data.previousFocusNode != null) {
                widget.data.previousFocusNode!.requestFocus();
              }
            }
            return KeyEventResult.handled;
          }
          // enter
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            if (_controller.text.isNotEmpty) {
              _onControllerChanged();
            }
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: SizedBox(
        width: 36 * theme.scaling,
        height: 36 * theme.scaling,
        child: Stack(
          children: [
            Positioned.fill(
              child: ListenableBuilder(
                listenable: widget.data.focusNode!,
                builder: (context, child) {
                  return FocusOutline(
                    focused: widget.data.focusNode!.hasFocus,
                    borderRadius: getBorderRadiusByRelativeIndex(
                      theme,
                      widget.data.relativeIndex,
                      widget.data.groupLength,
                    ),
                    child: child!,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.input.scaleAlpha(0.3),
                    border: Border.all(
                      color: theme.colorScheme.border,
                    ),
                    borderRadius: getBorderRadiusByRelativeIndex(
                      theme,
                      widget.data.relativeIndex,
                      widget.data.groupLength,
                    ),
                  ),
                ),
              ),
            ),
            if (_value != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: getValueWidget(theme),
                  ),
                ),
              ),
            Positioned.fill(
              key: _key,
              child: Opacity(
                opacity: _value == null ? 1 : 0,
                child: ComponentTheme(
                  data: const FocusOutlineTheme(
                    border: Border.fromBorderSide(BorderSide.none),
                  ),
                  child: TextField(
                    border: const Border.fromBorderSide(BorderSide.none),
                    decoration: const BoxDecoration(),
                    expands: false,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: widget.keyboardType,
                    readOnly: widget.readOnly,
                    textAlign: TextAlign.center,
                    focusNode: widget.data.focusNode,
                    controller: _controller,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget-based OTP child that doesn't accept input.
///
/// Used for displaying static content like separators or spacers within
/// an [InputOTP] widget. This child does not hold any value.
///
/// Example:
/// ```dart
/// WidgetInputOTPChild(
///   Icon(Icons.arrow_forward),
/// )
/// ```
class WidgetInputOTPChild extends InputOTPChild {
  /// The widget to display.
  final Widget child;

  /// Creates a [WidgetInputOTPChild].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): The widget to display.
  const WidgetInputOTPChild(this.child);

  @override
  Widget build(BuildContext context, InputOTPChildData data) {
    final theme = Theme.of(context);
    return SizedBox(
      width: theme.scaling * 32,
      height: theme.scaling * 32,
      child: Center(
        child: child,
      ),
    );
  }

  @override
  bool get hasValue => false;
}

/// A visual separator for OTP input groups.
///
/// Displays a dash "-" character between groups of OTP input fields.
/// Automatically applies theming and spacing based on the current theme.
///
/// Example:
/// ```dart
/// InputOTP(
///   children: [
///     InputOTPChild.input(),
///     OTPSeparator(),
///     InputOTPChild.input(),
///   ],
/// )
/// ```
class OTPSeparator extends StatelessWidget {
  /// Creates an [OTPSeparator].
  const OTPSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return const Text('-')
        .bold()
        .withPadding(horizontal: theme.scaling * 4)
        .base()
        .foreground();
  }
}

/// Data passed to [InputOTPChild.build] for rendering OTP input fields.
///
/// Contains information about focus nodes, index positions, current value,
/// and callbacks for changing values. Used internally by [InputOTP] to
/// coordinate input fields.
class InputOTPChildData {
  /// Focus node for the previous input field.
  final FocusNode? previousFocusNode;

  /// Focus node for this input field.
  final FocusNode? focusNode;

  /// Focus node for the next input field.
  final FocusNode? nextFocusNode;

  /// Overall index within all OTP children.
  final int index;

  /// Index of the group this child belongs to.
  final int groupIndex;

  /// Total number of children in this group.
  final int groupLength;

  /// Relative index within the group.
  final int relativeIndex;

  /// Current value (codepoint) of this input field.
  final int? value;

  final _InputOTPState _state;
  final GlobalKey<_OTPCharacterInputState>? _key;

  InputOTPChildData._(
    this._state,
    this._key, {
    required this.focusNode,
    required this.index,
    required this.groupIndex,
    required this.relativeIndex,
    required this.groupLength,
    this.previousFocusNode,
    this.nextFocusNode,
    this.value,
  });

  /// Updates the value for this OTP input field.
  ///
  /// Parameters:
  /// - [value] (`int?`, required): The new codepoint value or null.
  void changeValue(int? value) {
    _state._changeValue(index, value);
  }
}

class _InputOTPChild {
  int? value;
  final FocusNode focusNode;
  final int groupIndex;
  final int relativeIndex;
  final InputOTPChild child;
  int groupLength = 0;
  final GlobalKey<_OTPCharacterInputState> key;

  _InputOTPChild({
    required this.focusNode,
    required this.child,
    this.value,
    required this.groupIndex,
    required this.relativeIndex,
  }) : key = GlobalKey<_OTPCharacterInputState>();

  _InputOTPChild.withNewChild(_InputOTPChild old, InputOTPChild newChild)
      : focusNode = old.focusNode,
        value = old.value,
        groupIndex = old.groupIndex,
        relativeIndex = old.relativeIndex,
        child = newChild,
        groupLength = old.groupLength,
        key = old.key;
}

/// A list of nullable codepoints representing OTP input values.
///
/// Each element represents a character's Unicode codepoint, or null if not set.
typedef OTPCodepointList = List<int?>;

/// Extension methods for [OTPCodepointList].
extension OTPCodepointListExtension on OTPCodepointList {
  /// Converts the codepoint list to a string.
  ///
  /// Null values are converted to empty strings.
  ///
  /// Returns: A string representation of the OTP code.
  ///
  /// Example:
  /// ```dart
  /// final codes = [49, 50, 51]; // '1', '2', '3'
  /// print(codes.otpToString()); // '123'
  /// ```
  String otpToString() {
    return map((e) => e == null ? '' : String.fromCharCode(e)).join();
  }
}

/// A specialized input widget for One-Time Password (OTP) and verification code entry.
///
/// [InputOTP] provides a user-friendly interface for entering OTP codes, verification
/// numbers, and similar sequential input scenarios. The widget displays a series of
/// individual input fields that automatically advance focus as the user types,
/// creating an intuitive experience for multi-digit input.
///
/// Key features:
/// - Sequential character input with automatic focus advancement
/// - Customizable field layout with separators and spacing
/// - Support for various character types (digits, letters, symbols)
/// - Keyboard navigation and clipboard paste support
/// - Form integration with validation support
/// - Accessibility features for screen readers
/// - Theming and visual customization
///
/// The widget uses a flexible child system that allows mixing input fields
/// with separators, spaces, and custom widgets:
/// - Character input fields for actual OTP digits/letters
/// - Separators for visual grouping (e.g., dashes, dots)
/// - Spacing elements for layout control
/// - Custom widgets for specialized display needs
///
/// Common use cases:
/// - SMS verification codes (e.g., 6-digit codes)
/// - Two-factor authentication tokens
/// - Credit card security codes
/// - License key input
/// - PIN code entry
///
/// Example:
/// ```dart
/// InputOTP(
///   children: [
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///     InputOTPChild.separator,
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///   ],
///   onChanged: (code) => _handleOTPChange(code),
///   onSubmitted: (code) => _verifyOTP(code),
/// );
/// ```
class InputOTP extends StatefulWidget {
  /// The list of children defining input fields, separators, and spaces.
  final List<InputOTPChild> children;

  /// Initial OTP codepoint values.
  final OTPCodepointList? initialValue;

  /// Called when the OTP value changes.
  final ValueChanged<OTPCodepointList>? onChanged;

  /// Called when the user submits the OTP (e.g., presses Enter on last field).
  final ValueChanged<OTPCodepointList>? onSubmitted;

  /// Creates an [InputOTP] widget.
  ///
  /// Parameters:
  /// - [children] (`List<InputOTPChild>`, required): The OTP input fields and decorations.
  /// - [initialValue] (`OTPCodepointList?`, optional): Initial codepoints.
  /// - [onChanged] (`ValueChanged<OTPCodepointList>?`, optional): Value change callback.
  /// - [onSubmitted] (`ValueChanged<OTPCodepointList>?`, optional): Submit callback.
  const InputOTP({
    super.key,
    required this.children,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<InputOTP> createState() => _InputOTPState();
}

class _InputOTPState extends State<InputOTP>
    with FormValueSupplier<OTPCodepointList, InputOTP> {
  final List<_InputOTPChild> _children = [];

  OTPCodepointList get value {
    return _children.map((e) => e.value).toList();
  }

  void _changeValue(int index, int? value) {
    _children[index].value = value;
    var val = this.value;
    if (widget.onChanged != null) {
      widget.onChanged!(val);
    }
    if (widget.onSubmitted != null) {
      if (val.every((e) => e != null)) {
        widget.onSubmitted?.call(val);
      }
    }
    formValue = this.value;
  }

  @override
  void initState() {
    super.initState();
    int index = 0;
    int groupIndex = 0;
    int relativeIndex = 0;
    for (final child in widget.children) {
      if (child.hasValue) {
        int? value = getInitialValue(index);
        _children.add(_InputOTPChild(
          focusNode: FocusNode(),
          child: child,
          value: value,
          groupIndex: groupIndex,
          relativeIndex: relativeIndex,
        ));
        index++;
        relativeIndex++;
      } else {
        // update previous group length
        for (int i = 0; i < index; i++) {
          _children[i].groupLength = relativeIndex;
        }
        groupIndex++;
        relativeIndex = 0;
      }
    }
    for (int i = index - relativeIndex; i < index; i++) {
      _children[i].groupLength = relativeIndex;
    }
    formValue = value;
  }

  int? getInitialValue(int index) {
    if (widget.initialValue != null && index < widget.initialValue!.length) {
      return widget.initialValue![index];
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant InputOTP oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.initialValue, widget.initialValue) ||
        !listEquals(oldWidget.children, widget.children)) {
      int index = 0;
      int groupIndex = 0;
      int relativeIndex = 0;
      for (final child in widget.children) {
        if (child.hasValue) {
          if (index < _children.length) {
            _children[index] = _InputOTPChild.withNewChild(
              _children[index],
              child,
            );
          } else {
            _children.add(_InputOTPChild(
              focusNode: FocusNode(),
              child: child,
              value: getInitialValue(index),
              groupIndex: groupIndex,
              relativeIndex: relativeIndex,
            ));
          }
          index++;
          relativeIndex++;
        } else {
          // update previous group length
          for (int i = index - relativeIndex; i < index; i++) {
            _children[i].groupLength = relativeIndex;
          }
          groupIndex++;
          relativeIndex = 0;
        }
      }
      for (int i = index - relativeIndex; i < index; i++) {
        _children[i].groupLength = relativeIndex;
      }
      formValue = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> children = [];
    int i = 0;
    for (final child in widget.children) {
      if (child.hasValue) {
        children.add(child.build(
          context,
          InputOTPChildData._(
            this,
            _children[i].key,
            focusNode: _children[i].focusNode,
            index: i,
            groupIndex: _children[i].groupIndex,
            relativeIndex: _children[i].relativeIndex,
            previousFocusNode: i == 0 ? null : _children[i - 1].focusNode,
            nextFocusNode:
                i == _children.length - 1 ? null : _children[i + 1].focusNode,
            value: _children[i].value,
            groupLength: _children[i].groupLength,
          ),
        ));
        i++;
      } else {
        children.add(child.build(
            context,
            InputOTPChildData._(
              this,
              null,
              focusNode: null,
              index: -1,
              groupIndex: -1,
              relativeIndex: -1,
              previousFocusNode: null,
              nextFocusNode: null,
              value: null,
              groupLength: -1,
            )));
      }
    }
    final compTheme = ComponentTheme.maybeOf<InputOTPTheme>(context);
    return SizedBox(
      height: compTheme?.height ?? theme.scaling * 36,
      child: IntrinsicWidth(
        child: Row(
          children: [
            for (final child in children) Expanded(child: child),
          ],
        ),
      ),
    );
  }

  @override
  void didReplaceFormValue(OTPCodepointList value) {
    widget.onChanged?.call(value);
  }
}
