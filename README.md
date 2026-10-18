# Tawasul

A modern real-time chat app built with Flutter and
[Stream Chat](https://getstream.io/chat/).

## Features

- Demo account sign-in
- Live conversation list with unread badges, presence and stories
- Chat with message grouping, day separators, delivery status, typing indicator and
  infinite history
- Contacts and a "new chat" sheet
- Light, dark and system themes
- Responsive layouts for phones and tablets (`flutter_screenutil`)
- Smooth motion throughout (`flutter_animate`)

## Getting started

```bash
cp .env.example .env      # then set STREAM_API_KEY
flutter pub get
flutter run
```

`.env` is git-ignored and bundled as an asset, so it must exist before you build.

## Project structure

The app uses feature-first MVC. See [docs/MVC_ARCHITECTURE.md](docs/MVC_ARCHITECTURE.md).

## Quality

```bash
flutter analyze
flutter test
```
