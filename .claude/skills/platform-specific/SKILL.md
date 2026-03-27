---
name: platform-specific
description: "Platform-specific considerations for iOS, Android, Web, and Desktop Flutter apps. Covers submission requirements, native features, and platform nuances."
argument-hint: "[platform: ios|android|web|desktop]"
user-invocable: true
allowed-tools: Read, Glob, Grep
---

# Platform-Specific Guide

Covers submission requirements, native features, and platform nuances for
iOS, Android, Web, and Desktop Flutter applications.

---

## iOS

### App Store Submission
- **App Icon**: 1024x1024 PNG (no alpha)
- **Screenshots**: Required for all sizes (6.7", 6.5", 5.5", iPad, Mac)
- **App Store Connect**: App description, keywords, privacy policy (required)
- **Minimum iOS version**: Set in `ios/Podfile` and `pubspec.yaml`
- **Bitcode**: Disabled by default in Flutter (not needed)

### Native Features
- **Sign in with Apple**: Use `sign_in_with_apple` package
- **Push Notifications**: `firebase_messaging` or `apns` package
- **In-App Purchases**: `in_app_purchases` package
- **Face ID / Touch ID**: `local_auth` package
- **Camera / Photos**: `image_picker` package

### Platform Nuances
- Safe area handling: `MediaQuery.of(context).padding`
- Notch/Dynamic Island: `SafeArea` widget, `CupertinoPageScaffold`
- Back gesture: Handled automatically, customize with `WillPopScope`
- App switching: Preserve state in `didChangeAppLifecycleState`

### Common Issues
- App crashes on iOS 17: Check `Cupertino` widget compatibility
- Navigation bar styling: iOS prefers `CupertinoNavigationBar`
- Scrolling physics: iOS has bounce/overscroll behavior

---

## Android

### Play Store Submission
- **App Icon**: 512x512 PNG (with alpha)
- **Screenshots**: Phone (16:9 or taller), 7" tablet, 10" tablet
- **AAB format**: `flutter build appbundle` for Play Store
- **Signing**: Configure `key.properties` for release
- **Privacy Policy**: Required in Play Store listing

### Native Features
- **Google Sign-In**: `google_sign_in` package
- **Firebase**: `firebase_core`, `firebase_auth`, `cloud_firestore`
- **Google Play Services**: `google_play_services` package
- **Biometric Auth**: `local_auth` package
- **Camera / Gallery**: `image_picker` package

### Platform Nuances
- Material Design 3: Enable with `useMaterial3: true`
- Back button: Handle with `PopScope` (replaces `WillPopScope`)
- Navigation bar: System UI overlay style with `SystemChrome`
- Edge-to-edge: `enableEdgeToEdge()` in `WidgetsFlutterBinding.ensureInitialized()`

### Common Issues
- `minSdkVersion` conflicts with plugins
- ProGuard/R8 rules for release builds
- Keystore lost: Cannot update app without new keystore
- Dark mode: Material 3 handles automatically

---

## Web

### Deployment
- **Build**: `flutter build web`
- **Output**: `build/web/` directory
- **Hosting**: Firebase Hosting, Vercel, Netlify, GitHub Pages, any static host
- **PWA**: Service worker and manifest for installability

### PWA Requirements
```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/
    - manifest.json  # if custom
```

### SEO Considerations
- Semantic HTML: Use proper heading hierarchy (h1, h2, etc.)
- Meta tags: Title, description in `web/index.html`
- Routing: `go_router` handles deep links correctly
- Sitemap: Generate for search engines

### Platform Nuances
- No platform channels for some native features
- `kIsWeb` check for web-specific code
- Canvas vs HTML renderer: Default is CanvasKit (faster, larger)
- Browser compatibility: Test on Chrome, Firefox, Safari, Edge

### Common Issues
- CORS: API endpoints must allow cross-origin requests
- Local storage: `shared_preferences` works but has size limits
- Deep linking: Configure `baseUrl` in `go_router`

---

## Desktop (Linux/Windows/macOS)

### Build Commands
```bash
flutter build linux
flutter build windows
flutter build macos
```

### Desktop-Specific
- **Window management**: `window_manager` package
- **Menu bars**: `menu_bar` package or native menus
- **Keyboard shortcuts**: `Shortcuts` + `Actions` widgets
- **Drag and drop**: `desktop_drop` package

### Linux
- GTK-based rendering
- `.deb`, `.rpm` for distribution
- Snapcraft for snap packages

### Windows
- Win32-based (or GTK on newer versions)
- `.exe` installer, MSIX for Microsoft Store
- `nsis` or `inno` for custom installers

### macOS
- AppKit-based
- `.app` bundle, `.dmg` for distribution
- Code signing and notarization for App Store

### Common Issues
- Native library linking: Ensure correct `LD_LIBRARY_PATH`
- Window sizing: Set `minSize` and `maxSize` constraints
- Keyboard focus: May need `FocusNode` management

---

## Cross-Platform Considerations

### Feature Detection
```dart
import 'dart:io' show Platform;

if (Platform.isIOS) {
  // iOS-specific code
} else if (Platform.isAndroid) {
  // Android-specific code
}
// Platform.isFuchsia also available
```

### Platform Channels
For native features not covered by packages:
```dart
// Dart side
static const channel = MethodChannel('com.example.app/native');
final result = await channel.invokeMethod('getNativeData');
```

### Responsive vs Platform-Specific
- **Use responsive layouts** for screen size differences
- **Use platform-specific code** for OS conventions and native features
