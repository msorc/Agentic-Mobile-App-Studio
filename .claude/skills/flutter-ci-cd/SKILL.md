---
name: flutter-ci-cd
description: "CI/CD pipeline setup for Flutter apps across iOS, Android, Web, and Desktop platforms. Covers GitHub Actions, Fastlane, and codemagic."
argument-hint: "[platform: ios|android|web|desktop|all]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Flutter CI/CD

Setup and configuration for continuous integration and deployment
pipelines for Flutter apps across all target platforms.

---

## GitHub Actions

### Basic CI Workflow

Create `.github/workflows/flutter-ci.yml`:

```yaml
name: Flutter CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'
      - run: flutter pub get
      - run: flutter analyze --no-fatal-infos

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3

  build-web:
    runs-on: ubuntu-latest
    needs: analyze
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter build web
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

### iOS CI (macOS required)

```yaml
  build-ios:
    runs-on: macos-latest
    needs: analyze
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter build ios --simulator --no-codesign
```

### Android CI

```yaml
  build-android:
    runs-on: ubuntu-latest
    needs: analyze
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter build apk --debug
      - uses: actions/upload-artifact@v4
        with:
          name: apk
          path: build/app/outputs/flutter-apk/app-debug.apk
```

### Desktop CI

```yaml
  build-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter config --enable-linux-desktop
      - run: flutter pub get
      - run: flutter build linux --release

  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter build windows --release

  build-macos:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter build macos --release
```

---

## Fastlane (iOS & Android)

### Setup

```bash
cd ios && fastlane init
cd ../android && fastlane init
```

### iOS Fastfile

```ruby
# ios/fastlane/Fastfile
default_platform(:ios)

platform :ios do
  desc "Build iOS for testing"
  lane :build_test do
    increment_build_number(
      xcodeproj: "Runner.xcodeproj"
    )
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      configuration: "Debug"
    )
  end

  desc "Build iOS for App Store"
  lane :build_prod do
    api_key = app_store_connect_api_key
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      configuration: "Release",
      export_method: "app-store",
      api_key: api_key
    )
  end

  desc "Deploy to App Store"
  lane :deploy do
    build_prod
    upload_to_app_store(
      skip_waiting_for_build_processing: true
    )
  end
end
```

### Android Fastfile

```ruby
# android/fastlane/Fastfile
default_platform(:android)

platform :android do
  desc "Build Android APK"
  lane :build_apk do
    gradle(
      task: "assemble",
      flavor: :debug,
      build_type: "debug"
    )
  end

  desc "Build Android App Bundle"
  lane :build_aab do
    gradle(
      task: "bundle",
      flavor: :prod,
      build_type: "release"
    )
  end

  desc "Deploy to Play Store"
  lane :deploy do
    build_aab
    upload_to_play_store(
      track: "production",
      aab: "../build/app/outputs/bundle/prodRelease/app-prod-release.aab"
    )
  end
end
```

---

## Codemagic (Alternative CI)

```yaml
# codemagic.yaml
workflows:
  flutter-workflow:
    name: Flutter Workflow
    max_build_duration: 60
    environment:
      flutter: stable
      xcode: latest
      cocoapods: default
    scripts:
      - name: Get dependencies
        script: flutter pub get
      - name: Analyze
        script: flutter analyze
      - name: Test
        script: flutter test
      - name: Build iOS
        script: flutter build ios --release --no-codesign
        env:
          CM_CERTIFICATE: $CM_CERTIFICATE
          CM_CERTIFICATE_PASSWORD: $CM_CERTIFICATE_PASSWORD
          CM_PROVISIONING_PROFILE: $CM_PROVISIONING_PROFILE
    artifacts:
      - build/ios/iphone/Build/Products/*.app
      - build/app/outputs/apk/**/*.apk
```

---

## Environment Variables

### Required Secrets

| Secret | Platform | Description |
|--------|----------|-------------|
| `APP_STORE_CONNECT_API_KEY` | iOS | App Store Connect API key |
| `ANDROID_KEYSTORE` | Android | Base64 encoded keystore |
| `ANDROID_KEYSTORE_PASSWORD` | Android | Keystore password |
| `ANDROID_KEY_PASSWORD` | Android | Key password |
| `ANDROID_SERVICE_ACCOUNT` | Android | GCP service account JSON |

### GitHub Secrets Setup
1. Go to Settings → Secrets and variables → Actions
2. Add each secret with appropriate value
3. Reference in workflow: `${{ secrets.SECRET_NAME }}`

---

## Deployment Targets

### Web Deployment
- **Firebase Hosting**: `firebase deploy`
- **Vercel**: `vercel --prod`
- **Netlify**: `netlify deploy --prod`
- **GitHub Pages**: `peaceiris/actions-gh-pages`

### iOS Deployment
1. Build with Fastlane or GitHub Actions
2. Upload to App Store Connect
3. Submit for review via Fastlane or manually

### Android Deployment
1. Build AAB with Fastlane or GitHub Actions
2. Upload to Play Console via Fastlane or `gsutil`
3. Submit for review

### Desktop Deployment
- **Linux**: .deb/.rpm packages, snapcraft
- **Windows**: .exe installer, MSIX
- **macOS**: .dmg, .pkg, App Store

---

## Quality Gates

### Pre-merge Requirements
- [ ] `flutter analyze` passes (no errors)
- [ ] All unit tests pass
- [ ] All widget tests pass
- [ ] Code coverage > 70%

### Pre-deploy Requirements
- [ ] All integration tests pass
- [ ] All platform builds succeed
- [ ] No critical security issues
- [ ] Performance benchmarks met
