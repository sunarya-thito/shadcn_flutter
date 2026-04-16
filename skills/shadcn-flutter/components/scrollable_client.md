# ScrollableClient

A customizable scrollable widget with two-axis scrolling support.

## Usage

No examples found for scrollable_client.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `primary` | `bool?` | Whether this is the primary scrollable in the widget tree. |
| `mainAxis` | `Axis` | Primary scrolling axis. |
| `verticalDetails` | `ScrollableDetails` | Scroll configuration for vertical axis. |
| `horizontalDetails` | `ScrollableDetails` | Scroll configuration for horizontal axis. |
| `builder` | `ScrollableBuilder` | Builder for creating content with viewport info. |
| `child` | `Widget?` | Optional child widget. |
| `diagonalDragBehavior` | `DiagonalDragBehavior?` | Behavior for diagonal drag gestures. |
| `dragStartBehavior` | `DragStartBehavior?` | When drag gestures should start. |
| `keyboardDismissBehavior` | `ScrollViewKeyboardDismissBehavior?` | How keyboard dismissal should behave. |
| `clipBehavior` | `Clip?` | How to clip content. |
| `hitTestBehavior` | `HitTestBehavior?` | Hit test behavior. |
| `overscroll` | `bool?` | Whether overscroll effects are enabled. |
