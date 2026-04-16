# SubFocusScope

Hierarchical focus management system for complex widget trees.

## Usage

// No examples found for subfocus

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `builder` | `SubFocusScopeBuilder?` | Builder function that creates the widget tree for this scope.  Called with the build context and the scope's state for managing focus within child widgets. If `null`, the scope acts as an invisible wrapper without building additional UI. |
| `autofocus` | `bool` | Whether the first child should automatically receive focus.  When `true`, the first attached [SubFocus] widget will automatically gain focus when the scope is built. Defaults to `false`. |
