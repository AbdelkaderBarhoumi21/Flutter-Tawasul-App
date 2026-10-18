# Architecture

Tawasul uses a **feature-first MVC** structure. Every feature owns its
**M**odels, **V**iews and **C**ontrollers; everything shared lives in `core/`.

```text
lib/
├── main.dart                     # Loads .env, creates the Stream client, runs the app
├── app/
│   └── tawasul_app.dart          # ScreenUtil + theme + routing + StreamChatCore
├── core/                         # Shared, feature-agnostic code
│   ├── config/                   # AppConfig (.env values)
│   ├── constants/                # Colors, gradients, sizes, durations, strings
│   ├── extensions/               # BuildContext, Channel, DateTime, String, animation
│   ├── routing/                  # AppRoutes (names) + AppRouter (route factory)
│   ├── theme/                    # AppTheme, AppThemeColors (ThemeExtension), ThemeController
│   ├── utils/                    # appLogger
│   └── widgets/                  # Reusable UI kit (see below)
└── features/
    ├── auth/                     # Demo sign-in / sign-out
    │   ├── controllers/auth_controller.dart
    │   ├── models/demo_user.dart
    │   └── views/{pages,widgets}/
    ├── home/                     # Shell: header, tabs, floating nav bar
    ├── conversations/            # Channel list + stories
    ├── chat/                     # Messages, composer, presence, typing
    ├── contacts/                 # User list + "new chat" sheet
    ├── profile/                  # Profile, appearance, sign-out
    ├── calls/                    # Placeholder tab
    └── notifications/            # Placeholder tab
```

## Layers

| Layer | Lives in | Responsibility |
| --- | --- | --- |
| Model | `features/*/models` | Immutable data (`DemoUser`, `Story`, `HomeTab`). No logic. |
| Controller | `features/*/controllers` | Business logic and state: Stream queries, sending, pagination, busy flags. Exposes `ValueNotifier`/`ChangeNotifier`/Stream controllers. Has a `dispose()`. |
| View | `features/*/views/pages` and `views/widgets` | Renders state, forwards user intent to the controller. No Stream calls beyond reading reactive streams for display. |

Controllers are created by the page that owns them (usually
`late final _controller = XController(client: context.client);`) and disposed in
`dispose()`.

## Shared UI kit (`core/widgets`)

| Widget | Purpose |
| --- | --- |
| `AppAvatar` | Network avatar with initials fallback, online dot and story ring |
| `AppIconButton` | Soft rounded icon button |
| `GradientActionButton` | Brand-gradient circular primary action (new chat, send) |
| `PressableScale` | Tap feedback by scaling the child down |
| `AppPagedListView<T>` | Any Stream `PagedValueNotifier`: skeleton, pull-to-refresh, infinite scroll, empty and error states |
| `ListSkeleton` | Shimmer loading placeholder |
| `AppEmptyState` / `AppErrorView` / `AppLoadingIndicator` | Consistent state screens |
| `FadeIndexedStack` | Tab container that cross-fades and keeps page state |
| `ResponsiveCenter` | Caps content width on tablets |
| `ConnectionStatusBuilder` | Rebuilds on websocket status changes |

## Design system

- **Colors:** raw palette in `AppColors` and `AppGradients`. Widgets read semantic,
  theme-aware tokens through `context.colors` (`AppThemeColors`), so light and
  dark mode work automatically.
- **Typography:** Plus Jakarta Sans via `google_fonts`, defined once in
  `AppTheme`. Use `context.textTheme.*` and never hard-code font sizes.
- **Spacing and shape:** `AppSpacing`, `AppRadius`, `AppIconSize` and `AppDimensions` hold raw
  design values. Apply ScreenUtil at the call site: `AppSpacing.lg.w`,
  `AppRadius.md.r`.
- **Motion:** `AppDurations` plus the `staggeredEntrance()` / `popIn()`
  extensions keep every animation on the same timing.
- **Strings:** every user-facing string is in `AppStrings`, ready for localization.

## Responsiveness

`TawasulApp` initializes ScreenUtil with a phone canvas (390×844), or a tablet
canvas (834×1194) on devices whose shortest side is at least 600dp. This
keeps tablets from scaling phone UI up 2×. `ResponsiveCenter` also caps
content at 720px.

## Adding a feature

1. `features/<name>/models/`: immutable data classes.
2. `features/<name>/controllers/<name>_controller.dart`: logic, `dispose()`.
3. `features/<name>/views/pages/<name>_page.dart`: owns the controller.
4. `features/<name>/views/widgets/`: feature-only widgets. Promote a widget to
   `core/widgets` once a second feature needs it.
5. Register a route in `AppRoutes` + `AppRouter` if it is a full screen.
