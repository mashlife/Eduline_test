# Eduline

# Flutter Multi-Platform Application

A Flutter application with comprehensive multi-platform support for Windows, iOS, Linux, Android, and macOS.

## Features

- 🚀 Cross-platform compatibility (Windows, iOS, Linux, Android, macOS)
- 🎨 Rive animations integration
- 📱 Native platform optimizations
- 🔧 Platform-specific configurations

## Supported Platforms

- **iOS** - Native iOS mobile application  
- **Android** - Native Android mobile application


## Prerequisites

Before running this application, make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)

### Platform-specific requirements:


#### iOS
- Xcode 12.0 or later
- iOS 11.0 or later
- macOS for development

#### Android
- Android Studio
- Android SDK (API level 21 or higher)


## Dependencies

This project uses the following key dependencies:

- **rive_common** - For Rive animations across all platforms
- **provider** - For state management across Apple platforms


## Project Structure

```
├── android/                 # Android-specific code
├── ios/                     # iOS-specific code
├── linux/                   # Linux-specific code
├── macos/                   # macOS-specific code
├── windows/                 # Windows-specific code
├── lib/                     # Dart code (shared across platforms)
├── test/                    # Unit and widget tests
└── pubspec.yaml            # Project dependencies and metadata
```

## Acknowledgments

- Mushfiq Rahaman - [@mashlife](https://github.com/mashlife)
