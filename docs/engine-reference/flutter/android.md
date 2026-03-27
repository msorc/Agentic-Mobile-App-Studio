# Android Platform Guide

**Last verified:** 2026-03-27

## Overview

This document covers Android-specific development considerations for Flutter apps targeting Android phones, tablets, and Chromebooks.

## Platform Versions

| API Level | Android Version | Market Share | Support Status |
|-----------|----------------|--------------|----------------|
| API 34 | Android 14 | ~50% | Primary target |
| API 33 | Android 13 | ~25% | Fully supported |
| API 29-32 | Android 10-12 | ~20% | Minimum |
| API <29 | Android 9- | ~5% | Consider dropping |

Set minimum SDK in `android/app/build.gradle`: `minSdkVersion 21`

## Material Design

### Design System
- Follow Material Design 3 (Material You)
- Use Material 3 color scheme generation
- Support dynamic color (Android 12+)

### Navigation
- Support Android back gesture and navigation
- Implement proper back stack handling
- Consider edge-to-edge display and system UI insets

## Permissions

Declare permissions in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

For Android 13+ (API 33), runtime permission requests required:
```dart
final camera = await Permission.camera.request();
```

## App Icons and Assets

- Adaptive icons required for Android 8+
- Legacy icons for older devices
- Use Android Asset Studio for generation
- Support Play Store dynamic previews (short + long)

## Build and Deployment

### Build Commands
```bash
flutter build apk --release
flutter build apk --debug
flutter build appbundle --release  # For Play Store
```

### Signing
- Release signing required for Play Store
- Use `android/app/build.gradle` for signing config
- Consider Google Play App Signing

### Play Store Submission
- AAB format required (Android App Bundle)
- Screenshots: Phone (16:9 or 9:16), 7" tablet, 10" tablet
- Feature graphic: 1024x500
- Privacy policy required
- Data safety form required (App Content → Data Safety)

## Platform Channels

### Android-Specific APIs
```dart
// Platform channels for native Android features
const MethodChannel channel = MethodChannel('com.app/android');

// Use Android-specific implementations
import 'package:flutter/services.dart';
```

### Deep Links
Register in `android/app/src/main/AndroidManifest.xml`:
```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <category android:name="android.intent.category.BROWSABLE"/>
  <data android:scheme="https" android:host="myapp.com"/>
</intent-filter>
```

## Performance Considerations

- Use `android:hardwareAccelerated="true"` in manifest
- Profile with Android Studio Profiler
- Monitor `android:largeHeap="true"` sparingly
- Test on low-end devices (Android Go edition)

## Accessibility

- ContentDescription required for all images
- Support TalkBack screen reader
- Minimum touch target: 48dp
- Support font scaling

## Device Categories

### Phones
- Test portrait and landscape
- Test notch/cutout handling
- Test various screen densities (mdpi to xxxhdpi)

### Tablets
- Master-detail layouts
- Support landscape orientation
- Test multitasking (split screen)

### Chromebooks
- Keyboard and mouse support
- Variable window resizing
- Google Play store availability

## Testing

- Test on physical devices
- Use Android Emulator for quick iteration
- Test on Android Go edition devices
- Test with different GPU renders (ARM vs x86)

## Resources

- [Material Design Guidelines](https://m3.material.io/)
- [Flutter Android Platform](https://docs.flutter.dev/android)
- [Google Play Console](https://play.google.com/console)
