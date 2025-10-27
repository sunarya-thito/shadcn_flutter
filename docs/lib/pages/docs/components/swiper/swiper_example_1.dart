import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwiperExample1 extends StatefulWidget {
  const SwiperExample1({super.key});

  @override
  State<SwiperExample1> createState() => _SwiperExample1State();
}

class _SwiperExample1State extends State<SwiperExample1> {
  OverlayPosition _position = OverlayPosition.end;
  bool _typeDrawer = true;

  Widget _buildSelectPosition(OverlayPosition position, String label) {
    return SelectedButton(
      value: _position == position,
      onChanged: (value) {
        if (value) {
          setState(() {
            _position = position;
          });
        }
      },
      style: const ButtonStyle.outline(),
      selectedStyle: const ButtonStyle.primary(),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(
            minWidth: 320,
            minHeight: 320,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello!'),
              const Gap(24),
              PrimaryButton(
                onPressed: () {
                  openDrawer(
                      context: context,
                      builder: (context) {
                        return ListView.separated(
                          itemCount: 1000,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Text('Item $index'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(8);
                          },
                        );
                      },
                      position: OverlayPosition.bottom);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      // Swiper displays an overlay (drawer/sheet) that can be swiped in from a chosen edge.
      position: _position,
      // Choose the overlay type: Drawer slides over content; Sheet peeks up from an edge.
      handler: _typeDrawer ? SwiperHandler.drawer : SwiperHandler.sheet,
      child: SizedBox(
        height: 500,
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Swipe me!'),
                const Gap(24),
                ButtonGroup(children: [
                  _buildSelectPosition(OverlayPosition.left, 'Left'),
                  _buildSelectPosition(OverlayPosition.right, 'Right'),
                  _buildSelectPosition(OverlayPosition.top, 'Top'),
                  _buildSelectPosition(OverlayPosition.bottom, 'Bottom'),
                ]),
                const Gap(24),
                ButtonGroup(children: [
                  Toggle(
                    value: _typeDrawer,
                    onChanged: (value) {
                      setState(() {
                        _typeDrawer = value;
                      });
                    },
                    child: const Text('Drawer'),
                  ),
                  Toggle(
                    value: !_typeDrawer,
                    onChanged: (value) {
                      setState(() {
                        _typeDrawer = !value;
                      });
                    },
                    child: const Text('Sheet'),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
