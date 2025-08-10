import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ToastTile extends StatelessWidget implements IComponentPage {
  const ToastTile({super.key});

  @override
  String get title => 'Toast';

  Widget _buildToast() {
    return Card(
      child: Basic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: PrimaryButton(
            size: ButtonSize.small,
            onPressed: () {},
            child: const Text('Undo')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Toast',
      name: 'toast',
      scale: 1.3,
      reverseVertical: true,
      example: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -24),
            child: Transform.scale(
              scale: 0.9 * 0.9,
              child: Opacity(
                opacity: 0.5,
                child: _buildToast(),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -12),
            child: Transform.scale(
              scale: 0.9,
              child: Opacity(
                opacity: 0.75,
                child: _buildToast(),
              ),
            ),
          ),
          _buildToast(),
        ],
      ),
    );
  }
}
