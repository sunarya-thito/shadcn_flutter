---
title: "Example: components/popover/popover_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Shows how to open a contextual popover anchored to a button, with a custom
// overlay barrier and a simple form inside. The popover closes via
// closeOverlay(context) or when the user taps outside the barrier.

class PopoverExample1 extends StatelessWidget {
  const PopoverExample1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryButton(
      onPressed: () {
        showPopover(
          context: context,
          // Position the popover above the button, shifted by 8px.
          alignment: Alignment.topCenter,
          offset: const Offset(0, 8),
          // Unless you have full opacity surface,
          // you should explicitly set the overlay barrier.
          overlayBarrier: OverlayBarrier(
            borderRadius: theme.borderRadiusLg,
          ),
          builder: (context) {
            return ModalContainer(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Dimensions').large().medium(),
                    const Text('Set the dimensions for the layer.').muted(),
                    Form(
                      controller: FormController(),
                      // Compact grid layout for label/field rows.
                      child: const FormTableLayout(
                        rows: [
                          FormField<double>(
                            key: FormKey(#width),
                            label: Text('Width'),
                            child: TextField(
                              initialValue: '100%',
                            ),
                          ),
                          FormField<double>(
                            key: FormKey(#maxWidth),
                            label: Text('Max. Width'),
                            child: TextField(
                              initialValue: '300px',
                            ),
                          ),
                          FormField<double>(
                            key: FormKey(#height),
                            label: Text('Height'),
                            child: TextField(
                              initialValue: '25px',
                            ),
```
