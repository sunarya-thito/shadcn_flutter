# SubFocus

Individual focusable widget within a SubFocusScope hierarchy.

## Usage

No examples found for subfocus.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `builder` | `SubFocusBuilder` | Builder function that creates the widget tree with focus state.  Called with the build context and focus state, allowing the widget to update its appearance and behavior based on the current focus status. |
| `enabled` | `bool` | Whether this focusable element is enabled.  When `false`, the element cannot receive focus and is excluded from the focus traversal order. Defaults to `true`. |
