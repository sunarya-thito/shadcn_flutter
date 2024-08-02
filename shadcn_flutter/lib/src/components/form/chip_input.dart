import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

TextRange _range(int start, int end) {
  if (start <= -1 && end <= -1) {
    return TextRange.empty;
  }
  start = start.max(0);
  end = end.max(0);
  return TextRange(start: start, end: end);
}

class ChipInput extends StatefulWidget {
  final TextEditingController? controller;
  final BoxConstraints popoverConstraints;
  final UndoHistoryController? undoHistoryController;
  final ValueChanged<String>? onSubmitted;
  final String? initialText;
  final FocusNode? focusNode;
  final List<Widget> suggestions;
  final List<Widget> chips;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(int index)? onSuggestionChoosen;
  const ChipInput({
    Key? key,
    this.controller,
    this.popoverConstraints = const BoxConstraints(
      maxHeight: 300,
    ),
    this.undoHistoryController,
    this.initialText,
    this.onSubmitted,
    this.focusNode,
    this.suggestions = const [],
    this.chips = const [],
    this.inputFormatters,
    this.onSuggestionChoosen,
  }) : super(key: key);

  @override
  State<ChipInput> createState() => ChipInputState();
}

class ChipInputState extends State<ChipInput> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  late ValueNotifier<List<Widget>> _suggestions;
  final ValueNotifier<int> _selectedSuggestions = ValueNotifier(-1);
  final PopoverController _popoverController = PopoverController();

  bool _isChangingText = false;

  @override
  void initState() {
    super.initState();
    _suggestions = ValueNotifier(widget.suggestions);
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _suggestions.addListener(_onSuggestionsChanged);
    _focusNode.addListener(_onSuggestionsChanged);
  }

  void _onSuggestionsChanged() {
    if ((_suggestions.value.isEmpty || !_focusNode.hasFocus) &&
        _popoverController.hasOpenPopover) {
      _popoverController.close();
    } else if (!_popoverController.hasOpenPopover &&
        _suggestions.value.isNotEmpty) {
      _popoverController.show(
        context: context,
        builder: (context) {
          return buildPopover(context);
        },
        alignment: Alignment.topCenter,
        widthConstraint: PopoverConstraint.anchorFixedSize,
        dismissBackdropFocus: false,
        showDuration: Duration.zero,
        hideDuration: Duration.zero,
        offset: const Offset(0, 4),
      );
    }
  }

  Widget _chipBuilder(int index) {
    return widget.chips[index];
  }

  @override
  void didUpdateWidget(covariant ChipInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {}
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (!listEquals(widget.suggestions, oldWidget.suggestions)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _suggestions.value = widget.suggestions;
      });
    }
  }

  Widget buildPopover(BuildContext context) {
    return TextFieldTapRegion(
      child: Data(
        data: this,
        child: ConstrainedBox(
          constraints: widget.popoverConstraints,
          child: OutlinedContainer(
            child: AnimatedBuilder(
                animation:
                    Listenable.merge([_suggestions, _selectedSuggestions]),
                builder: (context, child) {
                  return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      children: [
                        for (int i = 0; i < _suggestions.value.length; i++)
                          Toggle(
                            value: i == _selectedSuggestions.value,
                            onChanged: (value) {
                              if (value) {
                                widget.onSuggestionChoosen?.call(i);
                              }
                            },
                            child: _suggestions.value[i],
                          ),
                      ]);
                }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  final GlobalKey _textFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.text,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.tab): const SelectSuggestionIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown):
              const NextSuggestionIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp):
              const PreviousSuggestionIntent(),
        },
        actions: {
          SelectSuggestionIntent: CallbackAction(
            onInvoke: (intent) {
              var index = _selectedSuggestions.value;
              if (index >= 0 && index < _suggestions.value.length) {
                widget.onSuggestionChoosen?.call(index);
              } else if (_suggestions.value.isNotEmpty) {
                _selectedSuggestions.value = 0;
              }
              return null;
            },
          ),
          NextSuggestionIntent: CallbackAction(
            onInvoke: (intent) {
              var index = _selectedSuggestions.value;
              if (index < _suggestions.value.length - 1) {
                _selectedSuggestions.value = index + 1;
              } else if (_suggestions.value.isNotEmpty) {
                _selectedSuggestions.value = 0;
              }
              return null;
            },
          ),
          PreviousSuggestionIntent: CallbackAction(
            onInvoke: (intent) {
              var index = _selectedSuggestions.value;
              if (index > 0) {
                _selectedSuggestions.value = index - 1;
              } else if (_suggestions.value.isNotEmpty) {
                _selectedSuggestions.value = _suggestions.value.length - 1;
              }
              return null;
            },
          ),
        },
        child: AnimatedBuilder(
          animation: _focusNode,
          builder: (context, child) {
            if (widget.chips.isNotEmpty) {
              if (_focusNode.hasFocus) {
                child = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    child!,
                    Wrap(
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        for (int i = 0; i < widget.chips.length; i++)
                          _chipBuilder(i),
                      ],
                    ).withPadding(
                      left: 4,
                      right: 4,
                      bottom: 4,
                    ),
                  ],
                );
              } else {
                child = Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Visibility(
                      visible: false,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainInteractivity: true,
                      maintainSize: true,
                      maintainSemantics: true,
                      child: child!,
                    ),
                    Wrap(
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        for (int i = 0; i < widget.chips.length; i++)
                          _chipBuilder(i),
                      ],
                    ).withPadding(all: 4),
                  ],
                );
              }
            }
            return TextFieldTapRegion(
              child: OutlinedContainer(
                borderRadius: theme.radiusMd,
                borderColor: _focusNode.hasFocus
                    ? theme.colorScheme.ring
                    : theme.colorScheme.border,
                child: child!,
              ),
            );
          },
          child: TextField(
            key: _textFieldKey,
            focusNode: _focusNode,
            initialValue: widget.initialText,
            inputFormatters: widget.inputFormatters,
            border: false,
            onSubmitted: (text) {
              _focusNode.requestFocus();
              if (text.isNotEmpty) {
                widget.onSubmitted?.call(text);
              }
            },
            controller: _controller,
            undoController: widget.undoHistoryController,
          ),
        ),
      ),
    );
  }
}

class SelectSuggestionIntent extends Intent {
  const SelectSuggestionIntent();
}

class NextSuggestionIntent extends Intent {
  const NextSuggestionIntent();
}

class PreviousSuggestionIntent extends Intent {
  const PreviousSuggestionIntent();
}
