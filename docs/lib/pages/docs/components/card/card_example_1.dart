import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardExample1 extends StatelessWidget {
  const CardExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create project').semiBold(),
          const SizedBox(height: 4),
          const Text('Deploy your new project in one-click').muted().small(),
          const SizedBox(height: 24),
          const Text('Name').semiBold().small(),
          const SizedBox(height: 4),
          const TextField(placeholder: 'Name of your project'),
          const SizedBox(height: 16),
          const Text('Description').semiBold().small(),
          const SizedBox(height: 4),
          const TextField(placeholder: 'Description of your project'),
          const SizedBox(height: 24),
          Row(
            children: [
              OutlineButton(
                child: const Text('Cancel'),
                onPressed: () {},
              ),
              const Spacer(),
              PrimaryButton(
                child: const Text('Deploy'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ).intrinsic();
  }
}
