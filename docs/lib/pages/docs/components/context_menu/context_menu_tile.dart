import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// paint a cursor
class CursorPainter extends CustomPainter {
  // <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  // <path d="M4 0l16 12.279-6.951 1.17 4.325 8.817-3.596 1.734-4.35-8.879-5.428 4.702z"/></svg>
  const CursorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = material.Colors.white
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(4, 0)
      ..lineTo(20, 12.279)
      ..lineTo(13.049, 13.449)
      ..lineTo(17.374, 22.266)
      ..lineTo(13.778, 24)
      ..lineTo(9.428, 15.121)
      ..lineTo(4, 19.823)
      ..close();
    canvas.drawPath(path, paint);
    paint
      ..color = material.Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ContextMenuTile extends StatelessWidget implements IComponentPage {
  const ContextMenuTile({super.key});

  @override
  String get title => 'Context Menu';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Context Menu',
      name: 'context_menu',
      scale: 1.2,
      example: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomPaint(
            painter: CursorPainter(),
          ),
          const Gap(24),
          SizedBox(
            width: 192,
            child: MenuPopup(children: [
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator:
                      SingleActivator(LogicalKeyboardKey.keyX, control: true),
                ),
                child: const Text('Cut'),
              ),
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator:
                      SingleActivator(LogicalKeyboardKey.keyC, control: true),
                ),
                child: const Text('Copy'),
              ),
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator:
                      SingleActivator(LogicalKeyboardKey.keyV, control: true),
                ),
                child: const Text('Paste'),
              ),
              const MenuDivider(),
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator: SingleActivator(LogicalKeyboardKey.delete),
                ),
                child: const Text('Delete'),
              ),
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator:
                      SingleActivator(LogicalKeyboardKey.keyA, control: true),
                ),
                child: const Text('Select All'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
