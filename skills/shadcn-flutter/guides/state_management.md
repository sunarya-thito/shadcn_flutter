# State Management

`shadcn_flutter` is state-management agnostic, meaning it works alongside any approach you choose. However, it also includes a built-in system designed for clean, reactive UI patterns.

## Recommended Packages

While you can use the built-in system, we also highly recommend these community-vetted packages for larger applications:

- **Riverpod**: Declarative and great for testability.
- **Provider**: Lightweight and industry standard.
- **BLoC/Cubit**: Event-driven and highly predictable.
- **GetIt**: For service location and dependency injection.

## Built-in System

The library provides `Data` and `Model` widgets that offer a lightweight way to pass and listen to state without external dependencies.

### 1. Passing Data to Children
Use the `Data` widget to share a value down the widget tree. When the value changes, only the widgets listening to that specific data type will rebuild.

```dart
// Providing data
Data<int>.inherit(
  data: counter,
  child: const MyCounterWidget(),
)

// Consuming data
final counter = Data.of<int>(context);
```

#### Listening vs Finding
- `Data.of(context)`: Listens for changes and rebuilds the widget.
- `Data.find(context)`: Retrieves the current value without registering for rebuilds (ideal for `onPressed` handlers).

### 2. MultiData Widget
To avoid deep nesting when providing multiple types of data, use `MultiData`:

```dart
MultiData(
  dataList: [
    Data<int>(counter),
    Data<String>(userName),
    Data<bool>.boundary(), // Prevents children from seeing parents' bool data
  ],
  child: const AppContent(),
)
```

### 3. State as a Controller
You can pass a state object (like a `ChangeNotifier` or a custom class) as a controller, allowing child widgets to call methods on the parent.

```dart
Data<MyController>.inherit(
  data: myController,
  child: const ControlPanel(),
)
```

### 4. DataBuilder & DataNotifier
- **DataBuilder**: Rebuilds only a specific part of the tree when data changes.
- **DataNotifier**: Connects a `ValueListenable` (like `ValueNotifier`) to the `Data` widget system.

## Variables and Models

For type-safe, labeled state, use the `Model` widgets.

### ModelNotifier
`ModelNotifier` allows you to pass values to children using a `ValueNotifier`, avoiding `setState` calls in the parent widget for simple state updates.

```dart
ModelNotifier<double>(
  value: brightness,
  child: const BrightnessSlider(),
)
```

### ModelBuilder
Similar to `DataBuilder`, but specifically for `Model` widgets. It ensures that only the necessary parts of your UI react to state changes, maintaining high performance.

## Best Practices

- **Distinct Data**: When passing complex objects, ensure they override `operator ==` and `hashCode`, or use the `DistinctData` mixin to notify only when specific fields change.
- **Immutability**: Prefer passing immutable objects. Mutable lists or maps won't trigger rebuilds unless the reference changes.
- **Boundaries**: Use `Data.boundary()` to scope data and prevent accidental state leakage between different parts of your app.
