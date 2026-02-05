import 'package:docs/code_highlighter.dart';
import 'package:docs/main.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';
import '../docs/sidebar_nav.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _BaseSchemeOption {
  final String id;
  final String label;
  final ColorScheme light;
  final ColorScheme dark;

  const _BaseSchemeOption({
    required this.id,
    required this.label,
    required this.light,
    required this.dark,
  });

  ColorScheme forMode(bool isDark) => isDark ? dark : light;
}

class _AccentOption {
  final String id;
  final String label;
  final Color? color;

  const _AccentOption({
    required this.id,
    required this.label,
    required this.color,
  });
}

const List<_BaseSchemeOption> _baseSchemes = [
  _BaseSchemeOption(
    id: 'slate',
    label: 'Slate',
    light: ColorSchemes.lightSlate,
    dark: ColorSchemes.darkSlate,
  ),
  _BaseSchemeOption(
    id: 'zinc',
    label: 'Zinc',
    light: ColorSchemes.lightZinc,
    dark: ColorSchemes.darkZinc,
  ),
  _BaseSchemeOption(
    id: 'gray',
    label: 'Gray',
    light: ColorSchemes.lightGray,
    dark: ColorSchemes.darkGray,
  ),
  _BaseSchemeOption(
    id: 'neutral',
    label: 'Neutral',
    light: ColorSchemes.lightNeutral,
    dark: ColorSchemes.darkNeutral,
  ),
  _BaseSchemeOption(
    id: 'stone',
    label: 'Stone',
    light: ColorSchemes.lightStone,
    dark: ColorSchemes.darkStone,
  ),
];

const List<_AccentOption> _accentOptions = [
  _AccentOption(id: 'base', label: 'Base', color: null),
  _AccentOption(id: 'slate', label: 'Slate', color: Colors.slate),
  _AccentOption(id: 'gray', label: 'Gray', color: Colors.gray),
  _AccentOption(id: 'zinc', label: 'Zinc', color: Colors.zinc),
  _AccentOption(id: 'neutral', label: 'Neutral', color: Colors.neutral),
  _AccentOption(id: 'stone', label: 'Stone', color: Colors.stone),
  _AccentOption(id: 'red', label: 'Red', color: Colors.red),
  _AccentOption(id: 'orange', label: 'Orange', color: Colors.orange),
  _AccentOption(id: 'amber', label: 'Amber', color: Colors.amber),
  _AccentOption(id: 'yellow', label: 'Yellow', color: Colors.yellow),
  _AccentOption(id: 'lime', label: 'Lime', color: Colors.lime),
  _AccentOption(id: 'green', label: 'Green', color: Colors.green),
  _AccentOption(id: 'emerald', label: 'Emerald', color: Colors.emerald),
  _AccentOption(id: 'teal', label: 'Teal', color: Colors.teal),
  _AccentOption(id: 'cyan', label: 'Cyan', color: Colors.cyan),
  _AccentOption(id: 'sky', label: 'Sky', color: Colors.sky),
  _AccentOption(id: 'blue', label: 'Blue', color: Colors.blue),
  _AccentOption(id: 'indigo', label: 'Indigo', color: Colors.indigo),
  _AccentOption(id: 'violet', label: 'Violet', color: Colors.violet),
  _AccentOption(id: 'purple', label: 'Purple', color: Colors.purple),
  _AccentOption(id: 'fuchsia', label: 'Fuchsia', color: Colors.fuchsia),
  _AccentOption(id: 'pink', label: 'Pink', color: Colors.pink),
  _AccentOption(id: 'rose', label: 'Rose', color: Colors.rose),
];

const Map<String, Density> _densityOptions = {
  'Compact': Density.compactDensity,
  'Reduced': Density.reducedDensity,
  'Default': Density.defaultDensity,
  'Spacious': Density.spaciousDensity,
};

const Map<String, double> _radiusOptions = {
  'Sharp': 0.0,
  'Subtle': 0.25,
  'Default': 0.5,
  'Rounded': 0.75,
  'Pill': 1.5,
};

const Map<String, double> _scalingOptions = {
  'Compact': 0.85,
  'Default': 1.0,
  'Large': 1.15,
};

const Map<String, double> _surfaceOpacityOptions = {
  'Solid': 1.0,
  'Frosted': 0.9,
  'Translucent': 0.8,
  'Ghosted': 0.7,
};

const Map<String, double> _surfaceBlurOptions = {
  'None': 0.0,
  'Soft': 4.0,
  'Medium': 8.0,
  'Strong': 12.0,
};

String _schemeKey(String baseId, String accentId, bool isDark) {
  return '${isDark ? 'dark' : 'light'}-$baseId-$accentId';
}

Map<String, ColorScheme> _buildColorSchemes() {
  final Map<String, ColorScheme> schemes = {};
  for (final base in _baseSchemes) {
    for (final isDark in [false, true]) {
      final baseScheme = base.forMode(isDark);
      for (final accent in _accentOptions) {
        final scheme = accent.color == null
            ? baseScheme
            : baseScheme.recolor(accent.color!);
        schemes[_schemeKey(base.id, accent.id, isDark)] = scheme;
      }
    }
  }
  return schemes;
}

final Map<String, ColorScheme> colorSchemes = _buildColorSchemes();

String? nameFromColorScheme(ColorScheme scheme) {
  return colorSchemes.entries
      .where((entry) => entry.value == scheme)
      .map((entry) => entry.key)
      .firstOrNull;
}

class _ThemePageState extends State<ThemePage> {
  late bool isDark;
  late String baseKey;
  late String accentKey;
  late double radius;
  late Density density;
  late double scaling;
  late double surfaceOpacity;
  late double surfaceBlur;
  late ColorScheme colorScheme;
  bool applyDirectly = true;

  bool previewSwitch = true;
  CheckboxState previewCheckbox = CheckboxState.checked;
  SliderValue previewSlider = const SliderValue.single(0.6);

  final ScrollController _scrollController = ScrollController();
  final String _pageName = 'theme';

  @override
  void initState() {
    super.initState();
    colorScheme = ColorSchemes.darkSlate;
    isDark = true;
    baseKey = 'slate';
    accentKey = 'base';
    radius = 0.5;
    density = Density.defaultDensity;
    scaling = 1.0;
    surfaceOpacity = 1.0;
    surfaceBlur = 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MyAppState state = Data.of(context);
    colorScheme = state.colorScheme;
    isDark = colorScheme.brightness == Brightness.dark;
    baseKey = _resolveBaseKey(colorScheme) ?? 'slate';
    accentKey = _resolveAccentKey(colorScheme, _baseScheme(baseKey, isDark));
    radius = state.radius;
    density = state.density;
    scaling = state.scaling;
    surfaceOpacity = state.surfaceOpacity;
    surfaceBlur = state.surfaceBlur;
  }

  @override
  Widget build(BuildContext context) {
    final MyAppState state = Data.of(context);
    final baseScheme = _baseScheme(baseKey, isDark);
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyF, control: true):
            OpenSearchCommandIntent(),
      },
      child: Actions(
        actions: {
          OpenSearchCommandIntent:
              CallbackAction<OpenSearchCommandIntent>(onInvoke: (intent) {
            _showSearchBar();
            return null;
          }),
        },
        child: ClipRect(
          child: PageStorage(
            bucket: docsBucket,
            child: Scaffold(
              headers: [
                Container(
                  color:
                      Theme.of(context).colorScheme.background.scaleAlpha(0.3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MediaQueryVisibility(
                        minWidth: breakpointWidth,
                        alternateChild: AppBar(
                          padding: EdgeInsets.symmetric(
                            vertical: 12 * Theme.of(context).scaling,
                            horizontal: 18 * Theme.of(context).scaling,
                          ),
                          leading: [
                            GhostButton(
                              density: ButtonDensity.icon,
                              onPressed: () {
                                _openDrawer(context);
                              },
                              child: const Icon(Icons.menu),
                            ),
                          ],
                          trailing: _appBarActions(context),
                          child: Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlineButton(
                                onPressed: _showSearchBar,
                                trailing: const Icon(Icons.search)
                                    .iconSmall()
                                    .iconMutedForeground(),
                                child: Row(
                                  spacing: 8,
                                  children: [
                                    const Text('Search documentation...')
                                        .muted()
                                        .normal(),
                                    const KeyboardDisplay.fromActivator(
                                      activator: SingleActivator(
                                        LogicalKeyboardKey.keyF,
                                        control: true,
                                      ),
                                    ).xSmall.withOpacity(0.8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: _buildAppBar(
                          const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 32, right: 32) *
                              Theme.of(context).scaling,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaQueryVisibility(
                    minWidth: breakpointWidth,
                    child: FocusTraversalGroup(
                      child: SingleChildScrollView(
                        key: const PageStorageKey('sidebar'),
                        padding:
                            const EdgeInsets.only(top: 32, left: 24, bottom: 32) *
                                Theme.of(context).scaling,
                        child: _ThemeSidebar(
                          sections: DocsPageState.sections,
                          pageName: _pageName,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FocusTraversalGroup(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        clipBehavior: Clip.none,
                        padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 32,
                                ) *
                                Theme.of(context).scaling +
                            MediaQuery.of(context).padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Breadcrumb(
                              separator: Breadcrumb.arrowSeparator,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.goNamed('introduction');
                                  },
                                  density: ButtonDensity.compact,
                                  child: const Text('Docs'),
                                ),
                                const Text('Theme'),
                              ],
                            ),
                            Gap(16 * Theme.of(context).scaling),
                            _buildKitchenPreview(context),
                            const Gap(24),
                            MediaQueryVisibility(
                              maxWidth: breakpointWidth2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildOptionsPanel(state, baseScheme, false),
                                ],
                              ),
                            ),
                            const Text('Code').h2(),
                            CodeBlock(
                              code: buildCode(),
                              mode: 'dart',
                            ).p(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MediaQueryVisibility(
                    minWidth: breakpointWidth2,
                    child: Container(
                      width: 240,
                      alignment: Alignment.topLeft,
                      child: FocusTraversalGroup(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                                top: 32,
                                right: 24,
                                bottom: 32,
                                left: 0,
                              ) *
                              Theme.of(context).scaling,
                          child: _buildOptionsPanel(state, baseScheme),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // KITCHEN PREVIEWS
  Widget _buildKitchenPreview(BuildContext context) {
    return MediaQueryVisibility(
      minWidth: 1350,
      alternateChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildKitchenPaymentMethod(context),
          const DensityGap(gap2xl),
          _buildKitchenInputs(context),
          const DensityGap(gap2xl),
          _buildKitchenAppearanceSettings(context),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildKitchenPaymentMethod(context)),
          const DensityGap(gap2xl),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _buildKitchenInputs(context),
            ),
          ),
          const DensityGap(gap2xl),
          Expanded(child: _buildKitchenAppearanceSettings(context)),
        ],
      ),
    );
  }

  Widget _buildKitchenPaymentMethod(BuildContext context) {
    final currentYear = DateTime.now().year;
    return Card(
      padding: const EdgeInsetsDensity.all(padMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Method').medium,
          const DensityGap(gapXs),
          const Text('All transactions are secure and encrypted.').muted.small,
          const DensityGap(gapXl),
          const Text('Name on Card').medium,
          const DensityGap(gapSm),
          const TextField(
            placeholder: Text('John Doe'),
          ),
          const DensityGap(gapXl),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Card Number').medium,
                    const DensityGap(gapSm),
                    const TextField(
                      placeholder: Text('1234 5678 9012 3456'),
                    ),
                  ],
                ),
              ),
              const DensityGap(gapXl),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CVV').medium,
                    const DensityGap(gapSm),
                    const TextField(
                      placeholder: Text('123'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DensityGap(gapMd),
          const Text('Enter your 16-digit number.').muted,
          const DensityGap(gapLg),
          // [Month | Year]
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Month').medium,
                    const DensityGap(gapSm),
                    Select<String>(
                      placeholder: const Text('MM'),
                      itemBuilder: (context, item) => Text(item),
                      value: null,
                      onChanged: (value) {},
                      popup: SelectPopup.noVirtualization(
                          items: SelectItemList(
                        children: [
                          for (var i = 1; i <= 12; i++)
                            SelectItemButton(
                              value: i.toString().padLeft(2, '0'),
                              child: Text(i.toString().padLeft(2, '0')),
                            ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              const DensityGap(gapXl),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Year').medium,
                    const DensityGap(gapSm),
                    Select<String>(
                      placeholder: const Text('YYYY'),
                      itemBuilder: (context, item) => Text(item),
                      value: null,
                      onChanged: (value) {},
                      popup: SelectPopup.noVirtualization(
                          items: SelectItemList(
                        children: [
                          for (var i = 0; i < 12; i++)
                            SelectItemButton(
                              value: (currentYear + i).toString(),
                              child: Text((currentYear + i).toString()),
                            ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DensityGap(gapXl),
          const Divider(),
          const DensityGap(gapXl),
          const Text('Billing Address').medium,
          const DensityGap(gapXs),
          const Text('The billing address associated with your payment method')
              .muted
              .small,
          const DensityGap(gapMd),
          Checkbox(
            state: CheckboxState.checked,
            onChanged: (value) {},
            trailing: const Text('Same as shipping address'),
          ),
          const DensityGap(gapXl),
          const Divider(),
          const DensityGap(gapXl),
          const Text('Comments').medium,
          const DensityGap(gapSm),
          const TextArea(
            placeholder: Text('Add any additional comments'),
            expandableHeight: true,
            minHeight: 70,
          ),
          const DensityGap(gapLg),
          Row(
            children: [
              Button.primary(
                child: const Text('Submit'),
                onPressed: () {},
              ),
              const DensityGap(gapMd),
              Button.outline(
                child: const Text('Cancel'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenInputs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildKitchenMembers(context),
        const DensityGap(gapXl),
        _buildKitchenBadges(context),
        const DensityGap(gapXl),
        _buildKitchenChatBox(context),
        const DensityGap(gapXl),
        _buildKitchenPriceRange(),
        const DensityGap(gapXl),
        _buildKitchenSearch(),
        const DensityGap(gapXl),
        _buildKitchenURL(),
        const DensityGap(gapXl),
        _buildKitchenAIChat(),
        const DensityGap(gapXl),
        _buildKitchenMentions(),
      ],
    );
  }

  Widget _buildKitchenAppearanceSettings(BuildContext context) {
    return RadioGroup<bool>(
      value: true,
      onChanged: (value) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Two-factor authentication').medium,
                      const DensityGap(gapXs),
                      const Text('Verify via email or phone number.').muted.small,
                    ],
                  ),
                ),
                Button.primary(
                  style: const ButtonStyle.primary(
                    density: ButtonDensity.dense,
                  ),
                  child: const Text('Enable'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const DensityGap(gapMd),
          Card(
            child: Row(
              children: [
                const Icon(LucideIcons.badgeCheck).iconMutedForeground(),
                const DensityGap(gapSm),
                Expanded(
                  child: const Text('Your profile has been verified.').medium,
                ),
                const Icon(Icons.chevron_right).iconMutedForeground(),
              ],
            ),
          ),
          const DensityGap(gapXl),
          Divider(
            child: const Text('Appearance Settings').muted.small,
          ),
          const DensityGap(gapXl),
          const Text('Compute Environment').medium,
          const DensityGap(gapXs),
          const Text('Select the compute environment for your cluster.').muted.small,
          const DensityGap(gapMd),
          RadioCard(
            filled: true,
            value: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Kubernetes').medium,
                    const Spacer(),
                    const Radio(value: true),
                  ],
                ),
                const DensityGap(gapSm),
                const Text(
                  'Run GPU workloads on a K8s configured cluster. This is the default.',
                ).muted.small,
              ],
            ),
          ),
          const DensityGap(gapSm),
          RadioCard(
            filled: true,
            value: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Virtual Machine').medium,
                    const Spacer(),
                    const Radio(value: false),
                  ],
                ),
                const DensityGap(gapSm),
                const Text(
                  'Access a VM configured cluster to run workloads. (Coming soon)',
                ).muted.small,
              ],
            ),
          ),
          const DensityGap(gapXl),
          const Divider(),
          const DensityGap(gapXl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Number of GPUs').medium,
                    const DensityGap(gapXs),
                    const Text('You can add more later.').muted.small,
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  initialValue: '8',
                  inputFormatters: [
                    TextInputFormatters.digitsOnly(min: 0, max: 64),
                  ],
                  features: const [
                    InputFeature.incrementButton(),
                    InputFeature.decrementButton(),
                  ],
                ),
              )
            ],
          ),
          const DensityGap(gapXl),
          const Divider(),
          const DensityGap(gapXl),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Wallpaper Tinting').medium,
                    const DensityGap(gapXs),
                    const Text('Allow the wallpaper to be tinted.').muted.small,
                  ],
                ),
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenMembers(BuildContext context) {
    return DashedContainer(
        child: DensityContainerPadding(
      padding: const EdgeInsetsDensity.all(padLg),
      child: Column(
        children: [
          AvatarGroup.toLeft(
            gap: 2,
            offset: 0.7,
            children: const [
              Avatar(initials: 'ST'),
              Avatar(initials: 'JS'),
              Avatar(initials: 'MD'),
            ],
          ),
          const DensityGap(gapXl),
          const Text('No Team Members').small,
          const DensityGap(gapSm),
          const Text('Invite your team to collaborate on this project.').muted.small,
          const DensityGap(gapMd),
          Button(
            leading: const Icon(Icons.add),
            style: const ButtonStyle.primary(
              density: ButtonDensity.dense,
            ),
            onPressed: () {},
            child: const Text('Invite Members').small,
          ),
        ],
      ),
    ));
  }

  Widget _buildKitchenBadges(BuildContext context) {
    return RepaintBoundary(
      child: Row(
        children: [
          PrimaryBadge(
            leading: const Center(
              child: CircularProgressIndicator(
                onSurface: true,
                size: 10,
              ),
            ),
            child: const Text('Syncing').small,
          ),
          const DensityGap(gapSm),
          SecondaryBadge(
            leading: const Center(
              child: CircularProgressIndicator(
                size: 10,
              ),
            ),
            child: const Text('Updating').small,
          ),
          const DensityGap(gapSm),
          OutlineBadge(
            leading: const Center(
              child: CircularProgressIndicator(
                size: 10,
              ),
            ),
            child: const Text('Loading').small,
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenChatBox(BuildContext context) {
    return IntrinsicHeight(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        IconButton.outline(icon: const Icon(Icons.add), onPressed: () {}),
        const DensityGap(gapSm),
        Expanded(
          child: TextField(
            placeholder: const Text('Send a message...'),
            padding: const DirectionalEdgeInsetsDensity.only(
              start: padSm,
              end: padXs,
              top: 0,
              bottom: 0,
            ),
            features: [
              InputFeature.trailing(
                WidgetStatesProvider.boundary(
                  child: Tooltip(
                    tooltip: const TooltipContainer(child: Text('Voice Mode')),
                    child: IconButton.ghost(
                      icon: const Icon(LucideIcons.audioLines),
                      onPressed: () {},
                      shape: ButtonShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildKitchenPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Price Range').medium,
        const DensityGap(gapXs),
        const Text('Set your budget range (\$320 - \$800)').muted,
        const DensityGap(gapMd),
        Slider(
          value: const SliderValue.ranged(320, 800),
          min: 0,
          max: 1000,
          divisions: 20,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildKitchenSearch() {
    return TextField(
      placeholder: const Text('Search...'),
      features: [
        InputFeature.leading(const Icon(Icons.search).iconMutedForeground),
        InputFeature.trailing(const Text('12 Results').muted.small.medium),
      ],
    );
  }

  Widget _buildKitchenURL() {
    return TextField(
      placeholder: const Text('example.com'),
      features: [
        InputFeature.leading(const Text('https://').muted.small.medium),
        InputFeature.hint(
            popupBuilder:
                const TooltipContainer(child: Text('This is content in a tooltip'))),
      ],
    );
  }

  Widget _buildKitchenAIChat() {
    return TextField(
      minLines: 3,
      maxLines: 3,
      placeholder: const Text('Ask, Search, or Chat...'),
      features: [
        InputFeature.below(WidgetStatesProvider.boundary(
          child: Padding(
            padding: const EdgeInsetsDensity.only(top: padXl),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton.outline(
                      density: ButtonDensity.iconDense,
                      icon: const Icon(Icons.add),
                      onPressed: () {}),
                  const DensityGap(gapSm),
                  Builder(builder: (context) {
                    return Button(
                      style: const ButtonStyle.ghost(
                        density: ButtonDensity.dense,
                      ),
                      child: const Text('Auto'),
                      onPressed: () {
                        showDropdown(
                            context: context,
                            builder: (context) {
                              return DropdownMenu(
                                children: [
                                  MenuButton(
                                    child: const Text('Auto'),
                                    onPressed: (ctx) {},
                                  ),
                                  MenuButton(
                                    child: const Text('Agent'),
                                    onPressed: (ctx) {},
                                  ),
                                  MenuButton(
                                    child: const Text('Manual'),
                                    onPressed: (ctx) {},
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  }),
                  const Spacer(),
                  const Text('52% Used').muted.small.center(),
                  const DensityGap(gapSm),
                  const VerticalDivider(),
                  const DensityGap(gapSm),
                  IconButton.primary(
                    density: ButtonDensity.iconDense,
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildKitchenMentions() {
    return TextField(
      placeholder: const Text('@sunarya-thito'),
      features: [
        InputFeature.trailing(IconButton.primary(
          density: ButtonDensity.iconDense,
          size: ButtonSize.small,
          shape: ButtonShape.circle,
          icon: const Icon(Icons.check),
          onPressed: () {},
        )),
      ],
    );
  }

  List<Widget> _appBarActions(BuildContext context) {
    final theme = Theme.of(context);
    return [
      Semantics(
        link: true,
        linkUrl: Uri.tryParse(
          'https://github.com/sunarya-thito/shadcn_flutter',
        ),
        child: GhostButton(
          density: ButtonDensity.icon,
          onPressed: () {
            openInNewTab('https://github.com/sunarya-thito/shadcn_flutter');
          },
          child: FaIcon(
            FontAwesomeIcons.github,
            color: theme.colorScheme.secondaryForeground,
          ).iconLarge(),
        ),
      ),
      GhostButton(
        density: ButtonDensity.icon,
        onPressed: () {
          openInNewTab('https://pub.dev/packages/shadcn_flutter');
        },
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            theme.colorScheme.secondaryForeground,
            BlendMode.srcIn,
          ),
          child: FlutterLogo(
            size: 24 * theme.scaling,
          ),
        ),
      ),
    ];
  }

  AppBar _buildAppBar(EdgeInsets padding) {
    final theme = Theme.of(context);
    return AppBar(
      padding: padding,
      title: Basic(
        leading: FlutterLogo(
          size: 32 * theme.scaling,
        ),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('shadcn_flutter').textLarge().mono(),
            Gap(16 * theme.scaling),
            _buildFlavorTag(),
          ],
        ),
      ),
      trailing: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: 320 - 18,
            child: OutlineButton(
              onPressed: _showSearchBar,
              trailing:
                  const Icon(Icons.search).iconSmall().iconMutedForeground(),
              child: Row(
                spacing: 16,
                children: [
                  const Text('Search documentation...').muted().normal(),
                  const KeyboardDisplay.fromActivator(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyF, control: true),
                  ).xSmall.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
        Gap(8 * theme.scaling),
        ..._appBarActions(context),
      ],
    );
  }

  void _showSearchBar() {
    showCommandDialog(
      context: context,
      builder: (context, query) async* {
        for (final section in DocsPageState.sections) {
          final List<Widget> resultItems = [];
          for (final page in section.pages) {
            if (query == null ||
                page.title.toLowerCase().contains(query.toLowerCase())) {
              resultItems.add(CommandItem(
                title: Text(page.title),
                trailing: Icon(section.icon),
                onTap: () {
                  context.goNamed(page.name);
                },
              ));
            }
          }
          if (resultItems.isNotEmpty) {
            yield [
              CommandCategory(
                title: Text(section.title),
                children: resultItems,
              ),
            ];
          }
        }
      },
    );
  }

  Widget _buildFlavorTag() {
    String text = 'UKNOWN';
    Color color = Colors.green;
    switch (flavor) {
      case 'local':
        text = 'Local';
        color = Colors.red;
        break;
      case 'experimental':
        text = 'Experimental';
        color = Colors.orange;
        break;
      case 'release':
        text = getReleaseTagName();
        color = Colors.green;
        break;
    }
    return PrimaryBadge(
      onPressed: () {
        showDropdown(
          context: context,
          offset: const Offset(0, 8) * Theme.of(context).scaling,
          anchorAlignment: Alignment.bottomLeft,
          alignment: Alignment.topLeft,
          builder: (context) {
            return Card(
              child: Container(
                constraints: const BoxConstraints(minWidth: 180),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Build flavor').small().muted(),
                    const Gap(8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Gap(8),
                        Text(text),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Text(text),
    );
  }

  void _openDrawer(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    openSheet(
      context: context,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 400) * scaling,
          padding: const EdgeInsets.only(top: 32) * scaling,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size: 24 * scaling,
                  ),
                  Gap(18 * scaling),
                  const Text('shadcn_flutter').medium().mono(),
                  Gap(12 * scaling),
                  _buildFlavorTag(),
                  const Spacer(),
                  TextButton(
                    density: ButtonDensity.icon,
                    size: ButtonSize.small,
                    onPressed: () {
                      closeDrawer(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ).withPadding(left: 32 * scaling, right: 32 * scaling),
              Gap(32 * scaling),
              Expanded(
                child: FocusTraversalGroup(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                          bottom: 48,
                        ) *
                        scaling,
                    key: const PageStorageKey('sidebar'),
                    child: SidebarNav(children: [
                      for (var section in DocsPageState.sections)
                        SidebarSection(
                          header: Text(section.title),
                          children: [
                            for (var page in section.pages)
                              Semantics(
                                link: true,
                                linkUrl: Uri.tryParse(
                                  'https://sunarya-thito.github.io/shadcn_flutter${_goRouterNamedLocation(context, page.name)}',
                                ),
                                child: DocsNavigationButton(
                                  onPressed: () {
                                    if (page.tag ==
                                        ShadcnFeatureTag.workInProgress) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Work in Progress'),
                                            content: const Text(
                                                'This page is still under development. Please come back later.'),
                                            actions: [
                                              PrimaryButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }
                                    context.goNamed(page.name);
                                    closeDrawer(context);
                                  },
                                  selected: page.name == _pageName,
                                  child: Basic(
                                    trailing: page.tag?.buildBadge(context),
                                    trailingAlignment:
                                        AlignmentDirectional.centerStart,
                                    content: Text(page.title),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      position: OverlayPosition.left,
    );
  }

  String? _goRouterNamedLocation(BuildContext context, String name) {
    try {
      return '/#${GoRouter.of(context).namedLocation(name)}';
    } catch (e) {
      return null;
    }
  }

  Widget _buildOptionsPanel(MyAppState state, ColorScheme baseScheme,
      [bool padded = true]) {
    final radiusKey = _radiusOptions.entries
        .firstWhere((entry) => entry.value == radius,
            orElse: () => const MapEntry('Default', 0.5))
        .key;
    final densityKey = _densityOptions.entries
        .firstWhere((entry) => entry.value == density,
            orElse: () => const MapEntry('Default', Density.defaultDensity))
        .key;
    final scalingKey = _scalingOptions.entries
        .firstWhere((entry) => entry.value == scaling,
            orElse: () => const MapEntry('Default', 1.0))
        .key;
    final surfaceOpacityKey = _surfaceOpacityOptions.entries
        .firstWhere((entry) => entry.value == surfaceOpacity,
            orElse: () => const MapEntry('Solid', 1.0))
        .key;
    final surfaceBlurKey = _surfaceBlurOptions.entries
        .firstWhere((entry) => entry.value == surfaceBlur,
            orElse: () => const MapEntry('None', 0.0))
        .key;
    return Container(
      padding: padded ? const EdgeInsets.only(left: 8, right: 16) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Theme options').textLarge().semiBold(),
          const Gap(12),
          const Text('Theme mode').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: isDark ? 'dark' : 'light',
            onChanged: (value) {
              if (value == null) return;
              _updateThemeMode(state, value == 'dark');
            },
            itemBuilder: (context, item) => _selectRow(
              Icon(item == 'dark' ? Icons.dark_mode : Icons.light_mode,
                  size: 16),
              item == 'dark' ? 'Dark' : 'Light',
            ),
            placeholder: const Text('Theme mode'),
            popup: const SelectPopup(
              items: SelectItemList(
                children: [
                  SelectItemButton(
                    value: 'light',
                    child: Row(
                      children: [
                        Icon(Icons.light_mode, size: 16),
                        Gap(8),
                        Text('Light'),
                      ],
                    ),
                  ),
                  SelectItemButton(
                    value: 'dark',
                    child: Row(
                      children: [
                        Icon(Icons.dark_mode, size: 16),
                        Gap(8),
                        Text('Dark'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Base colors').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: baseKey,
            onChanged: (value) {
              if (value == null) return;
              _updateBase(state, value);
            },
            itemBuilder: (context, item) {
              final option = _baseSchemes.firstWhere((s) => s.id == item);
              return _selectRow(
                Icon(Icons.circle,
                    size: 12, color: _baseSwatchColor(option.id)),
                option.label,
              );
            },
            placeholder: const Text('Base color'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final option in _baseSchemes)
                    SelectItemButton(
                      value: option.id,
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              size: 12, color: _baseSwatchColor(option.id)),
                          const Gap(8),
                          Text(option.label),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Accent colors').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: accentKey,
            onChanged: (value) {
              if (value == null) return;
              _updateAccent(state, value);
            },
            itemBuilder: (context, item) {
              final option = _accentOptions.firstWhere((o) => o.id == item);
              final color = option.color ?? baseScheme.primary;
              return _selectRow(
                Icon(Icons.circle, size: 12, color: color),
                option.label,
              );
            },
            placeholder: const Text('Accent color'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final option in _accentOptions)
                    SelectItemButton(
                      value: option.id,
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: option.color ?? baseScheme.primary,
                          ),
                          const Gap(8),
                          Text(option.label),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Radius').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: radiusKey,
            onChanged: (value) {
              if (value == null) return;
              final nextRadius = _radiusOptions[value];
              if (nextRadius == null) return;
              _updateRadius(state, nextRadius);
            },
            itemBuilder: (context, item) =>
                _selectRow(const Icon(Icons.rounded_corner, size: 16), item),
            placeholder: const Text('Radius'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final entry in _radiusOptions.entries)
                    SelectItemButton(
                      value: entry.key,
                      child: Row(
                        children: [
                          const Icon(Icons.rounded_corner, size: 16),
                          const Gap(8),
                          Text(entry.key),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Density').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: densityKey,
            onChanged: (value) {
              if (value == null) return;
              final nextDensity = _densityOptions[value];
              if (nextDensity == null) return;
              _updateDensity(state, nextDensity);
            },
            itemBuilder: (context, item) =>
                _selectRow(const Icon(Icons.line_weight, size: 16), item),
            placeholder: const Text('Density'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final entry in _densityOptions.entries)
                    SelectItemButton(
                      value: entry.key,
                      child: Row(
                        children: [
                          const Icon(Icons.line_weight, size: 16),
                          const Gap(8),
                          Text(entry.key),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Scaling').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: scalingKey,
            onChanged: (value) {
              if (value == null) return;
              final nextScaling = _scalingOptions[value];
              if (nextScaling == null) return;
              _updateScaling(state, nextScaling);
            },
            itemBuilder: (context, item) =>
                _selectRow(const Icon(Icons.zoom_in, size: 16), item),
            placeholder: const Text('Scaling'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final entry in _scalingOptions.entries)
                    SelectItemButton(
                      value: entry.key,
                      child: Row(
                        children: [
                          const Icon(Icons.zoom_in, size: 16),
                          const Gap(8),
                          Text(entry.key),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Surface opacity').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: surfaceOpacityKey,
            onChanged: (value) {
              if (value == null) return;
              final nextOpacity = _surfaceOpacityOptions[value];
              if (nextOpacity == null) return;
              _updateSurfaceOpacity(state, nextOpacity);
            },
            itemBuilder: (context, item) =>
                _selectRow(const Icon(Icons.opacity, size: 16), item),
            placeholder: const Text('Surface opacity'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final entry in _surfaceOpacityOptions.entries)
                    SelectItemButton(
                      value: entry.key,
                      child: Row(
                        children: [
                          const Icon(Icons.opacity, size: 16),
                          const Gap(8),
                          Text(entry.key),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Gap(16),
          const Text('Surface blur').small().semiBold(),
          const Gap(8),
          Select<String>(
            value: surfaceBlurKey,
            onChanged: (value) {
              if (value == null) return;
              final nextBlur = _surfaceBlurOptions[value];
              if (nextBlur == null) return;
              _updateSurfaceBlur(state, nextBlur);
            },
            itemBuilder: (context, item) =>
                _selectRow(const Icon(Icons.blur_on, size: 16), item),
            placeholder: const Text('Surface blur'),
            popup: SelectPopup(
              items: SelectItemList(
                children: [
                  for (final entry in _surfaceBlurOptions.entries)
                    SelectItemButton(
                      value: entry.key,
                      child: Row(
                        children: [
                          const Icon(Icons.blur_on, size: 16),
                          const Gap(8),
                          Text(entry.key),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ColorScheme _baseScheme(String baseId, bool darkMode) {
    return _baseSchemes
        .firstWhere((option) => option.id == baseId)
        .forMode(darkMode);
  }

  String? _resolveBaseKey(ColorScheme scheme) {
    final bool darkMode = scheme.brightness == Brightness.dark;
    for (final base in _baseSchemes) {
      final baseScheme = base.forMode(darkMode);
      if (_matchesBase(scheme, baseScheme)) {
        return base.id;
      }
    }
    return null;
  }

  String _resolveAccentKey(ColorScheme scheme, ColorScheme baseScheme) {
    if (scheme.primary == baseScheme.primary &&
        scheme.primaryForeground == baseScheme.primaryForeground &&
        scheme.ring == baseScheme.ring) {
      return 'base';
    }
    for (final option in _accentOptions) {
      final color = option.color;
      if (color == null) continue;
      if (scheme.primary == color &&
          scheme.primaryForeground == color.getContrastColor() &&
          scheme.ring == color) {
        return option.id;
      }
    }
    return 'base';
  }

  bool _matchesBase(ColorScheme scheme, ColorScheme baseScheme) {
    return scheme.background == baseScheme.background &&
        scheme.foreground == baseScheme.foreground &&
        scheme.card == baseScheme.card &&
        scheme.cardForeground == baseScheme.cardForeground &&
        scheme.popover == baseScheme.popover &&
        scheme.popoverForeground == baseScheme.popoverForeground &&
        scheme.secondary == baseScheme.secondary &&
        scheme.secondaryForeground == baseScheme.secondaryForeground &&
        scheme.muted == baseScheme.muted &&
        scheme.mutedForeground == baseScheme.mutedForeground &&
        scheme.accent == baseScheme.accent &&
        scheme.accentForeground == baseScheme.accentForeground &&
        scheme.destructive == baseScheme.destructive &&
        scheme.border == baseScheme.border &&
        scheme.input == baseScheme.input &&
        scheme.chart1 == baseScheme.chart1 &&
        scheme.chart2 == baseScheme.chart2 &&
        scheme.chart3 == baseScheme.chart3 &&
        scheme.chart4 == baseScheme.chart4 &&
        scheme.chart5 == baseScheme.chart5;
  }

  void _applyScheme(MyAppState state) {
    final baseScheme = _baseScheme(baseKey, isDark);
    final accent =
        _accentOptions.firstWhere((option) => option.id == accentKey).color;
    final nextScheme = accent == null ? baseScheme : baseScheme.recolor(accent);
    setState(() {
      colorScheme = nextScheme;
    });
    if (applyDirectly) {
      state.changeColorScheme(nextScheme);
    }
  }

  void _updateThemeMode(MyAppState state, bool darkMode) {
    setState(() {
      isDark = darkMode;
    });
    _applyScheme(state);
  }

  void _updateBase(MyAppState state, String nextBase) {
    setState(() {
      baseKey = nextBase;
    });
    _applyScheme(state);
  }

  void _updateAccent(MyAppState state, String nextAccent) {
    setState(() {
      accentKey = nextAccent;
    });
    _applyScheme(state);
  }

  void _updateRadius(MyAppState state, double nextRadius) {
    setState(() {
      radius = nextRadius;
    });
    if (applyDirectly) {
      state.changeRadius(radius);
    }
  }

  void _updateDensity(MyAppState state, Density nextDensity) {
    setState(() {
      density = nextDensity;
    });
    if (applyDirectly) {
      state.changeDensity(density);
    }
  }

  void _updateScaling(MyAppState state, double nextScaling) {
    setState(() {
      scaling = nextScaling;
    });
    if (applyDirectly) {
      state.changeScaling(scaling);
    }
  }

  void _updateSurfaceOpacity(MyAppState state, double nextOpacity) {
    setState(() {
      surfaceOpacity = nextOpacity;
    });
    if (applyDirectly) {
      state.changeSurfaceOpacity(surfaceOpacity);
    }
  }

  void _updateSurfaceBlur(MyAppState state, double nextBlur) {
    setState(() {
      surfaceBlur = nextBlur;
    });
    if (applyDirectly) {
      state.changeSurfaceBlur(surfaceBlur);
    }
  }

  Widget _selectRow(Widget leading, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading,
        const Gap(8),
        Text(label),
      ],
    );
  }

  String _densityCode() {
    if (density == Density.compactDensity) return 'Density.compactDensity';
    if (density == Density.reducedDensity) return 'Density.reducedDensity';
    if (density == Density.spaciousDensity) return 'Density.spaciousDensity';
    return 'Density.defaultDensity';
  }

  String _schemeCode() {
    final baseName = '${isDark ? 'dark' : 'light'}${_title(baseKey)}';
    if (accentKey == 'base') {
      return 'ColorSchemes.$baseName';
    }
    return 'ColorSchemes.$baseName.$accentKey';
  }

  String buildCode() {
    final isDefaultScheme = isDark && baseKey == 'slate' && accentKey == 'base';
    final isDefaultTheme = isDefaultScheme &&
        radius == 0.5 &&
        density == Density.defaultDensity &&
        surfaceOpacity == 1.0 &&
        surfaceBlur == 0.0;
    final isDefaultScaling = scaling == 1.0;

    if (isDefaultTheme && isDefaultScaling) {
      return [
        'ShadcnApp(',
        '\t...',
        '\t// Everything is at default settings, no configuration needed',
        '\t...',
        ')',
      ].join('\n');
    }

    final lines = <String>[];
    lines.add('ShadcnApp(');
    lines.add('\t...');
    if (!isDefaultScaling) {
      lines.add('\tscaling: const AdaptiveScaling($scaling),');
    }

    final themeLines = <String>[];
    if (!isDefaultScheme) {
      themeLines.add('\t\tcolorScheme: ${_schemeCode()},');
    }
    if (radius != 0.5) {
      themeLines.add('\t\tradius: $radius,');
    }
    if (density != Density.defaultDensity) {
      themeLines.add('\t\tdensity: ${_densityCode()},');
    }
    if (surfaceOpacity != 1.0) {
      themeLines.add('\t\tsurfaceOpacity: $surfaceOpacity,');
    }
    if (surfaceBlur != 0.0) {
      themeLines.add('\t\tsurfaceBlur: $surfaceBlur,');
    }

    if (themeLines.isNotEmpty) {
      lines.add('\ttheme: ThemeData(');
      lines.addAll(themeLines);
      lines.add('\t),');
    }

    lines.add('\t...');
    lines.add(')');
    return lines.join('\n');
  }

  String _title(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  Color _baseSwatchColor(String baseId) {
    switch (baseId) {
      case 'slate':
        return Colors.slate.shade600;
      case 'zinc':
        return Colors.zinc.shade600;
      case 'gray':
        return Colors.gray.shade500;
      case 'neutral':
        return Colors.neutral.shade600;
      case 'stone':
        return Colors.stone.shade600;
      default:
        return Colors.slate.shade600;
    }
  }
}

class _ThemeSidebar extends StatefulWidget {
  const _ThemeSidebar({
    required this.sections,
    required this.pageName,
  });

  final List<ShadcnDocsSection> sections;
  final String pageName;

  @override
  State<_ThemeSidebar> createState() => _ThemeSidebarState();
}

class _ThemeSidebarState extends State<_ThemeSidebar> {
  String? _goRouterNamedLocation(BuildContext context, String name) {
    try {
      return '/#${GoRouter.of(context).namedLocation(name)}';
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      for (var section in widget.sections)
        SidebarSection(
          header: Text(section.title),
          children: [
            for (var page in section.pages)
              Semantics(
                link: true,
                linkUrl: Uri.tryParse(
                  'https://sunarya-thito.github.io/shadcn_flutter${_goRouterNamedLocation(context, page.name)}',
                ),
                child: DocsNavigationButton(
                  onPressed: () {
                    if (page.tag == ShadcnFeatureTag.workInProgress) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Work in Progress'),
                            content: const Text(
                                'This page is still under development. Please come back later.'),
                            actions: [
                              PrimaryButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    context.goNamed(page.name);
                  },
                  selected: page.name == widget.pageName,
                  child: Basic(
                    trailing: page.tag?.buildBadge(context),
                    trailingAlignment: AlignmentDirectional.centerStart,
                    content: Text(page.title),
                  ),
                ),
              ),
          ],
        ),
    ];
    return SidebarNav(children: children);
  }
}
