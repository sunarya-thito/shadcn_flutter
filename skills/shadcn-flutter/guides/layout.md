# Layout & Spacing

Master the responsive layout engine and spacing tokens of `shadcn_flutter`.

## Adaptive Scaling

The layout system distinguishes between **Mobile** and **Desktop** scaling defaults to ensure optimal legibility across devices.

- **Desktop**: 1.0x scaling (standard).
- **Mobile**: 1.25x scaling (larger touch targets and text).

You can override this globally in `ShadcnApp`:

```dart
ShadcnApp(
  scaling: AdaptiveScaling(1.1), // Custom uniform scaling
  // or
  scaling: AdaptiveScaling.only(textScaling: 1.2, sizeScaling: 1.0),
)
```

## Spacing Tokens

Use the semantic spacing helpers to maintain consistency.

### Gaps
The `Gap` widget is the preferred way to add spacing between elements in a `Column` or `Row`.

| Token | Size (unscaled) | Usage |
| :--- | :--- | :--- |
| `Gap(4)` | 4 | `const Gap(4)` |
| `Gap(8)` | 8 | `const Gap(8)` |
| `Gap(12)` | 12 | `const Gap(12)` |
| `Gap(16)` | 16 | `const Gap(16)` |
| `Gap(24)` | 24 | `const Gap(24)` |
| `Gap(32)` | 32 | `const Gap(32)` |

### Padding
Access theme-aware padding via `Theme.of(context)`:

- `theme.paddingSm`: Small padding.
- `theme.paddingMd`: Medium padding.
- `theme.paddingLg`: Large padding.

## Border Radius

`shadcn_flutter` uses a base `radius` multiplier (default: 0.5) to calculate all corner roundness.

| Token | Calculation | Description |
| :--- | :--- | :--- |
| `radiusXs` | `radius * 4` | Extra small corners. |
| `radiusSm` | `radius * 8` | Small corners (default for many components). |
| `radiusMd` | `radius * 12` | Medium corners. |
| `radiusLg` | `radius * 16` | Large corners. |
| `radiusXl` | `radius * 20` | Extra large corners. |
| `radiusXxl` | `radius * 24` | 2X large corners. |

### Usage
```dart
Container(
  decoration: BoxDecoration(
    borderRadius: theme.borderRadiusMd, // Returns a BorderRadius
    // or
    borderRadius: BorderRadius.circular(theme.radiusMd),
  ),
)
```

## Responsive Helpers

Use `Flexible`, `Expanded`, and `Flex` for fluid layouts. Additionally, `ShadcnApp` provides `Density` control to adjust how compact the UI should be on different screen sizes.
