import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material hide Card;
import 'package:shadcn_flutter/shadcn_flutter.dart';

// paint a cursor
class CursorPainter extends CustomPainter {
  // <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  // <path d="M4 0l16 12.279-6.951 1.17 4.325 8.817-3.596 1.734-4.35-8.879-5.428 4.702z"/></svg>
  const CursorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
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
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TooltipTile extends StatelessWidget implements IComponentPage {
  const TooltipTile({super.key});

  @override
  String get title => 'Tooltip';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tooltip',
      title: 'Tooltip',
      center: true,
      scale: 1,
      example: Stack(
        children: [
          Column(
            children: [
              DestructiveButton(
                leading: const Icon(material.Icons.delete),
                child: const Text('Delete'),
                onPressed: () {},
              ),
              const Gap(4),
              const TooltipContainer(
                child: Text('Click to delete this item'),
              ),
            ],
          ),
          const Positioned(
            top: 25,
            left: 100,
            child: CustomPaint(
              painter: CursorPainter(),
            ),
          )
        ],
      ),
    );
  }
}
