# Introduction

A cohesive shadcn/ui ecosystem for Flutter—components, theming, and tooling—ready to ditch Material and Cupertino.

## Overview

Welcome to **shadcn_flutter**, a cohesive UI ecosystem built on the shadcn/ui design system for Flutter applications across mobile, web, and desktop. Rather than a one-to-one design-system port, this project focuses on delivering a consistent, production-ready experience that feels at home on every platform.

This ecosystem provides a wide range of customizable and responsive components, primitives, and theming aligned with modern shadcn/ui patterns. Whether you're building a mobile app, a sleek web dashboard, or a desktop productivity tool, our components are designed to help you ship professional, polished UIs quickly—without relying on Material or Cupertino.

## Features

- **84+ components** and growing!
- **Standalone ecosystem**: no Material or Cupertino requirement; optional interop when needed.
- **Design Tokens**: Full support for shadcn/ui design tokens and the high-quality **New York** theme.
- **Incremental Adoption**: Works inside `MaterialApp` and `CupertinoApp`; mix and match while you migrate.
- **Multi-platform**: First-class support across Android, iOS, Web, macOS, Windows, and Linux.
- **Typography Extensions**: Various widget extensions for semantic typography.
- **Performance**: Optimized for WebAssembly (WASM).

## FAQ

### Does this support GoRouter?
Yes, it does. You can use GoRouter with `shadcn_flutter` seamlessly.

### Can I use this in my project?
Yes! It is free to use for personal and commercial projects. No attribution is required.

### Can I use this with Material/Cupertino Widgets?
Yes. If your app already uses Material or Cupertino, `shadcn_flutter` plays nicely with both. You can drop components into existing apps and adopt the ecosystem incrementally. See the [Interop Guide](./interop.md) for more.

### Can I configure the style (Default/New York)?
Currently, this package only supports the **New York** style.

## Important Notes

> [!WARNING]
> This package is still in active development. Please be cautious when using it in large-scale production environments as breaking changes may occur.

> [!IMPORTANT]
> This package is a community-driven project and is not officially affiliated with Shadcn/UI.
