import 'package:shadcn_flutter/shadcn_flutter.dart';

class AnimatedLifecycleExample1 extends StatefulWidget {
  const AnimatedLifecycleExample1({super.key});

  @override
  State<AnimatedLifecycleExample1> createState() =>
      _AnimatedLifecycleExample1State();
}

class _AnimatedLifecycleExample1State extends State<AnimatedLifecycleExample1> {
  final TextEditingController _controller = TextEditingController();
  final List<User> users = [];
  int newId = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AnimatedLifecycleBucket(
        builder: (context, children) {
          return Column(children: children);
        },
        children: [
          for (final user in users)
            AnimatedLifecycleWidget(
              key: ValueKey(user.id),
              builder: (context, state, animation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      return SizedBox(
                        height: 72 * animation.value,
                        width: 300,
                        child: Card(
                            child: Label(
                          trailing: IconButton.destructive(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                users.remove(user);
                              });
                            },
                          ),
                          child: Text(user.name),
                        )),
                      );
                    });
              },
            ),
        ],
      ),
      gap(24),
      TextField(
        controller: _controller,
        onSubmitted: (value) {
          if (value.isEmpty) return;
          setState(() {
            users.add(User(id: newId++, name: value));
            _controller.clear();
          });
        },
      ),
      PrimaryButton(
        onPressed: () {
          if (_controller.text.isEmpty) return;
          setState(() {
            users.add(User(id: newId++, name: _controller.text));
            _controller.clear();
          });
        },
        child: Text('Add User'),
      ),
      // Insert User Button
      PrimaryButton(
        onPressed: () {
          setState(() {
            users.insert(0, User(id: newId++, name: _controller.text));
          });
        },
        child: Text('Insert User at Top'),
      ),
      // Insert at Middle button
      PrimaryButton(
        onPressed: () {
          setState(() {
            final middleIndex = users.length ~/ 2;
            users.insert(
                middleIndex, User(id: newId++, name: _controller.text));
          });
        },
        child: Text('Insert User at Middle'),
      ),
    ]);
  }
}

class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}
