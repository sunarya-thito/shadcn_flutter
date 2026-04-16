# PopoverOverlayHandler

Handles overlay presentation for popover components.

## Usage

### Popover Example
```dart
import 'package:docs/pages/docs/components/popover/popover_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PopoverExample extends StatelessWidget {
  const PopoverExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'popover',
      description:
          'A floating message that appears when a user interacts with a target.',
      displayName: 'Popover',
      children: [
        WidgetUsageExample(
          title: 'Popover Example',
          path: 'lib/pages/docs/components/popover/popover_example_1.dart',
          child: PopoverExample1(),
        ),
      ],
    );
  }
}

```

### Popover Example 1
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
    return PrimaryButton(
      onPressed: () {
        showPopover(
          context: context,
          // Position the popover above the button, shifted by 8px.
          alignment: Alignment.topCenter,
          offset: const Offset(0, 8),
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
                          ),
                          FormField<double>(
                            key: FormKey(#maxHeight),
                            label: Text('Max. Height'),
                            child: TextField(
                              initialValue: 'none',
                            ),
                          ),
                        ],
                        spacing: 8,
                      ),
                    ).withPadding(vertical: 16),
                    PrimaryButton(
                      onPressed: () {
                        // Close the popover and resolve the returned future.
                        closeOverlay(context);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          },
        ).future.then((_) {
          // Optional completion hook after the popover is dismissed.
          if (kDebugMode) {
            print('Popover closed');
          }
        });
      },
      child: const Text('Open popover'),
    );
  }
}

```

### Popover Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components/calendar/calendar_example_2.dart';

class PopoverTile extends StatelessWidget implements IComponentPage {
  const PopoverTile({super.key});

  @override
  String get title => 'Popover';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'popover',
      title: 'Popover',
      scale: 1,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePicker(
              value: DateTime.now(),
              mode: PromptMode.popover,
              stateBuilder: (date) {
                if (date.isAfter(DateTime.now())) {
                  return DateState.disabled;
                }
                return DateState.enabled;
              },
              onChanged: (value) {},
            ),
            const Gap(4),
            const CalendarExample2(),
          ],
        ),
      ),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |

