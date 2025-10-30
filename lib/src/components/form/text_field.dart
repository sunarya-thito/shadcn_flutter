// This file contains mostly patches from another package/sdk
// due to changes that need to be made but cannot be done normally
import 'dart:math';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart'
    show
        ConstrainedBox,
        CupertinoSpellCheckSuggestionsToolbar,
        cupertinoDesktopTextSelectionHandleControls;
import 'package:flutter/foundation.dart'
    show IterableProperty, defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';

import '../../../shadcn_flutter.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;

/// Theme data for customizing [TextField] appearance.
///
/// This class defines the visual properties that can be applied to
/// [TextField] widgets, including border styling, fill state, padding,
/// and border radius. These properties can be set at the theme level
/// to provide consistent styling across the application.
class TextFieldTheme {
  /// Border radius for text field corners.
  ///
  /// If `null`, uses default border radius from the theme.
  final BorderRadiusGeometry? borderRadius;

  /// Whether the text field has a filled background.
  ///
  /// When `true`, applies a background fill color.
  final bool? filled;

  /// Padding inside the text field.
  ///
  /// If `null`, uses default padding from the theme.
  final EdgeInsetsGeometry? padding;

  /// Border style for the text field.
  ///
  /// If `null`, uses default border from the theme.
  final Border? border;

  /// Creates a [TextFieldTheme].
  ///
  /// Parameters:
  /// - [border] (`Border?`, optional): Border style.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Corner rounding.
  /// - [filled] (`bool?`, optional): Whether background is filled.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Internal padding.
  const TextFieldTheme({
    this.border,
    this.borderRadius,
    this.filled,
    this.padding,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters use value getters to allow `null` values to be explicitly set.
  TextFieldTheme copyWith({
    ValueGetter<Border?>? border,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<bool?>? filled,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return TextFieldTheme(
      border: border == null ? this.border : border(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      filled: filled == null ? this.filled : filled(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextFieldTheme &&
        other.border == border &&
        other.borderRadius == borderRadius &&
        other.filled == filled &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(border, borderRadius, filled, padding);
}

/// Standard height for text field components in logical pixels.
const kTextFieldHeight = 34;

/// Abstract base class for controlling input feature visibility.
///
/// Defines when UI elements like clear buttons, password toggles, or other
/// input features should be visible based on text field state. Supports
/// logical operations (AND, OR, NOT) to combine multiple visibility conditions.
///
/// Example:
/// ```dart
/// // Show clear button when text is not empty and field is focused
/// final visibility = InputFeatureVisibility.textNotEmpty &
///                   InputFeatureVisibility.focused;
/// ```
abstract class InputFeatureVisibility {
  /// Creates a visibility condition that is true when all [features] are true.
  const factory InputFeatureVisibility.and(
    Iterable<InputFeatureVisibility> features,
  ) = _LogicAndInputFeatureVisibility;

  /// Creates a visibility condition that is true when any [features] is true.
  const factory InputFeatureVisibility.or(
    Iterable<InputFeatureVisibility> features,
  ) = _LogicOrInputFeatureVisibility;

  /// Creates a visibility condition that inverts the given [feature].
  const factory InputFeatureVisibility.not(InputFeatureVisibility feature) =
      _NegateInputFeatureVisibility;

  /// Visibility condition: text field is not empty.
  static const InputFeatureVisibility textNotEmpty =
      _TextNotEmptyInputFeatureVisibility();

  /// Visibility condition: text field is empty.
  static const InputFeatureVisibility textEmpty =
      _TextEmptyInputFeatureVisibility();

  /// Visibility condition: text field has focus.
  static const InputFeatureVisibility focused =
      _FocusedInputFeatureVisibility();

  /// Visibility condition: text field is being hovered.
  static const InputFeatureVisibility hovered =
      _HoveredInputFeatureVisibility();

  /// Visibility condition: never visible.
  static const InputFeatureVisibility never =
      _NeverVisibleInputFeatureVisibility();

  /// Visibility condition: always visible.
  static const InputFeatureVisibility always =
      _AlwaysVisibleInputFeatureVisibility();

  /// Visibility condition: text field has selected text.
  static const InputFeatureVisibility hasSelection =
      _HasSelectionInputFeatureVisibility();

  /// Creates an [InputFeatureVisibility].
  const InputFeatureVisibility();

  /// Gets the listenable dependencies for this visibility condition.
  ///
  /// Returns the state objects that should be monitored for changes.
  Iterable<Listenable> getDependencies(TextFieldState state);

  /// Checks if the feature can be shown in the current state.
  ///
  /// Returns `true` if all visibility conditions are met.
  bool canShow(TextFieldState state);

  /// Combines this visibility with [other] using logical AND.
  InputFeatureVisibility and(InputFeatureVisibility other) =>
      InputFeatureVisibility.and([this, other]);

  /// Operator form of [and]. Combines conditions with logical AND.
  InputFeatureVisibility operator &(InputFeatureVisibility other) => and(other);

  /// Combines this visibility with [other] using logical OR.
  InputFeatureVisibility or(InputFeatureVisibility other) =>
      InputFeatureVisibility.or([this, other]);

  /// Operator form of [or]. Combines conditions with logical OR.
  InputFeatureVisibility operator |(InputFeatureVisibility other) => or(other);

  /// Inverts this visibility condition using logical NOT.
  InputFeatureVisibility operator ~() => InputFeatureVisibility.not(this);
}

class _LogicAndInputFeatureVisibility extends InputFeatureVisibility {
  final Iterable<InputFeatureVisibility> features;
  const _LogicAndInputFeatureVisibility(this.features);
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    for (final feature in features) {
      yield* feature.getDependencies(state);
    }
  }

  @override
  bool canShow(TextFieldState state) {
    return features.every((feature) => feature.canShow(state));
  }

  @override
  bool operator ==(Object other) =>
      other is _LogicAndInputFeatureVisibility &&
      other.features.length == features.length &&
      other.features.every((otherFeature) => features.contains(otherFeature));

  @override
  int get hashCode => features.hashCode;
}

class _LogicOrInputFeatureVisibility extends InputFeatureVisibility {
  final Iterable<InputFeatureVisibility> features;
  const _LogicOrInputFeatureVisibility(this.features);
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    for (final feature in features) {
      yield* feature.getDependencies(state);
    }
  }

  @override
  bool canShow(TextFieldState state) {
    return features.any((feature) => feature.canShow(state));
  }

  @override
  bool operator ==(Object other) =>
      other is _LogicOrInputFeatureVisibility &&
      other.features.length == features.length &&
      other.features.every((otherFeature) => features.contains(otherFeature));

  @override
  int get hashCode => features.hashCode;
}

class _NegateInputFeatureVisibility extends InputFeatureVisibility {
  final InputFeatureVisibility feature;
  const _NegateInputFeatureVisibility(this.feature);
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) =>
      feature.getDependencies(state);

  @override
  bool canShow(TextFieldState state) => !feature.canShow(state);

  @override
  bool operator ==(Object other) =>
      other is _NegateInputFeatureVisibility && other.feature == feature;

  @override
  int get hashCode => feature.hashCode;
}

class _TextNotEmptyInputFeatureVisibility extends InputFeatureVisibility {
  const _TextNotEmptyInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveText;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._effectiveText.value.isNotEmpty;
  }
}

class _TextEmptyInputFeatureVisibility extends InputFeatureVisibility {
  const _TextEmptyInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveText;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._effectiveText.value.isEmpty;
  }
}

class _HasSelectionInputFeatureVisibility extends InputFeatureVisibility {
  const _HasSelectionInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveSelection;
  }

  @override
  bool canShow(TextFieldState state) {
    var selection = state._effectiveSelection.value;
    return selection.isValid && selection.start != selection.end;
  }
}

class _FocusedInputFeatureVisibility extends InputFeatureVisibility {
  const _FocusedInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._effectiveFocusNode;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._effectiveFocusNode.hasFocus;
  }
}

class _HoveredInputFeatureVisibility extends InputFeatureVisibility {
  const _HoveredInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {
    yield state._statesController;
  }

  @override
  bool canShow(TextFieldState state) {
    return state._statesController.value.hovered;
  }
}

class _NeverVisibleInputFeatureVisibility extends InputFeatureVisibility {
  const _NeverVisibleInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {}

  @override
  bool canShow(TextFieldState state) => false;
}

class _AlwaysVisibleInputFeatureVisibility extends InputFeatureVisibility {
  const _AlwaysVisibleInputFeatureVisibility();
  @override
  Iterable<Listenable> getDependencies(TextFieldState state) sync* {}

  @override
  bool canShow(TextFieldState state) => true;
}

/// Abstract factory for creating input field feature components.
///
/// Provides factory constructors for common text field features like password
/// toggles, clear buttons, hints, autocomplete, and spinners. Features can be
/// conditionally shown based on field state using [InputFeatureVisibility].
///
/// Example:
/// ```dart
/// TextField(
///   leading: [
///     InputFeature.hint(
///       popupBuilder: (context) => Text('Enter email'),
///     ),
///   ],
///   trailing: [
///     InputFeature.clear(),
///     InputFeature.passwordToggle(),
///   ],
/// )
/// ```
abstract class InputFeature {
  /// Creates a hint/tooltip feature for the input field.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show hint.
  /// - [popupBuilder] (`WidgetBuilder`, required): Builds the hint popup content.
  /// - [icon] (`Widget?`, optional): Icon to display for the hint trigger.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place the hint.
  /// - [enableShortcuts] (`bool`, default: true): Enable keyboard shortcuts.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.hint({
    InputFeatureVisibility visibility,
    required WidgetBuilder popupBuilder,
    Widget? icon,
    InputFeaturePosition position,
    bool enableShortcuts,
    bool skipFocusTraversal,
  }) = InputHintFeature;

  /// Creates a password visibility toggle feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show toggle.
  /// - [mode] (`PasswordPeekMode`, default: toggle): Toggle or peek mode.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place toggle.
  /// - [icon] (`Widget?`, optional): Icon when password is hidden.
  /// - [iconShow] (`Widget?`, optional): Icon when password is visible.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.passwordToggle({
    InputFeatureVisibility visibility,
    PasswordPeekMode mode,
    InputFeaturePosition position,
    Widget? icon,
    Widget? iconShow,
    bool skipFocusTraversal,
  }) = InputPasswordToggleFeature;

  /// Creates a clear text button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: textNotEmpty): When to show clear button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom clear icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.clear({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputClearFeature;

  /// Creates a revalidate button feature.
  ///
  /// Triggers form validation when clicked.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom revalidate icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.revalidate({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputRevalidateFeature;

  /// Creates an autocomplete feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: focused): When to show autocomplete.
  /// - [querySuggestions] (`SuggestionBuilder`, required): Builds suggestion list.
  /// - [child] (`Widget`, required): Child widget in the autocomplete popup.
  /// - [popoverConstraints] (`BoxConstraints?`, optional): Size constraints for popup.
  /// - [popoverWidthConstraint] (`PopoverConstraint?`, optional): Width constraint mode.
  /// - [popoverAnchorAlignment] (`AlignmentDirectional?`, optional): Anchor alignment.
  /// - [popoverAlignment] (`AlignmentDirectional?`, optional): Popup alignment.
  /// - [mode] (`AutoCompleteMode`, default: popup): Display mode.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.autoComplete({
    InputFeatureVisibility visibility,
    required SuggestionBuilder querySuggestions,
    required Widget child,
    BoxConstraints? popoverConstraints,
    PopoverConstraint? popoverWidthConstraint,
    AlignmentDirectional? popoverAnchorAlignment,
    AlignmentDirectional? popoverAlignment,
    AutoCompleteMode mode,
    bool skipFocusTraversal,
  }) = InputAutoCompleteFeature;

  /// Creates a numeric spinner feature for incrementing/decrementing values.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show spinner.
  /// - [step] (`double`, default: 1): Increment/decrement step size.
  /// - [enableGesture] (`bool`, default: true): Enable drag gestures.
  /// - [invalidValue] (`double?`, optional): Value to use when input is invalid.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.spinner({
    InputFeatureVisibility visibility,
    double step,
    bool enableGesture,
    double? invalidValue,
    bool skipFocusTraversal,
  }) = InputSpinnerFeature;

  /// Creates a copy to clipboard button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: textNotEmpty): When to show copy button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom copy icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.copy({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputCopyFeature;

  /// Creates a paste from clipboard button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show paste button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom paste icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.paste({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputPasteFeature;

  /// Creates a custom leading widget feature.
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget to display.
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show widget.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.leading(
    Widget child, {
    InputFeatureVisibility visibility,
    bool skipFocusTraversal,
  }) = InputLeadingFeature;

  /// Creates a custom trailing widget feature.
  const factory InputFeature.trailing(
    Widget child, {
    InputFeatureVisibility visibility,
    bool skipFocusTraversal,
  }) = InputTrailingFeature;

  /// Visibility mode for this input feature.
  final InputFeatureVisibility visibility;

  /// Whether to skip this feature in focus traversal.
  final bool skipFocusTraversal;

  /// Creates an input feature.
  const InputFeature(
      {this.visibility = InputFeatureVisibility.always,
      this.skipFocusTraversal = true});

  /// Creates the state for this input feature.
  InputFeatureState createState();

  /// Checks if an old feature can be updated to a new feature.
  static bool canUpdate(InputFeature oldFeature, InputFeature newFeature) {
    return oldFeature.runtimeType == newFeature.runtimeType;
  }
}

/// Abstract base state class for input features.
///
/// Manages the lifecycle and state of features that extend text field
/// functionality, such as clear buttons, counters, or custom decorations.
abstract class InputFeatureState<T extends InputFeature> {
  _AttachedInputFeature? _attached;
  TextFieldState? _inputState;

  /// The input feature associated with this state.
  T get feature {
    assert(
        _attached != null && _attached!.feature is T, 'Feature not attached');
    return _attached!.feature as T;
  }

  /// The ticker provider for animations.
  TickerProvider get tickerProvider {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!;
  }

  /// The build context for this feature.
  BuildContext get context {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    final context = inputState!.editableTextKey.currentContext;
    if (context == null) {
      throw FlutterError(
          'InputFeatureState.context was accessed but editableTextKey.currentContext is null.\n'
          'This usually means the widget is not mounted. Ensure the widget is mounted before accessing context.');
    }
    return context;
  }

  /// The parent text field widget.
  TextField get input {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.widget;
  }

  /// Whether this feature is currently attached to a text field.
  bool get attached => _attached != null;

  /// The text editing controller for the text field.
  TextEditingController get controller {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.effectiveController;
  }

  late AnimationController _visibilityController;

  Iterable<Widget> _internalBuildLeading() sync* {
    if (_visibilityController.value == 0) {
      return;
    }
    for (final widget in buildLeading()) {
      yield Hidden(
        hidden: _visibilityController.value < 1,
        duration: kDefaultDuration,
        child: widget,
      );
    }
  }

  Iterable<Widget> _internalBuildTrailing() sync* {
    if (_visibilityController.value == 0) {
      return;
    }
    for (final widget in buildTrailing()) {
      yield Hidden(
        hidden: _visibilityController.value < 1,
        duration: kDefaultDuration,
        child: widget,
      );
    }
  }

  /// Initializes this feature state.
  ///
  /// Called when the feature is first attached to a text field.
  void initState() {
    _visibilityController = AnimationController(
      vsync: tickerProvider,
      duration: kDefaultDuration,
    );
    _visibilityController.value =
        feature.visibility.canShow(_inputState!) ? 1 : 0;
    _visibilityController.addListener(_updateAnimation);
    for (var dependency in feature.visibility.getDependencies(_inputState!)) {
      dependency.addListener(_updateVisibility);
    }
  }

  /// Called when dependencies change.
  ///
  /// Override to respond to dependency changes in the widget tree.
  void didChangeDependencies() {}

  void _updateAnimation() {
    setState(() {});
  }

  void _updateVisibility() {
    bool canShow = feature.visibility.canShow(_inputState!);
    if (canShow && _visibilityController.value == 1) return;
    if (!canShow && _visibilityController.value == 0) return;
    if (canShow) {
      _visibilityController.forward();
    } else {
      _visibilityController.reverse();
    }
  }

  /// Disposes resources used by this feature state.
  ///
  /// Called when the feature is detached from the text field.
  void dispose() {
    _visibilityController.dispose();
    for (var dependency in feature.visibility.getDependencies(_inputState!)) {
      dependency.removeListener(_updateVisibility);
    }
  }

  /// Called when the feature is updated.
  ///
  /// Override to respond to feature configuration changes.
  void didFeatureUpdate(InputFeature oldFeature) {
    if (oldFeature.visibility != feature.visibility) {
      for (var oldDependency
          in oldFeature.visibility.getDependencies(_inputState!)) {
        oldDependency.removeListener(_updateVisibility);
      }
      for (var newDependency
          in feature.visibility.getDependencies(_inputState!)) {
        newDependency.addListener(_updateVisibility);
      }
    }
  }

  /// Called when the text field's text changes.
  ///
  /// Override to respond to text changes.
  void onTextChanged(String text) {}

  /// Called when the text field's selection changes.
  ///
  /// Override to respond to selection changes.
  void onSelectionChanged(TextSelection selection) {}

  /// Builds leading widgets for the text field.
  ///
  /// Override to provide widgets shown before the input.
  Iterable<Widget> buildLeading() sync* {}

  /// Builds trailing widgets for the text field.
  ///
  /// Override to provide widgets shown after the input.
  Iterable<Widget> buildTrailing() sync* {}

  /// Builds actions for keyboard shortcuts.
  ///
  /// Override to provide custom actions.
  Iterable<MapEntry<Type, Action<Intent>>> buildActions() sync* {}

  /// Builds keyboard shortcuts.
  ///
  /// Override to provide custom keyboard shortcuts.
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts() sync* {}

  /// Wraps the text field widget.
  ///
  /// Override to wrap the field with additional widgets.
  Widget wrap(Widget child) => child;

  /// Intercepts and modifies the text field configuration.
  ///
  /// Override to modify the text field before rendering.
  TextField interceptInput(TextField input) => input;

  /// Triggers a state update for the attached text field.
  ///
  /// Parameters:
  /// - [fn] (`VoidCallback`, required): State update callback.
  ///
  /// Throws: AssertionError if feature is not attached.
  void setState(VoidCallback fn) {
    assert(attached, 'Feature not attached');
    _inputState!._setStateFeature(fn);
  }
}

class _TextFieldSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({required TextFieldState state})
      : _state = state,
        super(delegate: state);

  final TextFieldState _state;

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    // Because TextSelectionGestureDetector listens to taps that happen on
    // widgets in front of it, tapping the clear button will also trigger
    // this handler. If the clear button widget recognizes the up event,
    // then do not handle it.
    if (_state._clearGlobalKey.currentContext != null) {
      final RenderBox renderBox = _state._clearGlobalKey.currentContext!
          .findRenderObject()! as RenderBox;
      final Offset localOffset =
          renderBox.globalToLocal(details.globalPosition);
      if (renderBox.hitTest(BoxHitTestResult(), position: localOffset)) {
        return;
      }
    }
    super.onSingleTapUp(details);
    _state.widget.onTap?.call();
  }

  @override
  void onDragSelectionEnd(TapDragEndDetails details) {
    _state._requestKeyboard();
    super.onDragSelectionEnd(details);
  }
}

/// Mixin defining the interface for text input widgets.
///
/// Provides a comprehensive set of properties that text input widgets
/// must implement, ensuring consistency across [TextField], [ChipInput],
/// [TextArea], and similar components. This mixin helps avoid missing
/// properties when implementing custom text input widgets.
///
/// Properties are organized into categories:
/// - Basic configuration: groupId, controller, focusNode
/// - Visual styling: decoration, padding, placeholder, border, borderRadius
/// - Text configuration: style, strutStyle, textAlign, textDirection
/// - Input behavior: keyboardType, textInputAction, autocorrect, enableSuggestions
/// - Cursor styling: cursorWidth, cursorHeight, cursorRadius, cursorColor
/// - Selection: enableInteractiveSelection, selectionControls, selectionHeightStyle
/// - Callbacks: onChanged, onSubmitted, onEditingComplete, onTap
/// - Features: features, inputFormatters, submitFormatters
mixin TextInput on Widget {
  /// Group identifier for related text inputs.
  Object get groupId;

  /// Text editing controller for the input.
  TextEditingController? get controller;

  /// Focus node for keyboard focus management.
  FocusNode? get focusNode;

  /// Box decoration for the input container.
  BoxDecoration? get decoration;

  /// Padding inside the input.
  EdgeInsetsGeometry? get padding;

  /// Placeholder widget shown when empty.
  Widget? get placeholder;

  /// Cross-axis alignment for content.
  CrossAxisAlignment get crossAxisAlignment;

  /// Semantic label for the clear button.
  String? get clearButtonSemanticLabel;

  /// Type of keyboard to show.
  TextInputType? get keyboardType;

  /// Action button on the keyboard.
  TextInputAction? get textInputAction;

  /// Text capitalization behavior.
  TextCapitalization get textCapitalization;

  /// Text style for input content.
  TextStyle? get style;

  /// Strut style for text layout.
  StrutStyle? get strutStyle;

  /// Horizontal text alignment.
  TextAlign get textAlign;

  /// Vertical text alignment.
  TextAlignVertical? get textAlignVertical;

  /// Text direction.
  TextDirection? get textDirection;

  /// Whether the input is read-only.
  bool get readOnly;

  /// Whether to show the cursor.
  bool? get showCursor;

  /// Whether to auto-focus on mount.
  bool get autofocus;

  /// Character used for obscuring text.
  String get obscuringCharacter;

  /// Whether to obscure text (password fields).
  bool get obscureText;

  /// Whether to enable autocorrection.
  bool get autocorrect;

  /// Smart dashes behavior.
  SmartDashesType get smartDashesType;

  /// Smart quotes behavior.
  SmartQuotesType get smartQuotesType;

  /// Whether to enable suggestions.
  bool get enableSuggestions;

  /// Maximum number of lines.
  int? get maxLines;

  /// Minimum number of lines.
  int? get minLines;

  /// Whether the input should expand to fill available space.
  bool get expands;

  /// Maximum character length.
  int? get maxLength;

  /// How to enforce max length.
  MaxLengthEnforcement? get maxLengthEnforcement;

  /// Callback when text changes.
  ValueChanged<String>? get onChanged;

  /// Callback when editing is complete.
  VoidCallback? get onEditingComplete;

  /// Callback when text is submitted.
  ValueChanged<String>? get onSubmitted;

  /// Callback when tapped outside.
  TapRegionCallback? get onTapOutside;

  /// Callback when tap up occurs outside.
  TapRegionCallback? get onTapUpOutside;

  /// Input formatters for text.
  List<TextInputFormatter>? get inputFormatters;

  /// Whether the input is enabled.
  bool get enabled;

  /// Width of the cursor.
  double get cursorWidth;

  /// Height of the cursor.
  double? get cursorHeight;

  /// Radius of the cursor.
  Radius get cursorRadius;

  /// Whether cursor opacity animates.
  bool get cursorOpacityAnimates;

  /// Color of the cursor.
  Color? get cursorColor;

  /// Selection height style.
  ui.BoxHeightStyle get selectionHeightStyle;

  /// Selection width style.
  ui.BoxWidthStyle get selectionWidthStyle;

  /// Keyboard appearance brightness.
  Brightness? get keyboardAppearance;

  /// Scroll padding for keyboard avoidance.
  EdgeInsets get scrollPadding;

  /// Whether interactive selection is enabled.
  bool get enableInteractiveSelection;

  /// Controls for text selection.
  TextSelectionControls? get selectionControls;

  /// Drag start behavior.
  DragStartBehavior get dragStartBehavior;

  /// Scroll controller.
  ScrollController? get scrollController;

  /// Scroll physics.
  ScrollPhysics? get scrollPhysics;

  /// Callback when tapped.
  GestureTapCallback? get onTap;

  /// Autofill hints for the platform.
  Iterable<String>? get autofillHints;

  /// Clip behavior.
  Clip get clipBehavior;

  /// Restoration ID for state restoration.
  String? get restorationId;

  /// Whether stylus handwriting is enabled.
  bool get stylusHandwritingEnabled;

  /// Whether IME personalized learning is enabled.
  bool get enableIMEPersonalizedLearning;

  /// Content insertion configuration.
  ContentInsertionConfiguration? get contentInsertionConfiguration;

  /// Context menu builder.
  EditableTextContextMenuBuilder? get contextMenuBuilder;

  /// Initial value for the input.
  String? get initialValue;

  /// Hint text displayed when empty.
  String? get hintText;

  /// Border styling.
  Border? get border;

  /// Border radius.
  BorderRadiusGeometry? get borderRadius;

  /// Whether the input has a filled background.
  bool? get filled;

  /// Widget states controller.
  WidgetStatesController? get statesController;

  /// Magnifier configuration.
  TextMagnifierConfiguration? get magnifierConfiguration;

  /// Spell check configuration.
  SpellCheckConfiguration? get spellCheckConfiguration;

  /// Undo history controller.
  UndoHistoryController? get undoController;

  /// List of input features.
  List<InputFeature> get features;

  /// Input formatters applied on submit.
  List<TextInputFormatter>? get submitFormatters;

  /// Whether to skip focus traversal for input features.
  bool get skipInputFeatureFocusTraversal;
}

/// Abstract base class for stateful text input widgets.
///
/// Combines [StatefulWidget] with [TextInput] mixin to provide a base
/// for implementing text input components with state.
abstract class TextInputStatefulWidget extends StatefulWidget with TextInput {
  @override
  final Object groupId;
  @override
  final TextEditingController? controller;
  @override
  final FocusNode? focusNode;
  @override
  final BoxDecoration? decoration;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final Widget? placeholder;
  @override
  final CrossAxisAlignment crossAxisAlignment;
  @override
  final String? clearButtonSemanticLabel;
  @override
  final TextInputType? keyboardType;
  @override
  final TextInputAction? textInputAction;
  @override
  final TextCapitalization textCapitalization;
  @override
  final TextStyle? style;
  @override
  final StrutStyle? strutStyle;
  @override
  final TextAlign textAlign;
  @override
  final TextAlignVertical? textAlignVertical;
  @override
  final TextDirection? textDirection;
  @override
  final bool readOnly;
  @override
  final bool? showCursor;
  @override
  final bool autofocus;
  @override
  final String obscuringCharacter;
  @override
  final bool obscureText;
  @override
  final bool autocorrect;
  @override
  final SmartDashesType smartDashesType;
  @override
  final SmartQuotesType smartQuotesType;
  @override
  final bool enableSuggestions;
  @override
  final int? maxLines;
  @override
  final int? minLines;
  @override
  final bool expands;
  @override
  final int? maxLength;
  @override
  final MaxLengthEnforcement? maxLengthEnforcement;
  @override
  final ValueChanged<String>? onChanged;
  @override
  final VoidCallback? onEditingComplete;
  @override
  final ValueChanged<String>? onSubmitted;
  @override
  final TapRegionCallback? onTapOutside;
  @override
  final TapRegionCallback? onTapUpOutside;
  @override
  final List<TextInputFormatter>? inputFormatters;
  @override
  final bool enabled;
  @override
  final double cursorWidth;
  @override
  final double? cursorHeight;
  @override
  final Radius cursorRadius;
  @override
  final bool cursorOpacityAnimates;
  @override
  final Color? cursorColor;
  @override
  final ui.BoxHeightStyle selectionHeightStyle;
  @override
  final ui.BoxWidthStyle selectionWidthStyle;
  @override
  final Brightness? keyboardAppearance;
  @override
  final EdgeInsets scrollPadding;
  @override
  final bool enableInteractiveSelection;
  @override
  final TextSelectionControls? selectionControls;
  @override
  final DragStartBehavior dragStartBehavior;
  @override
  final ScrollController? scrollController;
  @override
  final ScrollPhysics? scrollPhysics;
  @override
  final GestureTapCallback? onTap;
  @override
  final Iterable<String>? autofillHints;
  @override
  final Clip clipBehavior;
  @override
  final String? restorationId;
  @override
  final bool stylusHandwritingEnabled;
  @override
  final bool enableIMEPersonalizedLearning;
  @override
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  @override
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  @override
  final String? initialValue;
  @override
  final String? hintText;
  @override
  final Border? border;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final bool? filled;
  @override
  final WidgetStatesController? statesController;
  @override
  final TextMagnifierConfiguration? magnifierConfiguration;
  @override
  final SpellCheckConfiguration? spellCheckConfiguration;
  @override
  final UndoHistoryController? undoController;
  @override
  final List<InputFeature> features;
  @override
  final List<TextInputFormatter>? submitFormatters;
  @override
  final bool skipInputFeatureFocusTraversal;

  /// Creates a stateful text input widget with comprehensive configuration options.
  ///
  /// This constructor accepts all properties defined in the [TextInput] mixin,
  /// providing extensive control over text input behavior, appearance, and interactions.
  ///
  /// Most parameters mirror Flutter's [EditableText] widget while adding custom
  /// features like input features, decorations, and form integration.
  ///
  /// Key parameters include:
  /// - [controller]: Text editing controller, created automatically if null
  /// - [focusNode]: Focus node for keyboard interaction
  /// - [decoration]: Box decoration for the input container
  /// - [padding]: Inner padding around the text field
  /// - [placeholder]: Widget shown when field is empty
  /// - [enabled]: Whether input accepts user interaction, defaults to true
  /// - [readOnly]: Whether text can be edited, defaults to false
  /// - [obscureText]: Whether to hide input (for passwords), defaults to false
  /// - [maxLines]: Maximum number of lines, defaults to 1
  /// - [features]: List of input features (e.g., clear button, character count)
  ///
  /// See [TextInput] mixin documentation for full parameter details.
  const TextInputStatefulWidget({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.decoration,
    this.padding,
    this.placeholder,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.clearButtonSemanticLabel,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType = SmartDashesType.enabled,
    this.smartQuotesType = SmartQuotesType.enabled,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutside,
    this.onTapUpOutside,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorOpacityAnimates = true,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.onTap,
    this.autofillHints = const [],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.initialValue,
    this.hintText,
    this.border,
    this.borderRadius,
    this.filled,
    this.statesController,
    this.magnifierConfiguration,
    this.spellCheckConfiguration,
    this.undoController,
    this.features = const [],
    this.submitFormatters = const [],
    this.skipInputFeatureFocusTraversal = false,
  });

  /// Creates a copy of this text field with the given properties replaced.
  ///
  /// All parameters are optional and allow selective property replacement.
  TextField copyWith({
    ValueGetter<Key?>? key,
    ValueGetter<Object>? groupId,
    ValueGetter<TextEditingController?>? controller,
    ValueGetter<String?>? initialValue,
    ValueGetter<FocusNode?>? focusNode,
    ValueGetter<UndoHistoryController?>? undoController,
    ValueGetter<BoxDecoration?>? decoration,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Widget?>? placeholder,
    ValueGetter<CrossAxisAlignment>? crossAxisAlignment,
    ValueGetter<String?>? clearButtonSemanticLabel,
    ValueGetter<TextInputType?>? keyboardType,
    ValueGetter<TextInputAction?>? textInputAction,
    ValueGetter<TextCapitalization>? textCapitalization,
    ValueGetter<TextStyle?>? style,
    ValueGetter<StrutStyle?>? strutStyle,
    ValueGetter<TextAlign>? textAlign,
    ValueGetter<TextAlignVertical?>? textAlignVertical,
    ValueGetter<TextDirection?>? textDirection,
    ValueGetter<bool>? readOnly,
    ValueGetter<bool?>? showCursor,
    ValueGetter<bool>? autofocus,
    ValueGetter<String>? obscuringCharacter,
    ValueGetter<bool>? obscureText,
    ValueGetter<bool>? autocorrect,
    ValueGetter<SmartDashesType>? smartDashesType,
    ValueGetter<SmartQuotesType>? smartQuotesType,
    ValueGetter<bool>? enableSuggestions,
    ValueGetter<int?>? maxLines,
    ValueGetter<int?>? minLines,
    ValueGetter<bool>? expands,
    ValueGetter<int?>? maxLength,
    ValueGetter<MaxLengthEnforcement?>? maxLengthEnforcement,
    ValueGetter<ValueChanged<String>?>? onChanged,
    ValueGetter<VoidCallback?>? onEditingComplete,
    ValueGetter<ValueChanged<String>?>? onSubmitted,
    ValueGetter<TapRegionCallback?>? onTapOutside,
    ValueGetter<TapRegionCallback?>? onTapUpOutside,
    ValueGetter<List<TextInputFormatter>?>? inputFormatters,
    ValueGetter<bool>? enabled,
    ValueGetter<double>? cursorWidth,
    ValueGetter<double?>? cursorHeight,
    ValueGetter<Radius>? cursorRadius,
    ValueGetter<bool>? cursorOpacityAnimates,
    ValueGetter<Color?>? cursorColor,
    ValueGetter<ui.BoxHeightStyle>? selectionHeightStyle,
    ValueGetter<ui.BoxWidthStyle>? selectionWidthStyle,
    ValueGetter<Brightness?>? keyboardAppearance,
    ValueGetter<EdgeInsets>? scrollPadding,
    ValueGetter<bool>? enableInteractiveSelection,
    ValueGetter<TextSelectionControls?>? selectionControls,
    ValueGetter<DragStartBehavior>? dragStartBehavior,
    ValueGetter<ScrollController?>? scrollController,
    ValueGetter<ScrollPhysics?>? scrollPhysics,
    ValueGetter<GestureTapCallback?>? onTap,
    ValueGetter<Iterable<String>?>? autofillHints,
    ValueGetter<Clip>? clipBehavior,
    ValueGetter<String?>? restorationId,
    ValueGetter<bool>? stylusHandwritingEnabled,
    ValueGetter<bool>? enableIMEPersonalizedLearning,
    ValueGetter<ContentInsertionConfiguration?>? contentInsertionConfiguration,
    ValueGetter<EditableTextContextMenuBuilder?>? contextMenuBuilder,
    ValueGetter<String?>? hintText,
    ValueGetter<Border?>? border,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<bool?>? filled,
    ValueGetter<WidgetStatesController?>? statesController,
    ValueGetter<TextMagnifierConfiguration?>? magnifierConfiguration,
    ValueGetter<SpellCheckConfiguration?>? spellCheckConfiguration,
    ValueGetter<List<InputFeature>>? features,
    ValueGetter<List<TextInputFormatter>?>? submitFormatters,
    ValueGetter<bool>? skipInputFeatureFocusTraversal,
  }) {
    return TextField(
      key: key == null ? this.key : key(),
      groupId: groupId == null ? this.groupId : groupId(),
      controller: controller == null ? this.controller : controller(),
      initialValue: initialValue == null ? this.initialValue : initialValue(),
      focusNode: focusNode == null ? this.focusNode : focusNode(),
      undoController:
          undoController == null ? this.undoController : undoController(),
      decoration: decoration == null ? this.decoration : decoration(),
      padding: padding == null ? this.padding : padding(),
      placeholder: placeholder == null ? this.placeholder : placeholder(),
      crossAxisAlignment: crossAxisAlignment == null
          ? this.crossAxisAlignment
          : crossAxisAlignment(),
      clearButtonSemanticLabel: clearButtonSemanticLabel == null
          ? this.clearButtonSemanticLabel
          : clearButtonSemanticLabel(),
      keyboardType: keyboardType == null ? this.keyboardType : keyboardType(),
      textInputAction:
          textInputAction == null ? this.textInputAction : textInputAction(),
      textCapitalization: textCapitalization == null
          ? this.textCapitalization
          : textCapitalization(),
      style: style == null ? this.style : style(),
      strutStyle: strutStyle == null ? this.strutStyle : strutStyle(),
      textAlign: textAlign == null ? this.textAlign : textAlign(),
      textAlignVertical: textAlignVertical == null
          ? this.textAlignVertical
          : textAlignVertical(),
      textDirection:
          textDirection == null ? this.textDirection : textDirection(),
      readOnly: readOnly == null ? this.readOnly : readOnly(),
      showCursor: showCursor == null ? this.showCursor : showCursor(),
      autofocus: autofocus == null ? this.autofocus : autofocus(),
      obscuringCharacter: obscuringCharacter == null
          ? this.obscuringCharacter
          : obscuringCharacter(),
      obscureText: obscureText == null ? this.obscureText : obscureText(),
      autocorrect: autocorrect == null ? this.autocorrect : autocorrect(),
      smartDashesType:
          smartDashesType == null ? this.smartDashesType : smartDashesType(),
      smartQuotesType:
          smartQuotesType == null ? this.smartQuotesType : smartQuotesType(),
      enableSuggestions: enableSuggestions == null
          ? this.enableSuggestions
          : enableSuggestions(),
      maxLines: maxLines == null ? this.maxLines : maxLines(),
      minLines: minLines == null ? this.minLines : minLines(),
      expands: expands == null ? this.expands : expands(),
      maxLength: maxLength == null ? this.maxLength : maxLength(),
      maxLengthEnforcement: maxLengthEnforcement == null
          ? this.maxLengthEnforcement
          : maxLengthEnforcement(),
      onChanged: onChanged == null ? this.onChanged : onChanged(),
      onEditingComplete: onEditingComplete == null
          ? this.onEditingComplete
          : onEditingComplete(),
      onSubmitted: onSubmitted == null ? this.onSubmitted : onSubmitted(),
      onTapOutside: onTapOutside == null ? this.onTapOutside : onTapOutside(),
      onTapUpOutside:
          onTapUpOutside == null ? this.onTapUpOutside : onTapUpOutside(),
      inputFormatters:
          inputFormatters == null ? this.inputFormatters : inputFormatters(),
      enabled: enabled == null ? this.enabled : enabled(),
      cursorWidth: cursorWidth == null ? this.cursorWidth : cursorWidth(),
      cursorHeight: cursorHeight == null ? this.cursorHeight : cursorHeight(),
      cursorRadius: cursorRadius == null ? this.cursorRadius : cursorRadius(),
      cursorOpacityAnimates: cursorOpacityAnimates == null
          ? this.cursorOpacityAnimates
          : cursorOpacityAnimates(),
      cursorColor: cursorColor == null ? this.cursorColor : cursorColor(),
      selectionHeightStyle: selectionHeightStyle == null
          ? this.selectionHeightStyle
          : selectionHeightStyle(),
      selectionWidthStyle: selectionWidthStyle == null
          ? this.selectionWidthStyle
          : selectionWidthStyle(),
      keyboardAppearance: keyboardAppearance == null
          ? this.keyboardAppearance
          : keyboardAppearance(),
      scrollPadding:
          scrollPadding == null ? this.scrollPadding : scrollPadding(),
      enableInteractiveSelection: enableInteractiveSelection == null
          ? this.enableInteractiveSelection
          : enableInteractiveSelection(),
      selectionControls: selectionControls == null
          ? this.selectionControls
          : selectionControls(),
      dragStartBehavior: dragStartBehavior == null
          ? this.dragStartBehavior
          : dragStartBehavior(),
      scrollController:
          scrollController == null ? this.scrollController : scrollController(),
      scrollPhysics:
          scrollPhysics == null ? this.scrollPhysics : scrollPhysics(),
      onTap: onTap == null ? this.onTap : onTap(),
      autofillHints:
          autofillHints == null ? this.autofillHints : autofillHints(),
      clipBehavior: clipBehavior == null ? this.clipBehavior : clipBehavior(),
      restorationId:
          restorationId == null ? this.restorationId : restorationId(),
      stylusHandwritingEnabled: stylusHandwritingEnabled == null
          ? this.stylusHandwritingEnabled
          : stylusHandwritingEnabled(),
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning == null
          ? this.enableIMEPersonalizedLearning
          : enableIMEPersonalizedLearning(),
      contentInsertionConfiguration: contentInsertionConfiguration == null
          ? this.contentInsertionConfiguration
          : contentInsertionConfiguration(),
      contextMenuBuilder: contextMenuBuilder == null
          ? this.contextMenuBuilder
          : contextMenuBuilder(),
      hintText: hintText == null ? this.hintText : hintText(),
      border: border == null ? this.border : border(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      filled: filled == null ? this.filled : filled(),
      statesController:
          statesController == null ? this.statesController : statesController(),
      magnifierConfiguration: magnifierConfiguration == null
          ? this.magnifierConfiguration
          : magnifierConfiguration(),
      spellCheckConfiguration: spellCheckConfiguration == null
          ? this.spellCheckConfiguration
          : spellCheckConfiguration(),
      features: features == null ? this.features : features(),
      submitFormatters:
          submitFormatters == null ? this.submitFormatters : submitFormatters(),
      skipInputFeatureFocusTraversal: skipInputFeatureFocusTraversal == null
          ? this.skipInputFeatureFocusTraversal
          : skipInputFeatureFocusTraversal(),
    );
  }
}

/// A highly customizable single-line text input widget with extensive feature support.
///
/// [TextField] provides a comprehensive text editing experience with support for
/// a wide range of input types, validation, formatting, and interactive features.
/// It serves as the foundation for most text input scenarios in the shadcn_flutter
/// design system, offering both basic text input and advanced capabilities through
/// its feature system.
///
/// Key features:
/// - Comprehensive text input with platform-native behavior
/// - Extensive customization through [InputFeature] system
/// - Built-in support for validation and formatting
/// - Configurable appearance with theming support
/// - Context menu customization and clipboard operations
/// - Keyboard shortcuts and accessibility support
/// - Form integration with automatic value management
///
/// The widget supports various input modes:
/// - Single-line text input (default)
/// - Obscured text for passwords
/// - Formatted input with custom formatters
/// - Auto-completion and suggestions
/// - Numeric input with spinners
///
/// Input features can be added to enhance functionality:
/// - Clear button for easy text clearing
/// - Password visibility toggle
/// - Copy/paste operations
/// - Auto-complete suggestions
/// - Validation indicators
/// - Custom leading/trailing widgets
///
/// Example:
/// ```dart
/// TextField(
///   hintText: 'Enter your email',
///   keyboardType: TextInputType.emailAddress,
///   features: [
///     InputClearFeature(),
///     InputRevalidateFeature(),
///   ],
///   onChanged: (text) => _handleTextChange(text),
/// );
/// ```
class TextField extends TextInputStatefulWidget {
  /// Returns a native platform context menu builder.
  ///
  /// Uses the platform's default text selection toolbar.
  static EditableTextContextMenuBuilder nativeContextMenuBuilder() {
    return (context, editableTextState) {
      return material.AdaptiveTextSelectionToolbar.editableText(
          editableTextState: editableTextState);
    };
  }

  /// Returns a Cupertino-style context menu builder.
  ///
  /// Uses iOS-style text selection toolbar.
  static EditableTextContextMenuBuilder cupertinoContextMenuBuilder() {
    return (context, editableTextState) {
      return cupertino.CupertinoAdaptiveTextSelectionToolbar.editableText(
          editableTextState: editableTextState);
    };
  }

  /// Returns a Material Design context menu builder.
  ///
  /// Uses Material Design text selection toolbar.
  static EditableTextContextMenuBuilder materialContextMenuBuilder() {
    return (context, editableTextState) {
      final anchors = editableTextState.contextMenuAnchors;
      return material.TextSelectionToolbar(
        anchorAbove: anchors.primaryAnchor,
        anchorBelow: anchors.secondaryAnchor == null
            ? anchors.primaryAnchor
            : anchors.secondaryAnchor!,
        children: _getMaterialButtons(
            context, editableTextState.contextMenuButtonItems),
      );
    };
  }

  static List<Widget> _getMaterialButtons(
    BuildContext context,
    List<ContextMenuButtonItem> buttonItems,
  ) {
    final List<Widget> buttons = <Widget>[];
    for (int i = 0; i < buttonItems.length; i++) {
      final ContextMenuButtonItem buttonItem = buttonItems[i];
      buttons.add(
        material.TextSelectionToolbarTextButton(
          padding: material.TextSelectionToolbarTextButton.getPadding(
              i, buttonItems.length),
          onPressed: buttonItem.onPressed,
          alignment: AlignmentDirectional.centerStart,
          child: Text(_getMaterialButtonLabel(context, buttonItem)),
        ),
      );
    }
    return buttons;
  }

  static String _getMaterialButtonLabel(
      BuildContext context, ContextMenuButtonItem buttonItem) {
    final localizations = material.MaterialLocalizations.of(context);
    return switch (buttonItem.type) {
      ContextMenuButtonType.cut => localizations.cutButtonLabel,
      ContextMenuButtonType.copy => localizations.copyButtonLabel,
      ContextMenuButtonType.paste => localizations.pasteButtonLabel,
      ContextMenuButtonType.selectAll => localizations.selectAllButtonLabel,
      ContextMenuButtonType.delete =>
        localizations.deleteButtonTooltip.toUpperCase(),
      ContextMenuButtonType.lookUp => localizations.lookUpButtonLabel,
      ContextMenuButtonType.searchWeb => localizations.searchWebButtonLabel,
      ContextMenuButtonType.share => localizations.shareButtonLabel,
      ContextMenuButtonType.liveTextInput => localizations.scanTextButtonLabel,
      ContextMenuButtonType.custom => '',
    };
  }

  /// Creates a text input field widget.
  ///
  /// A comprehensive text field implementation with support for various input
  /// types, validation, formatting, and interactive features. All parameters
  /// are forwarded to the parent [TextInputStatefulWidget] constructor.
  ///
  /// This constructor provides extensive customization options matching Flutter's
  /// [EditableText] while adding custom features like input decorations, features,
  /// and form integration.
  ///
  /// Example:
  /// ```dart
  /// TextField(
  ///   controller: myController,
  ///   hintText: 'Enter text',
  ///   keyboardType: TextInputType.text,
  ///   maxLines: 3,
  ///   onChanged: (value) => print(value),
  /// )
  /// ```
  ///
  /// See [TextInputStatefulWidget] and [TextInput] for parameter details.
  const TextField({
    super.key,
    super.groupId,
    super.controller,
    super.initialValue,
    super.focusNode,
    super.undoController,
    super.decoration,
    super.padding,
    super.placeholder,
    super.crossAxisAlignment,
    super.clearButtonSemanticLabel,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly,
    super.showCursor,
    super.autofocus,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onTapOutside,
    super.onTapUpOutside,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.dragStartBehavior,
    super.scrollController,
    super.scrollPhysics,
    super.onTap,
    super.autofillHints,
    super.clipBehavior,
    super.restorationId,
    super.stylusHandwritingEnabled,
    super.enableIMEPersonalizedLearning,
    super.contentInsertionConfiguration,
    super.contextMenuBuilder = defaultContextMenuBuilder,
    super.hintText,
    super.border,
    super.borderRadius,
    super.filled,
    super.statesController,
    super.magnifierConfiguration,
    super.spellCheckConfiguration,
    super.features,
    super.submitFormatters,
    super.skipInputFeatureFocusTraversal,
  });

  /// Default context menu builder for editable text.
  ///
  /// Builds the standard context menu for text selection operations.
  static Widget defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return buildEditableTextContextMenu(context, editableTextState);
  }

  /// Default spell check suggestions toolbar builder.
  ///
  /// Builds the toolbar showing spell check suggestions.
  @visibleForTesting
  static Widget defaultSpellCheckSuggestionsToolbarBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return CupertinoSpellCheckSuggestionsToolbar.editableText(
        editableTextState: editableTextState);
  }

  @override
  State<TextField> createState() => TextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>('controller', controller,
          defaultValue: null),
    );
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode,
        defaultValue: null));
    properties.add(
      DiagnosticsProperty<UndoHistoryController>(
        'undoController',
        undoController,
        defaultValue: null,
      ),
    );
    properties
        .add(DiagnosticsProperty<BoxDecoration>('decoration', decoration));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(
      DiagnosticsProperty<String>(
          'clearButtonSemanticLabel', clearButtonSemanticLabel),
    );
    properties.add(
      DiagnosticsProperty<TextInputType>(
        'keyboardType',
        keyboardType,
        defaultValue: TextInputType.text,
      ),
    );
    properties.add(
        DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(
      DiagnosticsProperty<String>('obscuringCharacter', obscuringCharacter,
          defaultValue: '•'),
    );
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect,
        defaultValue: true));
    properties.add(
      EnumProperty<SmartDashesType>(
        'smartDashesType',
        smartDashesType,
        defaultValue:
            obscureText ? SmartDashesType.disabled : SmartDashesType.enabled,
      ),
    );
    properties.add(
      EnumProperty<SmartQuotesType>(
        'smartQuotesType',
        smartQuotesType,
        defaultValue:
            obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>('enableSuggestions', enableSuggestions,
          defaultValue: true),
    );
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
    properties.add(
      EnumProperty<MaxLengthEnforcement>(
        'maxLengthEnforcement',
        maxLengthEnforcement,
        defaultValue: null,
      ),
    );
    properties
        .add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
    properties
        .add(DoubleProperty('cursorHeight', cursorHeight, defaultValue: null));
    properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius,
        defaultValue: null));
    properties.add(
      DiagnosticsProperty<bool>('cursorOpacityAnimates', cursorOpacityAnimates,
          defaultValue: true),
    );
    properties.add(ColorProperty('cursorColor', cursorColor));
    properties.add(
      DiagnosticsProperty<TextSelectionControls>(
        'selectionControls',
        selectionControls,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<ScrollController>(
        'scrollController',
        scrollController,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<ScrollPhysics>('scrollPhysics', scrollPhysics,
          defaultValue: null),
    );
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign,
        defaultValue: TextAlign.start));
    properties.add(
      DiagnosticsProperty<TextAlignVertical>(
        'textAlignVertical',
        textAlignVertical,
        defaultValue: null,
      ),
    );
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties.add(
      DiagnosticsProperty<Clip>('clipBehavior', clipBehavior,
          defaultValue: Clip.hardEdge),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'stylusHandwritingEnabled',
        stylusHandwritingEnabled,
        defaultValue: EditableText.defaultStylusHandwritingEnabled,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'enableIMEPersonalizedLearning',
        enableIMEPersonalizedLearning,
        defaultValue: true,
      ),
    );
    properties.add(
      DiagnosticsProperty<SpellCheckConfiguration>(
        'spellCheckConfiguration',
        spellCheckConfiguration,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<List<String>>(
        'contentCommitMimeTypes',
        contentInsertionConfiguration?.allowedMimeTypes ?? const <String>[],
        defaultValue: contentInsertionConfiguration == null
            ? const <String>[]
            : kDefaultContentInsertionMimeTypes,
      ),
    );
    properties.add(IterableProperty<InputFeature>('features', features));
  }
}

class _AttachedInputFeature {
  InputFeature feature;
  final InputFeatureState state;
  _AttachedInputFeature(this.feature, this.state);
}

/// State class for [TextField] widget.
///
/// Manages the text field's state including text editing, selection,
/// input features, form integration, and restoration.
class TextFieldState extends State<TextField>
    with
        RestorationMixin,
        AutomaticKeepAliveClientMixin<TextField>,
        FormValueSupplier<String, TextField>,
        TickerProviderStateMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  final ValueNotifier<String> _effectiveText = ValueNotifier('');
  final ValueNotifier<TextSelection> _effectiveSelection =
      ValueNotifier(const TextSelection.collapsed(offset: -1));
  final GlobalKey _clearGlobalKey = GlobalKey();

  final List<_AttachedInputFeature> _attachedFeatures = [];

  late WidgetStatesController _statesController;

  RestorableTextEditingController? _controller;

  /// The effective text editing controller for this text field.
  ///
  /// Returns the widget's controller or the internally created controller.
  TextEditingController get effectiveController =>
      widget.controller ?? _controller!.value;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement();

  bool _showSelectionHandles = false;

  late _TextFieldSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  void _setStateFeature(VoidCallback fn) {
    setState(fn);
  }

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  bool get forcePressEnabled => true;

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled =>
      widget.enableInteractiveSelection && widget.enabled;
  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _TextFieldSelectionGestureDetectorBuilder(
      state: this,
    );
    if (widget.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
    _statesController = widget.statesController ?? WidgetStatesController();
    String effectiveText = widget.controller?.text ?? widget.initialValue ?? '';
    formValue = effectiveText.isEmpty ? null : effectiveText;
    for (final feature in widget.features) {
      final state = feature.createState();
      state._attached = _AttachedInputFeature(feature, state);
      state._inputState = this;
      state.initState();
      _attachedFeatures.add(state._attached!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final attached in _attachedFeatures) {
      attached.state.didChangeDependencies();
    }
  }

  @override
  void didUpdateWidget(TextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);
      if (widget.controller != null) {
        _handleControllerChanged();
      }
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;

    for (var i = 0;
        i < max(oldWidget.features.length, widget.features.length);
        i++) {
      if (i >= oldWidget.features.length) {
        final newFeature = widget.features[i];
        final newState = newFeature.createState();
        newState._attached = _AttachedInputFeature(newFeature, newState);
        newState._inputState = this;
        newState.initState();
        newState.didChangeDependencies();
        _attachedFeatures.add(newState._attached!);
        continue;
      }
      if (i >= widget.features.length) {
        final oldState = _attachedFeatures[i].state;
        oldState.dispose();
        _attachedFeatures.removeAt(i);
        continue;
      }
      final oldFeature = oldWidget.features[i];
      final newFeature = widget.features[i];
      final oldState = _attachedFeatures[i].state;
      if (!InputFeature.canUpdate(oldFeature, newFeature)) {
        oldState.dispose();
        final newState = newFeature.createState();
        newState._attached = _AttachedInputFeature(newFeature, newState);
        newState._inputState = this;
        newState.initState();
        newState.didChangeDependencies();
        _attachedFeatures[i] = newState._attached!;
      } else {
        oldState._attached!.feature = newFeature;
        oldState.didFeatureUpdate(oldFeature);
      }
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
    _controller!.value.addListener(updateKeepAlive);
    _controller!.value.addListener(_handleControllerChanged);
  }

  void _handleControllerChanged() {
    _effectiveText.value = effectiveController.text;
    _effectiveSelection.value = effectiveController.selection;
    formValue =
        effectiveController.text.isEmpty ? null : effectiveController.text;
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (value != null) {
      _effectiveText.value = value.text;
      _effectiveSelection.value = value.selection;
    }
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    for (final attached in _attachedFeatures) {
      attached.state.dispose();
    }
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  EditableTextState get _editableText => editableTextKey.currentState!;

  void _requestKeyboard() {
    _editableText.requestKeyboard();
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection
      // highlight.
    });
    _statesController.update(WidgetState.focused, _effectiveFocusNode.hasFocus);
    if (!_effectiveFocusNode.hasFocus) {
      _formatSubmit();
    }
  }

  void _formatSubmit() {
    if (widget.submitFormatters != null) {
      TextEditingValue value = effectiveController.value;
      for (var formatter in widget.submitFormatters!) {
        value = formatter.formatEditUpdate(value, value);
      }
      if (value != effectiveController.value) {
        effectiveController.value = value;
        widget.onChanged?.call(value.text);
      }
    }
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    // On iOS, we don't show handles when the selection is collapsed.
    if (effectiveController.selection.isCollapsed) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (cause == SelectionChangedCause.stylusHandwriting) {
      return true;
    }

    if (effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    _effectiveSelection.value = selection;
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText.bringIntoView(selection.extent);
        }
      // ignore: unreachable_switch_default
      default:
        // using the normal flutter sdk, this is unreachable.
        // but for other forks like flutter for ohos, we keep it
        // so that they can add their own platform specific behavior.
        if (cause == SelectionChangedCause.longPress) {
          _editableText.bringIntoView(selection.extent);
        }
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText.hideToolbar();
        }
      // ignore: unreachable_switch_default
      default:
        if (cause == SelectionChangedCause.drag) {
          _editableText.hideToolbar();
        }
    }

    for (final attached in _attachedFeatures) {
      attached.state.onSelectionChanged(selection);
    }
  }

  @override
  bool get wantKeepAlive => _controller?.value.text.isNotEmpty ?? false;

  // True if any surrounding decoration widgets will be shown.
  bool get _hasDecoration {
    return widget.placeholder != null || widget.features.isNotEmpty;
  }

  // Provide default behavior if widget.textAlignVertical is not set.
  // CupertinoTextField has top alignment by default, unless it has decoration
  // like a prefix or suffix, in which case it's aligned to the center.
  TextAlignVertical get _textAlignVertical {
    if (widget.textAlignVertical != null) {
      return widget.textAlignVertical!;
    }
    return _hasDecoration ? TextAlignVertical.center : TextAlignVertical.top;
  }

  @override
  TextField get widget {
    TextField widget = super.widget;
    for (final attached in _attachedFeatures) {
      widget = attached.state.interceptInput(widget);
    }
    return widget;
  }

  Widget _addTextDependentAttachments(
    Widget editableText,
    TextStyle textStyle,
    ThemeData theme,
  ) {
    var widget = this.widget;
    // If there are no surrounding widgets, just return the core editable text
    // part.
    if (!_hasDecoration) {
      return editableText;
    }

    // Otherwise, listen to the current state of the text entry.
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: effectiveController,
      child: editableText,
      builder: (BuildContext context, TextEditingValue text, Widget? child) {
        final bool hasText = text.text.isNotEmpty;
        final Widget? placeholder = widget.placeholder == null
            ? null
            // Make the placeholder invisible when hasText is true.
            : Visibility(
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                visible: !hasText,
                child: SizedBox(
                  width: double.infinity,
                  child: DefaultTextStyle(
                    style: textStyle
                        .merge(theme.typography.small)
                        .merge(theme.typography.normal)
                        .copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                    textAlign: widget.textAlign,
                    maxLines: widget.maxLines,
                    child: widget.placeholder!,
                  ),
                ),
              );

        List<Widget> leadingChildren = [];
        List<Widget> trailingChildren = [];
        for (final attached in _attachedFeatures) {
          leadingChildren.addAll(attached.state._internalBuildLeading().map(
                (e) => Focus(
                  skipTraversal: widget.skipInputFeatureFocusTraversal ||
                      attached.feature.skipFocusTraversal,
                  child: e,
                ),
              ));
          trailingChildren.addAll(attached.state._internalBuildTrailing().map(
                (e) => FocusScope(
                  skipTraversal: widget.skipInputFeatureFocusTraversal ||
                      attached.feature.skipFocusTraversal,
                  child: e,
                ),
              ));
        }

        Widget leadingWidget = Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4 * theme.scaling,
          children: leadingChildren,
        );

        Widget trailingWidget = Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4 * theme.scaling,
          children: trailingChildren,
        );

        return Row(
          crossAxisAlignment: widget.crossAxisAlignment,
          spacing: 8.0 * theme.scaling,
          children: [
            // Insert a prefix at the front if the prefix visibility mode matches
            // the current text state.
            if (leadingChildren.isNotEmpty) leadingWidget,
            // In the middle part, stack the placeholder on top of the main EditableText
            // if needed.
            Expanded(
              child: Stack(
                // Ideally this should be baseline aligned. However that comes at
                // the cost of the ability to compute the intrinsic dimensions of
                // this widget.
                // See also https://github.com/flutter/flutter/issues/13715.
                alignment: AlignmentDirectional.center,
                textDirection: widget.textDirection,
                children: <Widget>[
                  if (placeholder != null) placeholder,
                  editableText
                ],
              ),
            ),
            if (trailingChildren.isNotEmpty) trailingWidget,
          ],
        );
      },
    );
  }

  // AutofillClient implementation start.
  @override
  String get autofillId => _editableText.autofillId;

  @override
  void autofill(TextEditingValue newEditingValue) =>
      _editableText.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    var widget = this.widget;
    final List<String>? autofillHints =
        widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: effectiveController.value,
            hintText: widget.hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText.textInputConfiguration.copyWith(
      autofillConfiguration: autofillConfiguration,
    );
  }
  // AutofillClient implementation end.

  void _onChanged(String value) {
    var widget = this.widget;
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    formValue = value.isEmpty ? null : value;
    _effectiveText.value = value;

    for (final attached in _attachedFeatures) {
      attached.state.onTextChanged(value);
    }
  }

  void _onEnter(PointerEnterEvent event) {
    _statesController.update(WidgetState.hovered, true);
  }

  void _onExit(PointerExitEvent event) {
    _statesController.update(WidgetState.hovered, false);
  }

  Widget _wrapActions({required Widget child}) {
    Map<Type, Action<Intent>> featureActions = {};
    Map<ShortcutActivator, Intent> featureShortcuts = {};
    for (final attached in _attachedFeatures) {
      for (final action in attached.state.buildActions()) {
        featureActions[action.key] = action.value;
      }
      for (final shortcut in attached.state.buildShortcuts()) {
        featureShortcuts[shortcut.key] = shortcut.value;
      }
    }
    return Actions(
        actions: {
          TextFieldClearIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<TextFieldClearIntent>(
              onInvoke: (intent) {
                effectiveController.clear();
                return;
              },
            ),
          ),
          TextFieldAppendTextIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<TextFieldAppendTextIntent>(
              onInvoke: (intent) {
                _appendText(intent.text);
                return;
              },
            ),
          ),
          TextFieldReplaceCurrentWordIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<TextFieldReplaceCurrentWordIntent>(
              onInvoke: (intent) {
                _replaceCurrentWord(intent.text);
                return;
              },
            ),
          ),
          TextFieldSetTextIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<TextFieldSetTextIntent>(
              onInvoke: (intent) {
                _setText(intent.text);
                return;
              },
            ),
          ),
          TextFieldSetSelectionIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<TextFieldSetSelectionIntent>(
              onInvoke: (intent) {
                effectiveController.selection = intent.selection;
                return;
              },
            ),
          ),
          TextFieldSelectAllAndCopyIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<TextFieldSelectAllAndCopyIntent>(
              onInvoke: (intent) {
                effectiveController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: effectiveController.text.length,
                );
                var text = effectiveController.text;
                if (text.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: text));
                }
                return;
              },
            ),
          ),
          AutoCompleteIntent: Action.overridable(
            context: context,
            defaultAction: CallbackAction<AutoCompleteIntent>(
              onInvoke: (intent) {
                switch (intent.mode) {
                  case AutoCompleteMode.append:
                    _appendText(intent.suggestion);
                    break;
                  case AutoCompleteMode.replaceWord:
                    _replaceCurrentWord(intent.suggestion);
                    break;
                  case AutoCompleteMode.replaceAll:
                    _setText(intent.suggestion);
                    break;
                }
                return;
              },
            ),
          ),
          ...featureActions,
        },
        child: Shortcuts(
          shortcuts: featureShortcuts,
          child: child,
        ));
  }

  void _appendText(String text) {
    final newText = effectiveController.text + text;
    effectiveController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  void _replaceCurrentWord(String text) {
    final replacement = text;
    final value = effectiveController.value;
    final selection = value.selection;
    if (selection.isCollapsed) {
      int start = selection.start;
      final newText =
          replaceWordAtCaret(value.text, start, replacement, (char) {
        return char == ' ' ||
            char == '\n' ||
            char == '\t' ||
            ChipInput.isChipCharacter(char);
      });
      effectiveController.value = TextEditingValue(
        text: newText.$2,
        selection: TextSelection.collapsed(
          offset: newText.$1 + replacement.length,
        ),
      );
    }
  }

  void _setText(String text) {
    effectiveController.value = TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }

  @override
  Widget build(BuildContext context) {
    var widget = this.widget;
    super.build(context); // See AutomaticKeepAliveClientMixin.
    final ThemeData theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TextFieldTheme>(context);
    assert(debugCheckHasDirectionality(context));
    final TextEditingController controller = effectiveController;

    TextSelectionControls? textSelectionControls = widget.selectionControls;
    VoidCallback? handleDidGainAccessibilityFocus;
    VoidCallback? handleDidLoseAccessibilityFocus;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        textSelectionControls ??= cupertinoDesktopTextSelectionHandleControls;
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus &&
              _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          _effectiveFocusNode.unfocus();
        };
      // ignore: unreachable_switch_default
      default:
        textSelectionControls ??= cupertinoDesktopTextSelectionHandleControls;
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus &&
              _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          _effectiveFocusNode.unfocus();
        };
    }

    final bool enabled = widget.enabled;
    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    TextStyle defaultTextStyle;
    if (widget.style != null) {
      defaultTextStyle = DefaultTextStyle.of(context)
          .style
          .merge(theme.typography.small)
          .merge(theme.typography.normal)
          .copyWith(
            color: theme.colorScheme.foreground,
          )
          .merge(widget.style);
    } else {
      defaultTextStyle = DefaultTextStyle.of(context)
          .style
          .merge(theme.typography.small)
          .merge(theme.typography.normal)
          .copyWith(
            color: theme.colorScheme.foreground,
          );
    }

    final Brightness keyboardAppearance =
        widget.keyboardAppearance ?? theme.brightness;
    final Color cursorColor = widget.cursorColor ??
        DefaultSelectionStyle.of(context).cursorColor ??
        theme.colorScheme.primary;

    // Use the default disabled color only if the box decoration was not set.
    final effectiveBorder = styleValue(
      defaultValue: Border.all(
        color: theme.colorScheme.border,
      ),
      themeValue: compTheme?.border,
      widgetValue: widget.border,
    );
    Decoration effectiveDecoration = widget.decoration ??
        BoxDecoration(
          borderRadius: optionallyResolveBorderRadius(
                context,
                widget.borderRadius ?? compTheme?.borderRadius,
              ) ??
              BorderRadius.circular(theme.radiusMd),
          color: (widget.filled ?? compTheme?.filled ?? false)
              ? theme.colorScheme.muted
              : theme.colorScheme.input.scaleAlpha(0.3),
          border: effectiveBorder,
        );

    // final inputGroup = InputGroupData.maybeOf(context);
    // if (inputGroup != null) {
    //   effectiveDecoration = inputGroup.applyBoxDecoration(effectiveDecoration, Directionality.maybeOf(context) ?? TextDirection.ltr);
    // }
    final styleOverride = Data.maybeOf<ButtonStyleOverrideData>(context);
    if (styleOverride != null) {
      effectiveDecoration = styleOverride.decoration
              ?.call(context, _statesController.value, effectiveDecoration) ??
          effectiveDecoration;
    }

    final Color selectionColor =
        DefaultSelectionStyle.of(context).selectionColor ??
            theme.colorScheme.primary.withValues(
              alpha: 0.2,
            );

    // Set configuration as disabled if not otherwise specified. If specified,
    // ensure that configuration uses Cupertino text style for misspelled words
    // unless a custom style is specified.
    final SpellCheckConfiguration spellCheckConfiguration =
        widget.spellCheckConfiguration ??
            const SpellCheckConfiguration.disabled();

    final scaling = theme.scaling;
    final Widget editable = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          controller: controller,
          undoController: widget.undoController,
          readOnly: widget.readOnly || !enabled,
          showCursor: widget.showCursor,
          showSelectionHandles: _showSelectionHandles,
          focusNode: _effectiveFocusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          autofillHints: widget.autofillHints,
          style: defaultTextStyle,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          magnifierConfiguration: widget.magnifierConfiguration ??
              const TextMagnifierConfiguration(),
          // Only show the selection highlight when the text field is focused.
          selectionColor: _effectiveFocusNode.hasFocus ? selectionColor : null,
          selectionControls: selectionEnabled ? textSelectionControls : null,
          groupId: widget.groupId,
          onChanged: _onChanged,
          onSelectionChanged: _handleSelectionChanged,
          onEditingComplete: () {
            widget.onEditingComplete?.call();
            _formatSubmit();
          },
          onSubmitted: (value) {
            widget.onSubmitted?.call(value);
            _formatSubmit();
          },
          onTapOutside: widget.onTapOutside,
          inputFormatters: formatters,
          rendererIgnoresPointer: true,
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: widget.cursorRadius,
          cursorColor: cursorColor,
          cursorOpacityAnimates: widget.cursorOpacityAnimates,
          paintCursorAboveText: true,
          autocorrectionTextRectColor: selectionColor,
          backgroundCursorColor: theme.colorScheme.border,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          scrollPadding: widget.scrollPadding,
          keyboardAppearance: keyboardAppearance,
          dragStartBehavior: widget.dragStartBehavior,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          autofillClient: this,
          clipBehavior: Clip.none,
          restorationId: 'editable',
          stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          spellCheckConfiguration: spellCheckConfiguration,
        ),
      ),
    );

    Widget textField = MouseRegion(
      cursor: enabled ? SystemMouseCursors.text : SystemMouseCursors.forbidden,
      child: FocusOutline(
        focused: _effectiveFocusNode.hasFocus,
        borderRadius: effectiveDecoration is BoxDecoration
            ? effectiveDecoration.borderRadius
            : null,
        child: IconTheme.merge(
          data: theme.iconTheme.small.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
          child: _wrapActions(
            child: MouseRegion(
              onEnter: _onEnter,
              onExit: _onExit,
              opaque: false,
              child: Semantics(
                enabled: enabled,
                onTap: !enabled || widget.readOnly
                    ? null
                    : () {
                        if (!controller.selection.isValid) {
                          controller.selection = TextSelection.collapsed(
                              offset: controller.text.length);
                        }
                        _requestKeyboard();
                      },
                onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
                onDidLoseAccessibilityFocus: handleDidLoseAccessibilityFocus,
                onFocus: enabled
                    ? () {
                        assert(
                          _effectiveFocusNode.canRequestFocus,
                          'Received SemanticsAction.focus from the engine. However, the FocusNode '
                          'of this text field cannot gain focus. This likely indicates a bug. '
                          'If this text field cannot be focused (e.g. because it is not '
                          'enabled), then its corresponding semantics node must be configured '
                          'such that the assistive technology cannot request focus on it.',
                        );

                        if (_effectiveFocusNode.canRequestFocus &&
                            !_effectiveFocusNode.hasFocus) {
                          _effectiveFocusNode.requestFocus();
                        } else if (!widget.readOnly) {
                          // If the platform requested focus, that means that previously the
                          // platform believed that the text field did not have focus (even
                          // though Flutter's widget system believed otherwise). This likely
                          // means that the on-screen keyboard is hidden, or more generally,
                          // there is no current editing session in this field. To correct
                          // that, keyboard must be requested.
                          //
                          // A concrete scenario where this can happen is when the user
                          // dismisses the keyboard on the web. The editing session is
                          // closed by the engine, but the text field widget stays focused
                          // in the framework.
                          _requestKeyboard();
                        }
                      }
                    : null,
                child: TextFieldTapRegion(
                  child: IgnorePointer(
                    ignoring: !enabled,
                    child: Container(
                      clipBehavior: widget.clipBehavior,
                      decoration: effectiveDecoration,
                      child:
                          _selectionGestureDetectorBuilder.buildGestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Align(
                          alignment: Alignment(-1.0, _textAlignVertical.y),
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Padding(
                            padding: widget.padding ??
                                compTheme?.padding ??
                                EdgeInsets.symmetric(
                                  horizontal: 12 * scaling,
                                  vertical: 8 * scaling,
                                ),
                            child: _addTextDependentAttachments(
                                editable, defaultTextStyle, theme),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    for (final attached in _attachedFeatures) {
      textField = attached.state.wrap(textField);
    }

    double fontHeight =
        (defaultTextStyle.fontSize ?? 14.0) * (defaultTextStyle.height ?? 1.0);
    double verticalPadding = (widget.padding?.vertical ??
        compTheme?.padding?.vertical ??
        (8.0 * 2 * theme.scaling));

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: fontHeight + verticalPadding,
      ),
      child: WidgetStatesProvider(
        states: {
          if (_effectiveFocusNode.hasFocus) WidgetState.hovered,
        },
        child: textField,
      ),
    );
  }

  @override
  void didReplaceFormValue(String value) {
    effectiveController.text = value;
    widget.onChanged?.call(value);
  }
}

/// Intent to append text to the current text field content.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// append text to a text field.
class TextFieldAppendTextIntent extends Intent {
  /// Creates a [TextFieldAppendTextIntent] with the text to append.
  const TextFieldAppendTextIntent({required this.text});

  /// The text to append to the current content.
  final String text;
}

/// Intent to clear all text from the text field.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// clear text field content.
class TextFieldClearIntent extends Intent {
  /// Creates a [TextFieldClearIntent].
  const TextFieldClearIntent();
}

/// Intent to replace the current word in the text field.
///
/// Replaces the word at the current cursor position with new text.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldReplaceCurrentWordIntent extends Intent {
  /// Creates a [TextFieldReplaceCurrentWordIntent] with replacement text.
  const TextFieldReplaceCurrentWordIntent({required this.text});

  /// The text to replace the current word with.
  final String text;
}

/// Intent to set the entire text field content to a specific value.
///
/// Replaces all existing text with the provided text.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldSetTextIntent extends Intent {
  /// Creates a [TextFieldSetTextIntent] with the new text.
  const TextFieldSetTextIntent({required this.text});

  /// The text to set as the field's content.
  final String text;
}

/// Intent to set the text selection in the text field.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// control cursor position and text selection.
class TextFieldSetSelectionIntent extends Intent {
  /// The text selection to apply.
  final TextSelection selection;

  /// Creates a [TextFieldSetSelectionIntent] with the selection.
  const TextFieldSetSelectionIntent({required this.selection});
}

/// Intent to select all text in the field and copy it to clipboard.
///
/// Combines selection and copy operations in a single intent.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldSelectAllAndCopyIntent extends Intent {
  /// Creates a [TextFieldSelectAllAndCopyIntent].
  const TextFieldSelectAllAndCopyIntent();
}
