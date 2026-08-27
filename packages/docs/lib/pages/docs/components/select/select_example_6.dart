import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates creating an option inline, without leaving the select.
//
// The popup's own search field doubles as the input: whatever the user typed
// and did not find becomes the name of the new item, so there is no dialog and
// no navigation. Two pieces make it work:
//
//  - SelectPopup.builder(shrinkWrap: true) sizes the popup to its content, so
//    the create row sits directly under the last match instead of at the
//    bottom of a fixed-height list.
//  - SelectPopupHandle.close() lets that row dismiss the popup on its own
//    terms. It is not an item, so nothing would otherwise close the popup for
//    it — autoClose only fires as a side effect of a selection.
//
// The row is an ordinary widget in the list, so the caller decides whether to
// include it at all — which is what permission-gated creation needs.

class SelectExample6 extends StatefulWidget {
  const SelectExample6({super.key});

  @override
  State<SelectExample6> createState() => _SelectExample6State();
}

class _SelectExample6State extends State<SelectExample6> {
  final List<String> _fruits = ['Apple', 'Banana', 'Cherry'];
  String? _selected;

  // Flip to false to drop the create row without touching anything else.
  final bool _canCreate = true;

  void _create(String name) {
    setState(() {
      _fruits.add(name);
      // Selected straight away: creating it inline is only worth doing if the
      // user does not then have to find it in the list.
      _selected = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) => Text(item),
      value: _selected,
      placeholder: const Text('Select a fruit'),
      // Fixed width, so the trigger does not resize around whichever value is
      // selected or newly created.
      constraints: const BoxConstraints.tightFor(width: 260),
      onChanged: (value) => setState(() => _selected = value),
      popupConstraints: const BoxConstraints(maxHeight: 300, maxWidth: 260),
      popup: SelectPopup<String>.builder(
        searchPlaceholder: const Text('Search or type a new fruit'),
        // Without this the list claims the full constrained height and the
        // create row floats below empty space.
        shrinkWrap: true,
        builder: (context, searchQuery) {
          final query = searchQuery?.trim() ?? '';
          final matches = _fruits
              .where(
                (fruit) =>
                    query.isEmpty ||
                    fruit.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
          // Nothing to create from an empty box, and no point offering to
          // create something that already exists.
          final canCreate =
              _canCreate &&
              query.isNotEmpty &&
              !_fruits.any(
                (fruit) => fruit.toLowerCase() == query.toLowerCase(),
              );
          return SelectItemList(
            children: [
              for (final fruit in matches)
                SelectItemButton(value: fruit, child: Text(fruit)),
              if (matches.isEmpty && !canCreate)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: const Text('No fruits found').muted().small(),
                ),
              if (canCreate) ...[
                if (matches.isNotEmpty) const Divider(),
                Builder(
                  builder: (context) {
                    // Resolved here so the handle belongs to the popup that is
                    // actually on screen.
                    final handle = SelectPopupHandle.of(context);
                    return GhostButton(
                      leading: const Icon(LucideIcons.plus),
                      alignment: AlignmentDirectional.centerStart,
                      onPressed: () {
                        _create(query);
                        handle.close();
                      },
                      child: Text('Create "$query"'),
                    );
                  },
                ),
              ],
            ],
          );
        },
      ).call,
    );
  }
}
