import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample5 extends StatefulWidget {
  const ItemPickerExample5({super.key});

  @override
  State<ItemPickerExample5> createState() => _ItemPickerExample5State();
}

class _ItemPickerExample5State extends State<ItemPickerExample5> {
  final List<NamedColor> colors = const [
    NamedColor('Red', Colors.red),
    NamedColor('Green', Colors.green),
    NamedColor('Blue', Colors.blue),
    NamedColor('Yellow', Colors.yellow),
    NamedColor('Purple', Colors.purple),
    NamedColor('Cyan', Colors.cyan),
    NamedColor('Orange', Colors.orange),
    NamedColor('Pink', Colors.pink),
    NamedColor('Teal', Colors.teal),
    NamedColor('Amber', Colors.amber),
  ];
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return ItemPicker<NamedColor>(
      items: ItemList(colors),
      mode: PromptMode.popover,
      title: const Text('Pick a color'),
      builder: (context, item) {
        return ItemPickerOption(
          value: item,
          label: Text(item.name),
          style: const ButtonStyle.ghostIcon(
            shape: ButtonShape.circle,
          ),
          selectedStyle: const ButtonStyle.primary(
            shape: ButtonShape.circle,
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      value: colors[selectedColor],
      placeholder: const Text('Pick a color'),
      onChanged: (value) {
        if (kDebugMode) {
          print('You picked $value!');
        }
        if (value != null) {
          setState(() {
            selectedColor = colors.indexOf(value);
          });
        }
      },
    );
  }
}
