import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          trailing: ChipButton(
            onPressed: () {},
            child: Icon(Icons.close),
          ),
          child: Text('Apple'),
        ),
        Chip(
          style: const ButtonStyle.primary(),
          trailing: ChipButton(
            onPressed: () {},
            child: Icon(Icons.close),
          ),
          child: Text('Banana'),
        ),
        Chip(
          style: const ButtonStyle.outline(),
          trailing: ChipButton(
            onPressed: () {},
            child: Icon(Icons.close),
          ),
          child: Text('Cherry'),
        ),
        Chip(
          style: const ButtonStyle.ghost(),
          trailing: ChipButton(
            onPressed: () {},
            child: Icon(Icons.close),
          ),
          child: Text('Durian'),
        ),
        Chip(
          style: const ButtonStyle.destructive(),
          trailing: ChipButton(
            onPressed: () {},
            child: Icon(Icons.close),
          ),
          child: Text('Elderberry'),
        ),
      ],
    );
  }
}
