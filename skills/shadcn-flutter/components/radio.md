# Radio Group

A set of checkable buttons—known as radio buttons—where no more than one button can be checked at a time.

## Usage

```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

ControlledRadioGroup<String>(
  initialValue: 'option-one',
  onChanged: (value) => print('Selected: $value'),
  child: Column(
    children: [
      RadioItem(
        value: 'option-one',
        trailing: Text('Option One'),
      ),
      RadioItem(
        value: 'option-two',
        trailing: Text('Option Two'),
      ),
    ],
  ),
)
```

## Variants

### Radio Item
The standard radio button with a label.
```dart
RadioItem(
  value: 'value',
  leading: Text('Label before'),
  trailing: Text('Label after'),
)
```

### Radio Card
A larger, card-style selection area.
```dart
RadioCard(
  value: 'card-value',
  child: Column(
    children: [
      Text('Card Title').h3(),
      Text('More detailed description here.').muted(),
    ],
  ),
)
```

## Features

### Orientation
Since `RadioGroup` takes a `child` (usually a `Column`, `Row`, or `Wrap`), you have full control over the layout of the radio items.

### Selection Management
The `ControlledRadioGroup` handles mutual exclusion automatically. Only one `RadioItem` or `RadioCard` with a matching type `T` can be selected at once.

## Properties

### ControlledRadioGroup

| Property | Type | Description |
| :--- | :--- | :--- |
| `child` | `Widget` | The layout containing radio items. |
| `initialValue` | `T?` | The initially selected value. |
| `onChanged` | `ValueChanged<T?>?` | Callback when selection changes. |
| `enabled` | `bool` | Whether the group is interactive. |

### RadioItem

| Property | Type | Description |
| :--- | :--- | :--- |
| `value` | `T` | The unique value for this item. |
| `leading` | `Widget?` | Widget before the radio button. |
| `trailing` | `Widget?` | Widget after the radio button. |
| `enabled` | `bool` | Whether this item is interactive. |

### RadioCard

| Property | Type | Description |
| :--- | :--- | :--- |
| `value` | `T` | The unique value for this card. |
| `child` | `Widget` | The content of the card. |
| `filled` | `bool` | Whether the card uses a filled background when selected. |
