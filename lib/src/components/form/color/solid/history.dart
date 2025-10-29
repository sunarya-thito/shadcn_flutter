import 'package:shadcn_flutter/shadcn_flutter.dart';

class ColorHistoryGrid extends StatelessWidget {
  final ColorHistoryStorage storage;
  final ValueChanged<Color>? onColorPicked;
  final double? spacing;
  final int crossAxisCount;
  final Color? selectedColor;

  const ColorHistoryGrid({
    super.key,
    required this.storage,
    this.onColorPicked,
    this.spacing,
    this.crossAxisCount = 10,
    this.selectedColor,
  });

  Widget _buildGridTile(BuildContext context, Color? color, ThemeData theme) {
    if (color == null) {
      return const AspectRatio(
        aspectRatio: 1,
        child: Button(
          style: ButtonStyle.outline(
            density: ButtonDensity.compact,
          ),
          child: Icon(LucideIcons.x),
        ),
      );
    }
    return Container(
      decoration: selectedColor != null && color == selectedColor
          ? BoxDecoration(
              border: Border.all(
                  color: theme.colorScheme.primary, width: 2 * theme.scaling),
              borderRadius: BorderRadius.circular(theme.radiusMd),
            )
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: Button(
          style: const ButtonStyle.outline(
            density: ButtonDensity.compact,
          ),
          onPressed: () {
            onColorPicked?.call(color);
          },
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double spacing = this.spacing ?? (4 * theme.scaling);
    return ListenableBuilder(
        listenable: storage,
        builder: (context, child) {
          List<Widget> rows = [];
          for (int i = 0; i < storage.capacity; i += crossAxisCount) {
            List<Widget> tiles = [];
            for (int j = 0; j < crossAxisCount; j++) {
              final index = i + j;
              final color = index < storage.recentColors.length
                  ? storage.recentColors[index]
                  : null;
              if (index >= storage.capacity) {
                tiles.add(
                  const Expanded(
                    child: SizedBox(),
                  ),
                );
              } else {
                tiles.add(
                  Expanded(
                    child: _buildGridTile(context, color, theme),
                  ),
                );
              }
              if (j < crossAxisCount - 1) {
                tiles.add(Gap(spacing));
              }
            }
            rows.add(IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: tiles,
              ),
            ));
            if (i < storage.capacity - crossAxisCount) {
              rows.add(Gap(spacing));
            }
          }
          return IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rows,
            ),
          );
        }).constrained(
      minHeight: 100,
    );
  }
}

abstract class ColorHistoryStorage implements Listenable {
  void addHistory(Color color);
  void setHistory(List<Color> colors);
  void clear();
  int get capacity;
  List<Color> get recentColors;
  static ColorHistoryStorage of(BuildContext context) {
    return Data.of<ColorHistoryStorage>(context);
  }
}

class RecentColorsScope extends StatefulWidget {
  final List<Color> initialRecentColors;
  final int maxRecentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;
  final Widget child;

  const RecentColorsScope({
    super.key,
    this.initialRecentColors = const [],
    this.maxRecentColors = 50,
    this.onRecentColorsChanged,
    required this.child,
  });

  @override
  State<RecentColorsScope> createState() => RecentColorsScopeState();
}

class _ColorListNotifier extends ChangeNotifier {
  List<Color> _recentColors;

  _ColorListNotifier(this._recentColors);

  void _notify() {
    notifyListeners();
  }
}

class RecentColorsScopeState extends State<RecentColorsScope>
    implements ColorHistoryStorage {
  late _ColorListNotifier _recentColors;

  @override
  int get capacity => widget.maxRecentColors;

  @override
  void initState() {
    super.initState();
    _recentColors = _ColorListNotifier(List.from(widget.initialRecentColors));
  }

  @override
  List<Color> get recentColors =>
      List.unmodifiable(_recentColors._recentColors);

  @override
  void addHistory(Color color) {
    var recentColors = _recentColors._recentColors;
    if (recentColors.contains(color)) {
      recentColors.remove(color);
    }
    recentColors.insert(0, color);
    if (recentColors.length > widget.maxRecentColors) {
      recentColors.removeLast();
    }
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void dispose() {
    super.dispose();
    _recentColors.dispose();
  }

  @override
  void clear() {
    _recentColors._recentColors.clear();
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void setHistory(List<Color> colors) {
    _recentColors._recentColors = colors;
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  Widget build(BuildContext context) {
    return Data<ColorHistoryStorage>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void addListener(VoidCallback listener) {
    _recentColors.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _recentColors.removeListener(listener);
  }
}
