---
title: "Example: components/swiper/swiper_example_1.dart"
description: "Component example"
---

Source preview
```dart
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
```
