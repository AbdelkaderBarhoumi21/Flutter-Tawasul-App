<div align="center">

# Tawasul

**A modern, real-time chat app built with Flutter and Stream Chat.**

*Tawasul (تواصل) means "communication" in Arabic.*

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.11+-0175C2?logo=dart&logoColor=white)
![Stream Chat](https://img.shields.io/badge/Stream_Chat-9.x-005FFF)
![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS-lightgrey)

</div>

---

## Overview

Tawasul is a messaging app with live conversations, presence, typing
indicators and a polished, animated interface. It runs on phones and tablets,
in light and dark mode. The code uses feature-first MVC and a shared design
system, so new features are easy to add.

## Features

### Messaging

- **Real-time chat** powered by [Stream Chat](https://getstream.io/chat/)
- **Grouped bubbles:** consecutive messages from the same sender are grouped,
  and only the last one shows its time
- **Day separators** (`Today`, `Yesterday`, weekday or date)
- **Delivery status** on your own messages (sending, sent, failed)
- **Live typing indicator** with animated dots
- **Presence:** online dot, "last seen", member count in groups
- **Infinite history:** older messages load as you scroll up
- **Automatic read receipts** when you open a conversation

### Conversations and contacts

- Live conversation list with unread badges, last message preview and
  relative timestamps
- Stories bar with gradient rings
- Contact list with online status
- **New chat** bottom sheet that opens or creates a one-to-one conversation
- Pull-to-refresh, shimmer loading and friendly empty and error states

### Experience

- **Light, dark and system themes**, switchable from the profile screen
- **Responsive** on phones (portrait and landscape) and tablets, using
  `flutter_screenutil`, with a capped content width on large screens
- **Smooth motion** throughout:
  - staggered list entrances
  - message pop-in
  - an animated send button
  - tab cross-fades
  - a shared avatar transition into the profile
  - tap-to-shrink feedback

## Tech stack

| Purpose | Package |
| --- | --- |
| Chat backend | [`stream_chat_flutter_core`](https://pub.dev/packages/stream_chat_flutter_core) |
| Responsive sizing | [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil) |
| Animations | [`flutter_animate`](https://pub.dev/packages/flutter_animate) |
| Typography | [`google_fonts`](https://pub.dev/packages/google_fonts) (Plus Jakarta Sans) |
| Image caching | [`cached_network_image`](https://pub.dev/packages/cached_network_image) |
| Dates | [`jiffy`](https://pub.dev/packages/jiffy) |
| Configuration | [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) |
| Logging | [`logger`](https://pub.dev/packages/logger) |

## Architecture

Tawasul uses a **feature-first MVC** structure. Each feature owns its
**M**odels, **V**iews and **C**ontrollers. Everything shared lives in `core/`.

```text
lib/
├── main.dart                 # Loads .env, creates the Stream client
├── app/                      # Root widget: ScreenUtil, theme, routing
├── core/
│   ├── config/               # Environment values
│   ├── constants/            # Colors, sizes, durations, strings
│   ├── extensions/           # Context, Channel, DateTime, String, animations
│   ├── routing/              # Route names and route factory
│   ├── theme/                # Material 3 theme + semantic color tokens
│   ├── utils/                # Logger
│   └── widgets/              # Reusable UI kit
└── features/
    ├── auth/                 # models/ controllers/ views/
    ├── home/
    ├── conversations/
    ├── chat/
    ├── contacts/
    ├── profile/
    ├── calls/
    └── notifications/
```

- **Models:** immutable data classes, with no logic.
- **Controllers:** business logic and state (Stream queries, sending,
  pagination, loading flags), always with `dispose()`.
- **Views:** render state and pass user actions to the controller.

The full guide covers the design system and how to add a feature:
[docs/MVC_ARCHITECTURE.md](docs/MVC_ARCHITECTURE.md).

## Getting started

### Prerequisites

- Flutter SDK with Dart **3.11** or newer
- A free [Stream](https://getstream.io/) account and API key
- Android Studio or Xcode for a device or emulator

### Setup

```bash
# 1. Clone
git clone https://github.com/AbdelkaderBarhoumi21/Flutter-Tawasul-App.git
cd Flutter-Tawasul-App

# 2. Configure the environment
cp .env.example .env
# then open .env and set STREAM_API_KEY

# 3. Install and run
flutter pub get
flutter run
```

> `.env` is git-ignored but bundled as an asset, so it **must exist before you
> build**.

### Demo accounts

The sign-in screen lists pre-made demo users. They sign in with Stream
**development tokens**, so enable *Disable Auth Checks* for your app in the
Stream dashboard. This is for development only. Use server-issued tokens in
production.

## Development

```bash
flutter analyze   # strict lint rules, see analysis_options.yaml
flutter test      # unit and widget tests
dart format lib test
```

## Roadmap

- [ ] Voice and video calls
- [ ] Image and file attachments
- [ ] Push notifications
- [ ] Real authentication (Firebase)
- [ ] Message search
- [ ] Localization (Arabic / English)

## Author

**Abdelkader Barhoumi**: [GitHub](https://github.com/AbdelkaderBarhoumi21)
