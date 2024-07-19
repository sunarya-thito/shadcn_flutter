import 'package:shadcn_flutter/shadcn_flutter.dart';

void showToast({required WidgetBuilder builder}) {}

enum ToastLocation {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class ToastLayer extends StatefulWidget {
  final Widget child;
  final int maxStackedEntries;
  final EdgeInsets padding;

  const ToastLayer({super.key, 
    required this.child,
    this.maxStackedEntries = 3,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  State<ToastLayer> createState() => _ToastLayerState();
}

class _ToastLayerState extends State<ToastLayer> {
  final Map<ToastLocation, List<ToastEntry>> entries = {
    ToastLocation.topLeft: [],
    ToastLocation.topCenter: [],
    ToastLocation.topRight: [],
    ToastLocation.bottomLeft: [],
    ToastLocation.bottomCenter: [],
    ToastLocation.bottomRight: [],
  };

  void addEntry(ToastEntry entry) {
    setState(() {
      var entries = this.entries[entry.location];
      entries!.add(entry);
    });
  }

  void removeEntry(ToastEntry entry) {
    setState(() {
      entries[entry.location]!.remove(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      widget.child,
    ];
    for (var locationEntry in entries.entries) {
      var location = locationEntry.key;
      var entries = locationEntry.value;
      for (var i = 0; i < entries.length; i++) {
        var entry = entries[i];
        children.add(
          Positioned(
            left: 0,
            right: 0,
            child: entry.builder(context),
          ),
        );
      }
    }
    return Stack(
      children: children,
    );
  }
}

class ToastEntry {
  final GlobalKey key = GlobalKey();
  final WidgetBuilder builder;
  final ToastLocation location;

  ToastEntry({required this.builder, required this.location});
}

class OverlaidToastEntry extends StatelessWidget {
  final ToastEntry entry;
  final Widget previousToast;

  const OverlaidToastEntry({super.key, required this.entry, required this.previousToast});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
