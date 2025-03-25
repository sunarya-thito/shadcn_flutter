import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerExample2 extends StatelessWidget {
  const ItemPickerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showItemPickerDialog<int>(
          context,
          title: const Text('Pick a number'),
          items: ItemBuilder(
            itemBuilder: (index) {
              return index;
            },
          ),
          builder: (context, item) {
            return ItemPickerOption(
                value: item, child: Text(item.toString()).large);
          },
        ).then(
          (value) {
            if (value != null) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return SurfaceCard(
                    child: Text('You picked $value!'),
                  );
                },
              );
            } else {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}
