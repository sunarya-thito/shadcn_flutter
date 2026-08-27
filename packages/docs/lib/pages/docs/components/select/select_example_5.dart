import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates Select.decoration: a WidgetStatePropertyDelegate<Decoration>
// that overrides the trigger's appearance per state. One delegate covers the
// idle border, the focused border, the background and the hover color, so
// restyling a Select no longer means wrapping it in a Theme scope that would
// also restyle everything else nested inside.
//
// The same delegate can be set on SelectTheme to apply it to every Select in
// a subtree.

class SelectExample5 extends StatefulWidget {
  const SelectExample5({super.key});

  @override
  State<SelectExample5> createState() => _SelectExample5State();
}

class _SelectExample5State extends State<SelectExample5> {
  String? perInstance;
  String? fromTheme;

  static const _popup = SelectPopup<String>(
    items: SelectItemList(
      children: [
        SelectItemButton(value: 'Apple', child: Text('Apple')),
        SelectItemButton(value: 'Banana', child: Text('Banana')),
        SelectItemButton(value: 'Cherry', child: Text('Cherry')),
      ],
    ),
  );

  // Receives the decoration the Select resolved on its own, so it can adjust
  // one facet and leave the rest alone.
  Decoration _decorate(
    BuildContext context,
    Set<WidgetState> states,
    Decoration value,
  ) {
    final theme = Theme.of(context);
    final Color border;
    if (states.focused) {
      border = theme.colorScheme.primary;
    } else if (states.hovered) {
      border = theme.colorScheme.primary.scaleAlpha(0.5);
    } else {
      border = theme.colorScheme.border;
    }
    // Blended into the card colour rather than laid over it as a translucent
    // fill, so the trigger stays opaque and only its tint changes on hover.
    return (value as BoxDecoration).copyWith(
      color: states.hovered
          ? Color.alphaBlend(
              theme.colorScheme.primary.scaleAlpha(0.08),
              theme.colorScheme.card,
            )
          : theme.colorScheme.card,
      border: Border.all(color: border, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            const Text('Per instance').muted().small(),
            Select<String>(
              itemBuilder: (context, item) => Text(item),
              value: perInstance,
              placeholder: const Text('Select a fruit'),
              // Fixed width, so the trigger does not resize around whichever
              // value is selected.
              constraints: const BoxConstraints.tightFor(width: 200),
              onChanged: (value) => setState(() => perInstance = value),
              decoration: _decorate,
              popup: _popup.call,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            const Text('From SelectTheme').muted().small(),
            // Scoped to Select only — sibling widgets keep the app theme.
            ComponentTheme(
              data: SelectTheme(decoration: _decorate),
              child: Select<String>(
                itemBuilder: (context, item) => Text(item),
                value: fromTheme,
                placeholder: const Text('Select a fruit'),
                constraints: const BoxConstraints.tightFor(width: 200),
                onChanged: (value) => setState(() => fromTheme = value),
                popup: _popup.call,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
