import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarTile extends StatelessWidget implements IComponentPage {
  const MenubarTile({super.key});

  @override
  String get title => 'Menubar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Menubar',
      name: 'menubar',
      scale: 1,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedContainer(
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.background,
              borderRadius: theme.borderRadiusMd,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('File'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar().copyWith(
                          decoration: (context, states, value) {
                            return (value as BoxDecoration).copyWith(
                              color: theme.colorScheme.accent,
                              borderRadius:
                                  BorderRadius.circular(theme.radiusSm),
                            );
                          },
                        ),
                        child: const Text('Edit'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('View'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('Help'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(4),
            Container(
              width: 192,
              margin: const EdgeInsets.only(left: 48),
              child: MenuPopup(children: [
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyZ, control: true),
                  ),
                  child: const Text('Undo'),
                ),
                Button(
                  style: const ButtonStyle.menu().copyWith(
                      decoration: (context, states, value) {
                    return (value as BoxDecoration).copyWith(
                      color: theme.colorScheme.accent,
                      borderRadius: BorderRadius.circular(theme.radiusSm),
                    );
                  }),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyY, control: true),
                  ),
                  child: const Text('Redo'),
                ),
                const MenuDivider(),
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyX, control: true),
                  ),
                  child: const Text('Cut'),
                ),
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyC, control: true),
                  ),
                  child: const Text('Copy'),
                ),
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyV, control: true),
                  ),
                  child: const Text('Paste'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
