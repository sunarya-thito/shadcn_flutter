## [0.0.55]

### Added

- Initial release, split out of `shadcn_flutter` when that package dropped its
  `skeletonizer` dependency.
- `SkeletonizerLayer`, which configures skeletonizer's pulse from the ambient
  shadcn `ThemeData`, and `SkeletonTheme` to override it.
- `SkeletonExtension`: `asSkeleton`, `asSkeletonSliver`, `ignoreSkeleton` and
  `excludeSkeleton` on any widget.
- Re-exports of `Bone`, `BoneMock`, `Skeleton`, `Skeletonizer`,
  `SkeletonizerConfig`, `SkeletonizerConfigData` and the painting effects.

### Changed

- `ShadcnSkeletonizerConfigLayer` is now `SkeletonizerLayer`. It reads
  `Theme.of(context)` itself instead of taking a `ThemeData`, and its `theme:`
  argument is a `SkeletonTheme` like every other shadcn component.
- `ShadcnApp` no longer installs the skeleton configuration. Add
  `surfaceBuilder: (context, child) => SkeletonizerLayer(child: child)`. Use
  `surfaceBuilder` rather than `builder` so overlays are covered too.
- Requires `skeletonizer` 3.0.0. If you also depend on it directly, bump it to
  `^3.0.0` and pass `effectResolver` instead of the deprecated `effect` to
  `SkeletonizerConfigData`.
