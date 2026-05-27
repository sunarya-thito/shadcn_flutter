# SubFocus

Individual focusable widget within a SubFocusScope hierarchy.

## Usage

### Basic Example
```dart
SubFocus(
  enabled: true,
  builder: (context, state) => GestureDetector(
    onTap: () => state.requestFocus(),
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: state.isFocused ? Colors.blue : Colors.transparent,
        border: Border.all(
          color: state.isFocused ? Colors.blue : Colors.grey,
        ),
      ),
      child: Text(
        'Focusable Item',
        style: TextStyle(
          color: state.isFocused ? Colors.white : Colors.black,
        ),
      ),
    ),
  ),
)
```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `builder` | `SubFocusBuilder` | Builder function that creates the widget tree with focus state.  Called with the build context and focus state, allowing the widget to update its appearance and behavior based on the current focus status. |
| `enabled` | `bool` | Whether this focusable element is enabled.  When `false`, the element cannot receive focus and is excluded from the focus traversal order. Defaults to `true`. |
