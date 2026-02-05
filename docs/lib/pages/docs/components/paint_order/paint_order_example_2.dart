import 'package:shadcn_flutter/shadcn_flutter.dart';

class PaintOrderExample2 extends StatefulWidget {
  const PaintOrderExample2({super.key});

  @override
  State<PaintOrderExample2> createState() => _PaintOrderExample2State();
}

class _PaintOrderExample2State extends State<PaintOrderExample2> {
  final List<int> _paintOrders = [0, 0, 0];
  int _topIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.green, Colors.blue];
    return OutlinedContainer(
      width: 350,
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++)
                PaintOrder(
                  paintOrder: _paintOrders[i],
                  child: Transform.translate(
                    offset: Offset((i - 1) * -30.0, 0),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _paintOrders[i] = ++_topIndex),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: colors[i],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(64),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Card ${i + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Tap a card to bring it to front'),
        ],
      ),
    );
  }
}
