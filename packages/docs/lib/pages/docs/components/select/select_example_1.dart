import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample1 extends StatefulWidget {
  const SelectExample1({super.key});

  @override
  State<SelectExample1> createState() => _SelectExample1State();
}

class _SelectExample1State extends State<SelectExample1> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select<String>(
      // How to render each selected item as text in the field.
      itemBuilder: (context, item) {
        return Text(item);
      },
      // Limit the popup size so it doesn't grow too large in the docs view.
      popupConstraints: const BoxConstraints(
        maxHeight: 300,
        maxWidth: 200,
      ),
      onChanged: (value) {
        setState(() {
          // Save the currently selected value (or null to clear).
          selectedValue = value;
        });
      },
      // The current selection bound to this field.
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
      popup: const SelectPopup(
        items: SelectItemList(
          children: [
            // A simple static list of options.
            SelectItemButton(
              value: 'Apple',
              child: Text('Apple'),
            ),
            SelectItemButton(
              value: 'Banana',
              child: Text('Banana'),
            ),
            SelectItemButton(
              value: 'Cherry',
              child: Text('Cherry'),
            ),
          ],
        ),
      ),
    );
  }
}
