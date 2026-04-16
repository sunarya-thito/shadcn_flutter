# Hidden

A widget that conditionally hides its child with optional animation.

## Usage

No examples found for hidden.

## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `hidden` | `bool` | Whether the child widget should be hidden.  When `true`, the child is hidden (optionally animated). When `false`, the child is visible. |
| `child` | `Widget` | The child widget to show or hide. |
| `direction` | `Axis?` | The axis along which to animate the hiding.  If `null`, the widget is hidden without animation. |
| `reverse` | `bool?` | Whether to reverse the hide animation direction.  When `true`, slides out in the opposite direction. |
| `duration` | `Duration?` | Duration of the hide/show animation.  If `null`, uses a default duration or hides instantly. |
| `curve` | `Curve?` | Animation curve for the hide/show transition.  If `null`, uses a default curve. |
| `keepCrossAxisSize` | `bool?` | Whether to maintain the widget's cross-axis size when hidden.  When `true`, preserves width (for vertical slides) or height (for horizontal slides) during the animation. |
| `keepMainAxisSize` | `bool?` | Whether to maintain the widget's main-axis size when hidden.  When `true`, preserves the size along the animation axis, creating a fade-out effect instead of a slide. |
