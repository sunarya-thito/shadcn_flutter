import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef ChipWidgetBuilder<T> = Widget Function(BuildContext context, T chip);

class ChipInputController<T> extends ValueNotifier<List<T>>
    with ComponentController<List<T>> {
  ChipInputController([super.value = const []]);
}

class ControlledChipInput<T> extends StatelessWidget
    with ControlledComponent<List<T>> {
  @override
  final List<T> initialValue;
  @override
  final ValueChanged<List<T>>? onChanged;
  @override
  final ChipInputController<T>? controller;
  @override
  final bool enabled;
  final TextEditingController? textEditingController;
  final BoxConstraints popoverConstraints;
  final UndoHistoryController? undoHistoryController;
  final ValueChanged<String>? onSubmitted;
  final String? initialText;
  final FocusNode? focusNode;
  final List<T> suggestions;
  final List<T> chips;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(int index)? onSuggestionChoosen;
  final ChipWidgetBuilder<T> chipBuilder;
  final ChipWidgetBuilder<T>? suggestionBuilder;
  final bool useChips;
  final TextInputAction? textInputAction;
  final Widget? placeholder;
  final Widget Function(BuildContext, T)? suggestionLeadingBuilder;
  final Widget Function(BuildContext, T)? suggestionTrailingBuilder;
  final Widget? inputTrailingWidget;

  const ControlledChipInput({
    super.key,
    this.controller,
    this.initialValue = const [],
    this.onChanged,
    this.enabled = true,
    this.textEditingController,
    this.popoverConstraints = const BoxConstraints(
      maxHeight: 300,
    ),
    this.undoHistoryController,
    this.onSubmitted,
    this.initialText,
    this.focusNode,
    this.suggestions = const [],
    this.chips = const [],
    this.inputFormatters,
    this.onSuggestionChoosen,
    required this.chipBuilder,
    this.suggestionBuilder,
    this.useChips = true,
    this.textInputAction,
    this.placeholder,
    this.suggestionLeadingBuilder,
    this.suggestionTrailingBuilder,
    this.inputTrailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return ChipInput(
          controller: textEditingController,
          popoverConstraints: popoverConstraints,
          undoHistoryController: undoHistoryController,
          onSubmitted: onSubmitted,
          initialText: initialText,
          focusNode: focusNode,
          suggestions: suggestions,
          chips: data.value,
          inputFormatters: inputFormatters,
          onSuggestionChoosen: onSuggestionChoosen,
          onChanged: data.onChanged,
          useChips: useChips,
          chipBuilder: chipBuilder,
          suggestionBuilder: suggestionBuilder,
          textInputAction: textInputAction,
          placeholder: placeholder,
          suggestionLeadingBuilder: suggestionLeadingBuilder,
          suggestionTrailingBuilder: suggestionTrailingBuilder,
          inputTrailingWidget: inputTrailingWidget,
          enabled: data.enabled,
        );
      },
    );
  }
}

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
  final Widget? placeholder;
  final Widget Function(BuildContext, T)? suggestionLeadingBuilder;
  final Widget Function(BuildContext, T)? suggestionTrailingBuilder;
  final Widget? inputTrailingWidget;
  final bool enabled;

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
    this.placeholder,
    this.suggestionLeadingBuilder,
    this.suggestionTrailingBuilder,
    this.inputTrailingWidget,
    required this.chipBuilder,
    this.enabled = true,
  });

  @override
  State<ChipInput<T>> createState() => ChipInputState();
}

class ChipInputState<T> extends State<ChipInput<T>>
    with FormValueSupplier<List<T>, ChipInput<T>> {
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
    formValue = widget.chips;
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
        handler: const PopoverOverlayHandler(),
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
        child: const Icon(LucideIcons.x),
      ),
      child: widget.chipBuilder(context, widget.chips[index]),
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
      formValue = widget.chips;
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
              animation: Listenable.merge([_suggestions, _selectedSuggestions]),
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
                            _controller.clear();
                            _selectedSuggestions.value = -1;
                            _popoverController.close();
                          }
                        },
                        child: Row(
                          children: [
                            if (widget.suggestionLeadingBuilder != null) ...[
                              widget.suggestionLeadingBuilder!(
                                  context, _suggestions.value[i]),
                              SizedBox(
                                  width:
                                      theme.scaling * 10), // Add spacing here
                            ],
                            Expanded(
                              child: widget.suggestionBuilder
                                      ?.call(context, _suggestions.value[i]) ??
                                  Text(_suggestions.value[i].toString())
                                      .normal()
                                      .small(),
                            ),
                            if (widget.suggestionTrailingBuilder != null) ...[
                              SizedBox(
                                  width:
                                      theme.scaling * 10), // Add spacing here
                              widget.suggestionTrailingBuilder!
                                      (context, _suggestions.value[i])
                                  .normal()
                                  .small(),
                            ],
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
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

  void _handleSubmitted(String text) {
    if (_selectedSuggestions.value >= 0 &&
        _selectedSuggestions.value < _suggestions.value.length) {
      // A suggestion is selected, use it
      widget.onSuggestionChoosen?.call(_selectedSuggestions.value);
    } else if (text.isNotEmpty) {
      // No suggestion selected, use the entered text
      widget.onSubmitted?.call(text);
    }
    _focusNode.requestFocus();
    _controller.clear();
    _selectedSuggestions.value = -1;
  }

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
                _controller.clear();
                _selectedSuggestions.value = -1;
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
                      left: theme.scaling * 6,
                      right: theme.scaling * 6,
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
                    ).withPadding(
                        horizontal: theme.scaling * 6,
                        vertical: theme.scaling * 4),
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
                child: Row(
                  children: [
                    Expanded(child: child!),
                    if (widget.inputTrailingWidget != null) ...[
                      const VerticalDivider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      widget.inputTrailingWidget!,
                    ]
                  ],
                ),
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
            enabled: widget.enabled,
            maxLines: 1,
            placeholder: widget.placeholder,
            onSubmitted: _handleSubmitted,
            controller: _controller,
            undoController: widget.undoHistoryController,
          ),
        ),
      ),
    );
  }

  @override
  void didReplaceFormValue(List<T> value) {
    widget.onChanged?.call(value);
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

// class _ChipSuggestionItem extends StatefulWidget {
//   final Widget suggestion;
//   final Widget? leading;
//   final Widget? trailing;
//   final bool selected;
//   final VoidCallback onSelected;
//
//   const _ChipSuggestionItem({
//     required this.suggestion,
//     this.leading,
//     this.trailing,
//     required this.selected,
//     required this.onSelected,
//   });
//
//   @override
//   State<_ChipSuggestionItem> createState() => _ChipSuggestionItemState();
// }
//
// class _ChipSuggestionItemState extends State<_ChipSuggestionItem> {
//   @override
//   void didUpdateWidget(covariant _ChipSuggestionItem oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selected != widget.selected) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         if (!mounted) {
//           return;
//         }
//         if (widget.selected) {
//           Scrollable.ensureVisible(context);
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SelectedButton(
//       value: widget.selected,
//       onChanged: (value) {
//         if (value) {
//           widget.onSelected();
//         }
//       },
//       child: Row(
//         children: [
//           if (widget.leading != null) widget.leading!,
//           Expanded(child: widget.suggestion),
//           if (widget.trailing != null) widget.trailing!,
//         ],
//       ),
//     );
//   }
// }
