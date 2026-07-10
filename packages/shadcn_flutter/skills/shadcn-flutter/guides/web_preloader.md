# Web Preloader

Customize how your Flutter web application loads to provide a more professional first-impression.

## Initialization

Flutter web applications can take a few seconds to initialize the engine and download assets. A preloader ensures users see a styled loading state instead of a blank white screen.

### 1. Ensure Web Support
If your project doesn't have a `web` directory, add it:

```bash
flutter create . --platforms=web
```

### 2. Add the Preloader Script
Select a pre-made preloader script. For most cases, the **Standard Preloader** is recommended:

```html
<script src="https://cdn.jsdelivr.net/gh/sunarya-thito/shadcn_flutter@latest/web_loaders/standard.js"></script>
```

### 3. Configure index.html
Open your `web/index.html` file and paste the script inside the `<head>` tag:

```html
<!DOCTYPE html>
<html>
  <head>
    ...
    <script src="https://cdn.jsdelivr.net/gh/sunarya-thito/shadcn_flutter@latest/web_loaders/standard.js"></script>
    ...
  </head>
  <body>
    ...
  </body>
</html>
```

### 4. Run the Application
Start your application in Chrome to see the new loader in action:

```bash
flutter run -d chrome
```

## Custom Preloaders

You can create your own preloader by modifying the CSS and HTML in the `web_loaders` directory of the project. A typical preloader involves:
1. A small inline CSS block to style the loading animation.
2. A JavaScript callback that Flutter triggers once initialization is complete to hide the preloader.

> [!TIP]
> If you create a beautiful preloader, consider contributing it back to the community via a Pull Request in the [web_loaders](https://github.com/sunarya-thito/shadcn_flutter/tree/master/web_loaders) directory!
