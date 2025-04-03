// This file contains mostly patches from another package/sdk
// due to changes that need to be made but cannot be done normally
import 'dart:math';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart'
    show
        CupertinoSpellCheckSuggestionsToolbar,
        cupertinoDesktopTextSelectionHandleControls;
import 'package:flutter/foundation.dart'
    show IterableProperty, defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/hidden.dart';

import '../../../shadcn_flutter.dart';

export 'package:flutter/services.dart'
    show
        SmartDashesType,
        SmartQuotesType,
        TextCapitalization,
        TextInputAction,
        TextInputType;

const kTextFieldHeight = 34;

abstract class InputFeatureVisibility {
  const factory InputFeatureVisibility.and(
    Iterable<InputFeatureVisibility> features,
  ) = _LogicAndInputFeatureVisibility;
  const factory InputFeatureVisibility.or(
    Iterable<InputFeatureVisibility> features,
  ) = _LogicOrInputFeatureVisibility;
  const factory InputFeatureVisibility.not(InputFeatureVisibility feature) =
      _NegateInputFeatureVisibility;
  static const InputFeatureVisibility textNotEmpty =
      _TextNotEmptyInputFeatureVisibility();
  static const InputFeatureVisibility textEmpty =
      _TextEmptyInputFeatureVisibility();
  static const InputFeatureVisibility focused =
      _FocusedInputFeatureVisibility();
  static const InputFeatureVisibility hovered =
      _HoveredInputFeatureVisibility();
  static const InputFeatureVisibility never =
      _NeverVisibleInputFeatureVisibility();
  static const InputFeatureVisibility always =
      _AlwaysVisibleInputFeatureVisibility();
  static const InputFeatureVisibility hasSelection =
      _HasSelectionInputFeatureVisibility();
  const InputFeatureVisibility();
  Iterable<Listenable> getDependencies(TextFieldState state);
  bool canShow(TextFieldState state);

  InputFeatureVisibility and(InputFeatureVisibility other) =>
      InputFeatureVisibility.and([this, other]);
  InputFeatureVisibility operator &(InputFeatureVisibility other) => and(other);
  InputFeatureVisibility or(InputFeatureVisibility other) =>
      InputFeatureVisibility.or([this, other]);
  InputFeatureVisibility operator |(InputFeatureVisibility other) => or(other);
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

abstract class InputFeature {
  const factory InputFeature.hint({
    InputFeatureVisibility visibility,
    required WidgetBuilder popupBuilder,
    Widget? icon,
    InputFeaturePosition position,
    bool enableShortcuts,
  }) = InputHintFeature;
  const factory InputFeature.passwordToggle({
    InputFeatureVisibility visibility,
    PasswordPeekMode mode,
    InputFeaturePosition position,
    Widget? icon,
    Widget? iconShow,
  }) = InputPasswordToggleFeature;
  const factory InputFeature.clear({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
  }) = InputClearFeature;
  const factory InputFeature.revalidate({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
  }) = InputRevalidateFeature;
  const factory InputFeature.autoComplete({
    InputFeatureVisibility visibility,
    required SuggestionBuilder querySuggestions,
    required Widget child,
    BoxConstraints? popoverConstraints,
    PopoverConstraint? popoverWidthConstraint,
    AlignmentDirectional? popoverAnchorAlignment,
    AlignmentDirectional? popoverAlignment,
    AutoCompleteMode mode,
  }) = InputAutoCompleteFeature;
  const factory InputFeature.spinner({
    InputFeatureVisibility visibility,
    double step,
    bool enableGesture,
    double? invalidValue,
  }) = InputSpinnerFeature;
  const factory InputFeature.copy({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
  }) = InputCopyFeature;
  const factory InputFeature.paste({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
  }) = InputPasteFeature;
  const factory InputFeature.leading(
    Widget child, {
    InputFeatureVisibility visibility,
  }) = InputLeadingFeature;
  const factory InputFeature.trailing(
    Widget child, {
    InputFeatureVisibility visibility,
  }) = InputTrailingFeature;

  final InputFeatureVisibility visibility;
  const InputFeature({this.visibility = InputFeatureVisibility.always});
  InputFeatureState createState();

  static bool canUpdate(InputFeature oldFeature, InputFeature newFeature) {
    return oldFeature.runtimeType == newFeature.runtimeType;
  }
}

abstract class InputFeatureState<T extends InputFeature> {
  _AttachedInputFeature? _attached;
  TextFieldState? _inputState;
  T get feature {
    assert(
        _attached != null && _attached!.feature is T, 'Feature not attached');
    return _attached!.feature as T;
  }

  TickerProvider get tickerProvider {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!;
  }

  BuildContext get context {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.context;
  }

  TextField get input {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.widget;
  }

  bool get attached => _attached != null;

  TextEditingController get controller {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.effectiveController;
  }

  // used to control whether the feature should be mounted or not
  // with AnimationController, we are able to determine when to
  // not mount the widget
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

  void dispose() {
    _visibilityController.dispose();
    for (var dependency in feature.visibility.getDependencies(_inputState!)) {
      dependency.removeListener(_updateVisibility);
    }
  }

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

  void onTextChanged(String text) {}
  void onSelectionChanged(TextSelection selection) {}
  Iterable<Widget> buildLeading() sync* {}
  Iterable<Widget> buildTrailing() sync* {}
  Iterable<MapEntry<Type, Action<Intent>>> buildActions() sync* {}
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts() sync* {}
  Widget wrap(Widget child) => child;
  TextField interceptInput(TextField input) => input;

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

/// Mixin widget used to avoid human error (e.g. missing properties) when
/// implementing a [TextField], [ChipInput], [TextArea], etc.
mixin TextInput on Widget {
  Object get groupId;
  TextEditingController? get controller;
  FocusNode? get focusNode;
  BoxDecoration? get decoration;
  EdgeInsetsGeometry? get padding;
  Widget? get placeholder;
  Widget? get leading;
  Widget? get trailing;
  CrossAxisAlignment get crossAxisAlignment;
  String? get clearButtonSemanticLabel;
  TextInputType get keyboardType;
  TextInputAction? get textInputAction;
  TextCapitalization get textCapitalization;
  TextStyle? get style;
  StrutStyle? get strutStyle;
  TextAlign get textAlign;
  TextAlignVertical? get textAlignVertical;
  TextDirection? get textDirection;
  bool get readOnly;
  bool? get showCursor;
  bool get autofocus;
  String get obscuringCharacter;
  bool get obscureText;
  bool get autocorrect;
  SmartDashesType get smartDashesType;
  SmartQuotesType get smartQuotesType;
  bool get enableSuggestions;
  int? get maxLines;
  int? get minLines;
  bool get expands;
  int? get maxLength;
  MaxLengthEnforcement? get maxLengthEnforcement;
  ValueChanged<String>? get onChanged;
  VoidCallback? get onEditingComplete;
  ValueChanged<String>? get onSubmitted;
  TapRegionCallback? get onTapOutside;
  TapRegionCallback? get onTapUpOutside;
  List<TextInputFormatter>? get inputFormatters;
  bool get enabled;
  double get cursorWidth;
  double? get cursorHeight;
  Radius get cursorRadius;
  bool get cursorOpacityAnimates;
  Color? get cursorColor;
  ui.BoxHeightStyle get selectionHeightStyle;
  ui.BoxWidthStyle get selectionWidthStyle;
  Brightness? get keyboardAppearance;
  EdgeInsets get scrollPadding;
  bool get enableInteractiveSelection;
  TextSelectionControls? get selectionControls;
  DragStartBehavior get dragStartBehavior;
  ScrollController? get scrollController;
  ScrollPhysics? get scrollPhysics;
  bool get selectionEnabled;
  GestureTapCallback? get onTap;
  Iterable<String>? get autofillHints;
  Clip get clipBehavior;
  String? get restorationId;
  bool get stylusHandwritingEnabled;
  bool get enableIMEPersonalizedLearning;
  ContentInsertionConfiguration? get contentInsertionConfiguration;
  EditableTextContextMenuBuilder? get contextMenuBuilder;
  String? get initialValue;
  String? get hintText;
  bool get border;
  BorderRadiusGeometry? get borderRadius;
  bool get filled;
  WidgetStatesController? get statesController;
  TextMagnifierConfiguration? get magnifierConfiguration;
  SpellCheckConfiguration? get spellCheckConfiguration;
  UndoHistoryController? get undoController;
  List<InputFeature> get features;
  List<TextInputFormatter>? get submitFormatters;
}

class TextField extends StatefulWidget with TextInput {
  const TextField({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.undoController,
    this.decoration,
    this.padding,
    this.placeholder,
    @Deprecated('Use InputFeature.leading instead') this.leading,
    @Deprecated('Use InputFeature.trailing instead') this.trailing,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.clearButtonSemanticLabel,
    TextInputType? keyboardType,
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
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
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
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const [],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.hintText,
    this.border = true,
    this.borderRadius,
    this.filled = false,
    this.statesController,
    this.features = const [],
    this.submitFormatters = const [],
  })  : assert(obscuringCharacter.length == 1),
        smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength > 0),
        // Assert the following instead of setting it directly to avoid surprising the user by silently changing the value they set.
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
        ),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText);

  @override
  final List<InputFeature> features;

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
  final Widget? leading;

  @override
  final Widget? trailing;

  @override
  final CrossAxisAlignment crossAxisAlignment;

  @override
  final String? clearButtonSemanticLabel;

  @override
  final TextInputType keyboardType;

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
  bool get selectionEnabled => enableInteractiveSelection;

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
  final String?
      hintText; // used for autofill hints (use placeholder for decoration)

  @override
  final bool border;

  @override
  final BorderRadiusGeometry? borderRadius;

  @override
  final bool filled;

  @override
  final WidgetStatesController? statesController;

  @override
  final List<TextInputFormatter>? submitFormatters;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return buildEditableTextContextMenu(context, editableTextState);
  }

  @override
  final TextMagnifierConfiguration? magnifierConfiguration;

  @override
  final SpellCheckConfiguration? spellCheckConfiguration;

  @visibleForTesting
  static Widget defaultSpellCheckSuggestionsToolbarBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return CupertinoSpellCheckSuggestionsToolbar.editableText(
        editableTextState: editableTextState);
  }

  @override
  final UndoHistoryController? undoController;

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
      FlagProperty(
        'selectionEnabled',
        value: selectionEnabled,
        defaultValue: true,
        ifFalse: 'selection disabled',
      ),
    );
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

  TextField copyWith({
    Key? key,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    UndoHistoryController? undoController,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    Widget? placeholder,
    Widget? leading,
    Widget? trailing,
    CrossAxisAlignment? crossAxisAlignment,
    String? clearButtonSemanticLabel,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    TextDirection? textDirection,
    bool? readOnly,
    bool? showCursor,
    bool? autofocus,
    String? obscuringCharacter,
    bool? obscureText,
    bool? autocorrect,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool? enableSuggestions,
    int? maxLines,
    int? minLines,
    bool? expands,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    TapRegionCallback? onTapOutside,
    TapRegionCallback? onTapUpOutside,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    ui.BoxHeightStyle? selectionHeightStyle,
    ui.BoxWidthStyle? selectionWidthStyle,
    Brightness? keyboardAppearance,
    EdgeInsets? scrollPadding,
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    GestureTapCallback? onTap,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    Clip? clipBehavior,
    String? restorationId,
    bool? stylusHandwritingEnabled,
    bool? enableIMEPersonalizedLearning,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    String? hintText,
    bool? border,
    BorderRadiusGeometry? borderRadius,
    bool? filled,
    WidgetStatesController? statesController,
    TextMagnifierConfiguration? magnifierConfiguration,
    SpellCheckConfiguration? spellCheckConfiguration,
    List<InputFeature>? features,
    List<TextInputFormatter>? submitFormatters,
  }) {
    return TextField(
      key: key ?? this.key,
      controller: controller ?? this.controller,
      initialValue: initialValue ?? this.initialValue,
      focusNode: focusNode ?? this.focusNode,
      undoController: undoController ?? this.undoController,
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      placeholder: placeholder ?? this.placeholder,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      clearButtonSemanticLabel:
          clearButtonSemanticLabel ?? this.clearButtonSemanticLabel,
      keyboardType: keyboardType ?? this.keyboardType,
      textInputAction: textInputAction ?? this.textInputAction,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      style: style ?? this.style,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textAlignVertical: textAlignVertical ?? this.textAlignVertical,
      textDirection: textDirection ?? this.textDirection,
      readOnly: readOnly ?? this.readOnly,
      showCursor: showCursor ?? this.showCursor,
      autofocus: autofocus ?? this.autofocus,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      obscureText: obscureText ?? this.obscureText,
      autocorrect: autocorrect ?? this.autocorrect,
      smartDashesType: smartDashesType ?? this.smartDashesType,
      smartQuotesType: smartQuotesType ?? this.smartQuotesType,
      enableSuggestions: enableSuggestions ?? this.enableSuggestions,
      maxLines: maxLines ?? this.maxLines,
      minLines: minLines ?? this.minLines,
      expands: expands ?? this.expands,
      maxLength: maxLength ?? this.maxLength,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      onChanged: onChanged ?? this.onChanged,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onTapOutside: onTapOutside ?? this.onTapOutside,
      onTapUpOutside: onTapUpOutside ?? this.onTapUpOutside,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enabled: enabled ?? this.enabled,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionHeightStyle: selectionHeightStyle ?? this.selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle ?? this.selectionWidthStyle,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      enableInteractiveSelection:
          enableInteractiveSelection ?? this.enableInteractiveSelection,
      selectionControls: selectionControls ?? this.selectionControls,
      onTap: onTap ?? this.onTap,
      scrollController: scrollController ?? this.scrollController,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      autofillHints: autofillHints ?? this.autofillHints,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      restorationId: restorationId ?? this.restorationId,
      stylusHandwritingEnabled:
          stylusHandwritingEnabled ?? this.stylusHandwritingEnabled,
      enableIMEPersonalizedLearning:
          enableIMEPersonalizedLearning ?? this.enableIMEPersonalizedLearning,
      contentInsertionConfiguration:
          contentInsertionConfiguration ?? this.contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder ?? this.contextMenuBuilder,
      hintText: hintText ?? this.hintText,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      filled: filled ?? this.filled,
      statesController: statesController ?? this.statesController,
      magnifierConfiguration:
          magnifierConfiguration ?? this.magnifierConfiguration,
      spellCheckConfiguration:
          spellCheckConfiguration ?? this.spellCheckConfiguration,
      features: features ?? this.features,
      submitFormatters: submitFormatters ?? this.submitFormatters,
    );
  }
}

class _AttachedInputFeature {
  InputFeature feature;
  final InputFeatureState state;
  _AttachedInputFeature(this.feature, this.state);
}

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
  bool get selectionEnabled => widget.selectionEnabled;
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
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
    _statesController = widget.statesController ?? WidgetStatesController();
    formValue = widget.controller?.text ?? widget.initialValue ?? '';
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

    if (cause == SelectionChangedCause.scribble) {
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
    }

    for (final attached in _attachedFeatures) {
      attached.state.onSelectionChanged(selection);
    }
  }

  @override
  bool get wantKeepAlive => _controller?.value.text.isNotEmpty ?? false;

  // True if any surrounding decoration widgets will be shown.
  bool get _hasDecoration {
    return widget.placeholder != null ||
        widget.leading != null ||
        widget.trailing != null ||
        widget.features.isNotEmpty;
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

        Widget? leadingWidget = widget.leading;

        Widget? trailingWidget = widget.trailing;

        List<Widget> leadingChildren = [];
        List<Widget> trailingChildren = [];
        if (leadingWidget != null) {
          leadingChildren.add(leadingWidget);
        }
        for (final attached in _attachedFeatures) {
          leadingChildren.addAll(attached.state._internalBuildLeading());
        }
        for (final attached in _attachedFeatures) {
          trailingChildren.addAll(attached.state._internalBuildTrailing());
        }
        if (trailingWidget != null) {
          trailingChildren.add(trailingWidget);
        }

        if (leadingChildren.isNotEmpty) {
          leadingWidget = Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4 * theme.scaling,
            children: leadingChildren,
          );
        } else {
          leadingWidget = null;
        }

        if (trailingChildren.isNotEmpty) {
          trailingWidget = Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4 * theme.scaling,
            children: trailingChildren,
          );
        } else {
          trailingWidget = null;
        }

        return Row(
          crossAxisAlignment: widget.crossAxisAlignment,
          spacing: 8.0 * theme.scaling,
          children: [
            // Insert a prefix at the front if the prefix visibility mode matches
            // the current text state.
            if (leadingWidget != null) leadingWidget,
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
            if (trailingWidget != null) trailingWidget,
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
    formValue = value;
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
          TextFieldClearIntent: CallbackAction(
            onInvoke: (_) {
              effectiveController.clear();
              return;
            },
          ),
          TextFieldAppendTextIntent: CallbackAction<TextFieldAppendTextIntent>(
            onInvoke: (intent) {
              final newText = effectiveController.text + intent.text;
              effectiveController.value = TextEditingValue(
                text: newText,
                selection: TextSelection.collapsed(offset: newText.length),
              );
              return;
            },
          ),
          TextFieldReplaceCurrentWordIntent:
              CallbackAction<TextFieldReplaceCurrentWordIntent>(
            onInvoke: (intent) {
              final replacement = intent.text;
              final value = effectiveController.value;
              final text = value.text;
              final selection = value.selection;
              if (selection.isCollapsed) {
                int start = selection.start;
                final newText = replaceWordAtCaret(text, start, replacement);
                effectiveController.value = TextEditingValue(
                  text: newText.$2,
                  selection: TextSelection.collapsed(
                    offset: newText.$1 + replacement.length,
                  ),
                );
              }
              return;
            },
          ),
          TextFieldSetTextIntent: CallbackAction<TextFieldSetTextIntent>(
            onInvoke: (intent) {
              effectiveController.value = TextEditingValue(
                  text: intent.text,
                  selection:
                      TextSelection.collapsed(offset: intent.text.length));
              return;
            },
          ),
          TextFieldSetSelectionIntent:
              CallbackAction<TextFieldSetSelectionIntent>(
            onInvoke: (intent) {
              effectiveController.selection = intent.selection;
              return;
            },
          ),
          TextFieldSelectAllAndCopyIntent:
              CallbackAction<TextFieldSelectAllAndCopyIntent>(
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
          ...featureActions,
        },
        child: Shortcuts(
          shortcuts: featureShortcuts,
          child: child,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var widget = this.widget;
    super.build(context); // See AutomaticKeepAliveClientMixin.
    final ThemeData theme = Theme.of(context);
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
    final BoxDecoration effectiveDecoration = widget.decoration ??
        BoxDecoration(
          borderRadius:
              optionallyResolveBorderRadius(context, widget.borderRadius) ??
                  BorderRadius.circular(theme.radiusMd),
          color: widget.filled ? theme.colorScheme.muted : null,
          border: widget.border
              ? Border.all(
                  color: _effectiveFocusNode.hasFocus && widget.enabled
                      ? theme.colorScheme.ring
                      : theme.colorScheme.border,
                )
              : null,
        );

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
          selectionControls:
              widget.selectionEnabled ? textSelectionControls : null,
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
          clipBehavior: widget.clipBehavior,
          restorationId: 'editable',
          stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          spellCheckConfiguration: spellCheckConfiguration,
        ),
      ),
    );

    Widget textField = IconTheme.merge(
      data: theme.iconTheme.small.copyWith(
        color: theme.colorScheme.mutedForeground,
      ),
      child: _wrapActions(
        child: MouseRegion(
          onEnter: _onEnter,
          onExit: _onExit,
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
                  decoration: effectiveDecoration,
                  child: _selectionGestureDetectorBuilder.buildGestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Align(
                      alignment: Alignment(-1.0, _textAlignVertical.y),
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Padding(
                        padding: widget.padding ??
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
    );

    for (final attached in _attachedFeatures) {
      textField = attached.state.wrap(textField);
    }
    return WidgetStatesProvider(
      states: {
        if (_effectiveFocusNode.hasFocus) WidgetState.hovered,
      },
      child: textField,
    );
  }

  @override
  void didReplaceFormValue(String value) {
    effectiveController.text = value;
    widget.onChanged?.call(value);
  }
}

class TextFieldAppendTextIntent extends Intent {
  const TextFieldAppendTextIntent({required this.text});

  final String text;
}

class TextFieldClearIntent extends Intent {
  const TextFieldClearIntent();
}

class TextFieldReplaceCurrentWordIntent extends Intent {
  const TextFieldReplaceCurrentWordIntent({required this.text});

  final String text;
}

class TextFieldSetTextIntent extends Intent {
  const TextFieldSetTextIntent({required this.text});

  final String text;
}

class TextFieldSetSelectionIntent extends Intent {
  final TextSelection selection;

  const TextFieldSetSelectionIntent({required this.selection});
}

class TextFieldSelectAllAndCopyIntent extends Intent {
  const TextFieldSelectAllAndCopyIntent();
}
