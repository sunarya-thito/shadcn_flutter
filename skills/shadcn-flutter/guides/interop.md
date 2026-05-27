# Material & Cupertino Interop

`shadcn_flutter` is designed to be a standalone ecosystem, but it plays exceptionally well with Flutter's built-in Material and Cupertino libraries.

## Incremental Adoption

You don't have to switch your entire app to `shadcn_flutter` at once. The library is designed for incremental adoption:

1. **Mix and Match**: Drop `shadcn_flutter` components directly into an existing `MaterialApp` or `CupertinoApp`.
2. **Shared State**: Keep your current routing (e.g., `GoRouter`) and state management libraries.
3. **Theme Alignment**: Material/Cupertino widgets will automatically attempt to follow the `shadcn_flutter` theme when wrapped correctly.

## Theme Synchronization

By default, when using `ShadcnApp`, Material and Cupertino widgets will inherit the styling defined in your `ThemeData`. 

### Using Shadcn inside Material/Cupertino
If you are using `shadcn_flutter` widgets inside a `MaterialApp` or `CupertinoApp`, you **must** wrap them in a `ShadcnUI` widget. This ensures the inherited theme and semantics are properly applied to the components.

```dart
// Inside a Material Scaffold
shadcn.ShadcnUI(
  child: shadcn.Card(
    child: Text('Shadcn Card inside Material!'),
  ),
)
```

> [!IMPORTANT]
> Without the `ShadcnUI` wrapper, components may not inherit the correct styling tokens (like radius or surface colors) from your `MaterialApp`'s theme context.

## Usage Example

### Material Widgets in Shadcn
You can use any Material widget (like `ElevatedButton` or `Scaffold`) inside a `shadcn_flutter` app. They will use the color scheme defined in your `shadcn_flutter` theme.

```dart
// A Material button inside a Shadcn view
ElevatedButton(
  onPressed: () {},
  child: const Text('Material Button'),
)
```

### Cupertino Widgets in Shadcn
Similarly, Cupertino widgets (like `CupertinoButton` or `CupertinoSwitch`) can be used to provide a platform-native feel while still benefiting from the global theme tokens.

```dart
// A Cupertino switch inside a Shadcn view
CupertinoSwitch(
  value: true,
  onChanged: (val) {},
)
```

## Best Practices

- **Avoid Theme Conflicts**: If you are using `MaterialApp`, ensure you don't have conflicting global styles that override the specific tokens intended for `shadcn_flutter` components.
- **Incremental Migration**: Start by replacing complex UI sections (like Data Tables or complex Forms) with `shadcn_flutter` components while leaving the navigation and shell as Material/Cupertino.
- **Go All-In**: Once your main core components are migrated, consider switching the root widget to `ShadcnApp` for the full ecosystem experience.
