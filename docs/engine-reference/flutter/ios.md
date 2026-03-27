# iOS Platform Guide

**Last verified:** 2026-03-27

## Overview

This document covers iOS-specific development considerations for Flutter apps targeting iPhone, iPad, and iPod Touch.

## Platform Versions

| iOS Version | Market Share | Support Status |
|-------------|--------------|----------------|
| iOS 17+ | ~85% | Primary target |
| iOS 16 | ~10% | Minimum recommended |
| iOS 15 | ~4% | Consider dropping |
| Older | <1% | Not supported |

Set minimum iOS version in `ios/Podfile`: `platform :ios, '15.0'`

## Human Interface Guidelines

### Design Principles
- **Clarity**: Text legible at all sizes, icons precise and lucid
- **Deference**: UI enhances content, doesn't compete
- **Depth**: Visual layers and motion convey hierarchy and enable navigation

### Navigation
- Use `CupertinoApp` for iOS-native look and feel
- Respect safe areas (notch, Dynamic Island, home indicator)
- Support iOS gestures: edge swipe for back, pull to refresh

### Typography
- Use San Francisco system font
- Follow iOS type scale: Large Title (34pt), Title 1 (28pt), Body (17pt)
- Dynamic Type support required for accessibility

## Permissions

Required permissions must be declared in `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>App uses camera for photo capture</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>App accesses photos for profile images</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>App uses location for nearby features</string>
<key>NSMicrophoneUsageDescription</key>
<string>App uses microphone for voice input</string>
<key>NSFaceIDUsageDescription</key>
<string>App uses Face ID for authentication</string>
```

## App Icons and Assets

- Icon sizes: 1024x1024 (App Store), plus all @1x/@2x/@3x variants
- Use Asset Catalog (Assets.xcassets) for all images
- Support Dark Mode variants
- Consider iPad multitasking and split view

## Build and Deployment

### Build Commands
```bash
flutter build ios --release --no-codesign
flutter build ios --simulator --no-codesign
```

### Signing
- Requires Apple Developer Program membership
- Configure signing in Xcode or via `--export-options-plist`
- Use Fastlane for CI/CD automation

### App Store Submission
- Screenshots: 6.7" (required), 6.5" (required), 5.5" (optional)
- App preview videos: up to 3, 15-30 seconds each
- Privacy nutrition labels required (Data & Privacy sheet)
- Age rating questionnaire must be completed

## Platform Channels

### iOS-Specific APIs
```dart
// Cupertino widgets for iOS-native look
CupertinoButton, CupertinoTextField, CupertinoSwitch

// Platform channels for native features
const MethodChannel channel = MethodChannel('com.app/ios');
```

### URL Schemes
Register custom URL schemes in Info.plist:
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>myapp</string>
    </array>
  </dict>
</array>
```

## Performance Considerations

- Use `CupertinoApp` over `MaterialApp` for better iOS performance
- Lazy load heavy widgets
- Use `const` constructors aggressively
- Profile with Instruments (CPU, Memory, GPU)

## Accessibility

- VoiceOver support required for App Store compliance
- Semantic widgets with proper labels
- Support Dynamic Type (scaling text)
- Minimum touch target: 44x44 points

## Testing

- Test on physical devices (Simulator has limitations)
- Test on multiple iOS versions
- Test iPad layout (split view, multitasking)
- Test with accessibility features enabled

## Resources

- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Flutter iOS Platform](https://docs.flutter.dev/ios)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
