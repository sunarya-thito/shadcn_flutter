import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class _InputOTPSpacing extends StatelessWidget {
  const _InputOTPSpacing();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(width: theme.scaling * 8);
  }
}

abstract class InputOTPChild {
  static InputOTPChild get separator =>
      const WidgetInputOTPChild(OTPSeparator());
  static InputOTPChild get space =>
      const WidgetInputOTPChild(_InputOTPSpacing());
  static InputOTPChild get empty => const WidgetInputOTPChild(SizedBox());
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
  const InputOTPChild();
  Widget build(BuildContext context, InputOTPChildData data);
  bool get hasValue;
}

typedef CodepointPredicate = bool Function(int codepoint);
typedef CodepointUnaryOperator = int Function(int codepoint);

class CharacterInputOTPChild extends InputOTPChild {
  static const int _startAlphabetLower = 97; // 'a'
  static const int _endAlphabetLower = 122; // 'z'
  static const int _startAlphabetUpper = 65; // 'A'
  static const int _endAlphabetUpper = 90; // 'Z'
  static const int _startDigit = 48; // '0'
  static const int _endDigit = 57; // '9'

  static bool isAlphabetLower(int codepoint) =>
      codepoint >= _startAlphabetLower && codepoint <= _endAlphabetLower;
  static bool isAlphabetUpper(int codepoint) =>
      codepoint >= _startAlphabetUpper && codepoint <= _endAlphabetUpper;
  static int lowerToUpper(int codepoint) =>
      isAlphabetLower(codepoint) ? codepoint - 32 : codepoint;
  static int upperToLower(int codepoint) =>
      isAlphabetUpper(codepoint) ? codepoint + 32 : codepoint;
  static bool isDigit(int codepoint) =>
      codepoint >= _startDigit && codepoint <= _endDigit;

  final CodepointPredicate? predicate;
  final CodepointUnaryOperator? transform;
  final bool obscured;
  final bool readOnly;
  final TextInputType? keyboardType;

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
              child: AnimatedBuilder(
                animation: widget.data.focusNode!,
                builder: (context, child) {
                  if (widget.data.focusNode!.hasFocus) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: theme.colorScheme.ring,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        borderRadius: getBorderRadiusByRelativeIndex(
                          theme,
                          widget.data.relativeIndex,
                          widget.data.groupLength,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: theme.colorScheme.border,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        borderRadius: getBorderRadiusByRelativeIndex(
                          theme,
                          widget.data.relativeIndex,
                          widget.data.groupLength,
                        ),
                      ),
                    );
                  }
                },
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
              child: Center(
                child: Opacity(
                  opacity: _value == null ? 1 : 0,
                  child: TextField(
                    border: false,
                    useNativeContextMenu: widget.data.useNativeContextMenu,
                    isCollapsed: true,
                    expands: false,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
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

class WidgetInputOTPChild extends InputOTPChild {
  final Widget child;

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

class OTPSeparator extends StatelessWidget {
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

class InputOTPChildData {
  final FocusNode? previousFocusNode;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int index;
  final int groupIndex;
  final int groupLength;
  final int relativeIndex;
  final int? value;
  final _InputOTPState _state;
  final bool useNativeContextMenu;
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
    this.useNativeContextMenu = false,
  });

  void changeValue(int? value) {
    _state._changeValue(index, value);
  }
}

class _InputOTPChild {
  int? value;
  final FocusNode focusNode;
  final InputOTPChild child;
  final int groupIndex;
  final int relativeIndex;
  int groupLength = 0;
  final GlobalKey<_OTPCharacterInputState> key = GlobalKey();

  _InputOTPChild({
    required this.focusNode,
    required this.child,
    this.value,
    required this.groupIndex,
    required this.relativeIndex,
  });
}

typedef OTPCodepointList = List<int?>;

extension OTPCodepointListExtension on OTPCodepointList {
  String otpToString() {
    return map((e) => e == null ? '' : String.fromCharCode(e)).join();
  }
}

class InputOTP extends StatefulWidget {
  final List<InputOTPChild> children;
  final OTPCodepointList? initialValue;
  final ValueChanged<OTPCodepointList>? onChanged;
  final ValueChanged<OTPCodepointList>? onSubmitted;
  final bool useNativeContextMenu;

  const InputOTP({
    super.key,
    required this.children,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.useNativeContextMenu = false,
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
    if (widget.onChanged != null) {
      _children[index].value = value;
      var val = this.value;
      widget.onChanged!(val);
      if (val.every((e) => e != null)) {
        widget.onSubmitted?.call(val);
      }
    }
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
              useNativeContextMenu: widget.useNativeContextMenu,
            )));
      }
    }
    return SizedBox(
      height: theme.scaling * 36,
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
