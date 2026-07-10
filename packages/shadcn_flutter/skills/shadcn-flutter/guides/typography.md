# Typography

Clean, semantic typography built on the **Geist** font family.

## Text Extensions

The easiest way to style text is by using `.style()` extensions on any `Text` widget.

### Heading Styles
| Extension | Style | Description |
| :--- | :--- | :--- |
| `.h1()` | 30px, Bold | Large page titles. |
| `.h2()` | 24px, SemiBold | Section headers. |
| `.h3()` | 20px, SemiBold | Subsection headers. |
| `.h4()` | 18px, SemiBold | Smaller group headers. |

### Body Styles
| Extension | Style | Description |
| :--- | :--- | :--- |
| `.p()` | 14px, Regular | Standard body text. |
| `.lead()` | 16px, Regular | Lead paragraphs (muted foreground). |
| `.large()` | 16px, SemiBold | Emphasis or important text. |
| `.small()` | 12px, Regular | Captions or secondary information. |
| `.muted()` | (inherited), Muted | Sets foreground to `theme.colorScheme.mutedForeground`. |

### Inline Variations
- `.italic()`: Italicize text.
- `.bold()`: Make text bold.
- `.semiBold()`: Make text semibold.
- `.mono()`: Use monospace font (e.g., for code).

## Usage Example

```dart
Column(
  children: [
    const Text('Welcome to Shadcn').h1(),
    const Text('A cohesive UI ecosystem for Flutter.').lead(),
    const Gap(16),
    const Text('This is standard body text.').p(),
    const Text('Important highlight').large().bold(),
  ],
)
```

## Customization

You can define your own typography in `ThemeData`:

```dart
ThemeData(
  typography: Typography.sans(
    family: 'Inter',
    base: const TextStyle(fontSize: 16),
  ),
)
```

## Performance Tip

Text extensions are stateless and extremely lightweight. Use them liberally to keep your widget trees clean and readable.
