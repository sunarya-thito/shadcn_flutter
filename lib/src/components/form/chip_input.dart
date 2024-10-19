import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef ChipWidgetBuilder<T> = Widget Function(BuildContext context, T chip);

class ChipInput<T> extends StatefulWidget {
  final TextEditingController? controller;
  final BoxConstraints popoverConstraints;
  final UndoHistoryController? undoHistoryController;
  final ValueChanged<String>? onSubmitted;
  final String? initialText;
  final FocusNode? focusNode;
  final List<T> suggestions;
  final List<T> chips;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(int index)? onSuggestionChoosen;
  final ValueChanged<List<T>>? onChanged;
  final ChipWidgetBuilder<T> chipBuilder;
  final ChipWidgetBuilder<T>? suggestionBuilder;
  final bool useChips;
  final TextInputAction? textInputAction;
  const ChipInput({
    super.key,
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
    this.onChanged,
    this.useChips = true,
    this.suggestionBuilder,
    this.textInputAction,
    required this.chipBuilder,
  });

  @override
  State<ChipInput<T>> createState() => ChipInputState();
}

class ChipInputState<T> extends State<ChipInput<T>> with FormValueSupplier {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  late ValueNotifier<List<T>> _suggestions;
  final ValueNotifier<int> _selectedSuggestions = ValueNotifier(-1);
  final PopoverController _popoverController = PopoverController();

  @override
  void initState() {
    super.initState();
    _suggestions = ValueNotifier([]);
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _suggestions.addListener(_onSuggestionsChanged);
    _focusNode.addListener(_onFocusChanged);
    if (widget.suggestions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
      });
    }
  }

  void _onFocusChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _onSuggestionsChanged();
    });
  }

  void _onSuggestionsChanged() {
    if (_suggestions.value.isEmpty || !_focusNode.hasFocus) {
      _popoverController.close();
    } else if (!_popoverController.hasOpenPopover &&
        _suggestions.value.isNotEmpty) {
      final theme = Theme.of(context);
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
        offset: Offset(0, theme.scaling * 4),
      );
    }
  }

  Widget _chipBuilder(int index) {
    if (!widget.useChips) {
      return widget.chipBuilder(context, widget.chips[index]);
    }
    return Chip(
      trailing: ChipButton(
        onPressed: () {
          List<T> chips = List.of(widget.chips);
          chips.removeAt(index);
          widget.onChanged?.call(chips);
        },
        child: const Icon(Icons.close),
      ),
      child: widget.chipBuilder(context, widget.chips[index]),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      widget.chips,
      (value) {
        widget.onChanged?.call(value);
      },
    );
  }

  @override
  void didUpdateWidget(covariant ChipInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {}
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }
    if (!listEquals(widget.suggestions, _suggestions.value)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _suggestions.value = widget.suggestions;
      });
    }
    if (!listEquals(widget.chips, oldWidget.chips)) {
      reportNewFormValue(
        widget.chips,
        (value) {
          widget.onChanged?.call(value);
        },
      );
    }
  }

  Widget buildPopover(BuildContext context) {
    final theme = Theme.of(context);
    return TextFieldTapRegion(
      child: Data.inherit(
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
                      padding: EdgeInsets.all(theme.scaling * 4),
                      children: [
                        for (int i = 0; i < _suggestions.value.length; i++)
                          SelectedButton(
                            style: const ButtonStyle.ghost(),
                            selectedStyle: const ButtonStyle.secondary(),
                            value: i == _selectedSuggestions.value,
                            onChanged: (value) {
                              if (value) {
                                widget.onSuggestionChoosen?.call(i);
                              }
                            },
                            child: widget.suggestionBuilder
                                    ?.call(context, _suggestions.value[i]) ??
                                Text(_suggestions.value[i].toString()),
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
                      runSpacing: theme.scaling * 4,
                      spacing: theme.scaling * 4,
                      children: [
                        for (int i = 0; i < widget.chips.length; i++)
                          _chipBuilder(i),
                      ],
                    ).withPadding(
                      left: theme.scaling * 4,
                      right: theme.scaling * 4,
                      bottom: theme.scaling * 4,
                    ),
                  ],
                );
              } else {
                child = Stack(
                  alignment: AlignmentDirectional.centerStart,
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
                      runSpacing: theme.scaling * 4,
                      spacing: theme.scaling * 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (int i = 0; i < widget.chips.length; i++)
                          _chipBuilder(i),
                        if (_controller.text.isNotEmpty) const Gap(4),
                        if (_controller.text.isNotEmpty)
                          Text(
                            _controller.text,
                          ).base(),
                      ],
                    ).withPadding(all: theme.scaling * 4),
                  ],
                );
              }
            }
            return TextFieldTapRegion(
              child: OutlinedContainer(
                backgroundColor: Colors.transparent,
                borderRadius: theme.borderRadiusMd,
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
            textInputAction: widget.textInputAction,
            border: false,
            maxLines: 1,
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

/*
 SelectedButton(
                            style: ButtonStyle.ghost(),
                            selectedStyle: ButtonStyle.secondary(),
                            value: i == _selectedSuggestions.value,
                            onChanged: (value) {
                              if (value) {
                                widget.onSuggestionChoosen?.call(i);
                              }
                            },
                            child: widget.suggestionBuilder
                                    ?.call(context, _suggestions.value[i]) ??
                                Text(_suggestions.value[i].toString()),
                          )
 */

class _ChipSuggestionItem extends StatefulWidget {
  final Widget suggestion;
  final bool selected;
  final VoidCallback onSelected;

  const _ChipSuggestionItem({
    required this.suggestion,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<_ChipSuggestionItem> createState() => _ChipSuggestionItemState();
}

class _ChipSuggestionItemState extends State<_ChipSuggestionItem> {
  @override
  void didUpdateWidget(covariant _ChipSuggestionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) {
          return;
        }
        if (widget.selected) {
          Scrollable.ensureVisible(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectedButton(
      value: widget.selected,
      onChanged: (value) {
        if (value) {
          widget.onSelected();
        }
      },
      child: widget.suggestion,
    );
  }
}
