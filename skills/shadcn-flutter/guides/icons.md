# Icons

Shadcn Flutter bundles over 10,000+ high-quality icons across multiple industry-standard sets. All icons are optimized for Flutter and support theme-aware scaling and coloring.

## Icon Sets

We provide exhaustive listings for each of the three bundled provider sets:

| Provider | Description | Total Icons | Link |
| :--- | :--- | :--- | :--- |
| **Radix Icons** | Clean, minimalist icons from the Radix UI team. | 250+ | [View Listing](../icons/radix_icons.md) |
| **Lucide Icons** | A community-run fork of Feather. Beautiful and consistent. | 1,550+ | [View Listing](../icons/lucide_icons.md) |
| **Bootstrap Icons** | Extensive icon set from the creators of Bootstrap. | 2,050+ | [View Listing](../icons/bootstrap_icons.md) |

## Usage

To use an icon, simply wrap the static constant from the desired set in an `Icon` widget.

```dart
// Using Lucide
Icon(LucideIconss.activity)

// Using Bootstrap
Icon(BootstrapIconss.alarm)

// Using Radix
Icon(RadixIconss.accessibility)
```

## Styling

Icons automatically inherit the current theme's icon styling. You can customize them using standard `Icon` properties:

```dart
Icon(
  LucideIconss.heart,
  color: Colors.red[500],
  size: 24,
)
```

## Sizing Tokens

For consistent sizing across your app, use the theme's icon size tokens in `ThemeData.iconTheme`:

- `x4Small`
- `xSmall`
- `small`
- `medium` (default)
- `large`
- `xLarge`
- `x4Large`

> [!TIP]
> Use `.iconSmall()`, `.iconLarge()`, etc., extensions on an `Icon` widget if available in your project's custom utility extensions to stay consistent with the typography system.
