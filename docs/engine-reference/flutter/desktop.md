# Desktop Platform Guide

**Last verified:** 2026-03-27

## Overview

This document covers desktop-specific development considerations for Flutter apps targeting Windows, macOS, and Linux.

## Target Platforms

| Platform | Minimum Version | Support Status |
|----------|----------------|----------------|
| Windows | Windows 10+ | Primary on Windows |
| macOS | macOS 10.14+ | Primary on macOS |
| Linux | Ubuntu 18.04+ or equivalent | Community supported |

Enable desktop in Flutter:
```bash
flutter config --enable-linux-desktop
flutter config --enable-macos-desktop
flutter config --enable-windows-desktop
```

## Desktop Flutter

### Setup
```bash
flutter create --platforms=linux,macos,windows
flutter build linux --release
flutter build macos --release
flutter build windows --release
```

### Key Differences from Mobile
- Larger screen real estate
- Keyboard and mouse primary input
- Window management (resize, minimize, maximize)
- Native menu bars
- System-level integrations

## Window Management

### Basic Window Operations
```dart
import 'package:window_manager/window_manager.dart';

await windowManager.ensureInitialized();

WindowOptions windowOptions = WindowOptions(
  size: Size(1200, 800),
  minimumSize: Size(800, 600),
  center: true,
);
await windowManager.waitUntilReadyToShow(windowOptions, () async {
  await windowManager.show();
  await windowManager.focus();
});
```

### Window Manager Package
```yaml
dependencies:
  window_manager: ^0.3.0
```

## Keyboard and Mouse

### Keyboard Shortcuts
```dart
Shortcuts(
  shortcuts: {
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS): SaveIntent(),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ): QuitIntent(),
  },
  child: Actions(
    actions: {
      SaveIntent: CallbackAction(onInvoke: (_) => _save()),
      QuitIntent: CallbackAction(onInvoke: (_) => _quit()),
    },
    child: Focus(child: MyApp()),
  ),
)
```

### Mouse Events
```dart
GestureDetector(
  onTapDown: (details) { /* handle click */ },
  onSecondaryTap: (details) { /* context menu */ },
  child: ...,
)
```

### Context Menus
```dart
 CallbackShortcuts(
   bindings: {
     SingleActivator(LogicalKeyboardKey.contextMenu): () => _showContextMenu(),
   },
   child: child,
 )
```

## System Integration

### Menu Bar (macOS)
```dart
import 'package:menubar/menubar.dart';

setApplicationMenu([
  Submenu(label: 'File', children: [
    MenuItem(label: 'New', onClicked: () => newFile()),
    MenuItem(label: 'Open...', onClicked: () => openFile()),
    MenuItem.separator(),
    MenuItem(label: 'Exit', onClicked: () => exit()),
  ]),
  Submenu(label: 'Edit', children: [
    MenuItem(label: 'Undo', onClicked: () => undo()),
    MenuItem(label: 'Redo', onClicked: () => redo()),
  ]),
]);
```

### System Tray
```yaml
dependencies:
  system_tray: ^2.0.0
```

### Notifications
```dart
import 'package:local_notifier/local_notifier.dart';

final notification = LocalNotification(
  title: 'App Name',
  body: 'Notification text',
);
await notification.show();
```

### File Dialogs
```dart
import 'package:file_picker/file_picker.dart';

String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
List<String>? selectedFiles = await FilePicker.platform.pickFiles(
  type: FileType.custom,
  allowedExtensions: ['json', 'txt'],
).then((result) => result?.paths);
```

### Drag and Drop
```dart
DragTarget<Object>(
  onAcceptWithDetails: (details) {
    // Handle dropped object
  },
  builder: (context, candidateData, rejectedData) {
    return MyDropZone();
  },
)
```

## Window Communication

### Multiple Windows
```yaml
dependencies:
  desktop_multi_window: ^0.2.0
```

## Performance Considerations

### Desktop-Specific
- Lazy load heavy content
- Use isolates for heavy computation
- Profile with Dart DevTools (CPU, Memory)
- Native menu bars over custom UI (performance)

### Memory
- Desktop apps typically have more memory available
- Still use efficient data structures
- Dispose controllers and streams

## Desktop Widgets

### Adaptive Layouts
```dart
Widget build(BuildContext context) {
  if (kIsLinux || kIsMacOS || kIsWindows) {
    return DesktopLayout();
  }
  return MobileLayout();
}
```

### Scrollbars
Desktop apps should show scrollbars:
```dart
Scrollbar(
  controller: _scrollController,
  child: ListView.builder(
    controller: _scrollController,
    itemCount: 1000,
    itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  ),
)
```

## Accessibility

- Keyboard navigation essential
- Focus indicators
- Screen reader support (especially macOS)
- High contrast support

## Native Features

### macOS-Specific
- AppDelegate.swift for native hooks
- Platform channels for macOS APIs
- Menu bar integration
- Touch Bar support (if applicable)

### Windows-Specific
- Win32 API access via FFI
- Registry access
- Windows-specific platform channels

### Linux-Specific
- X11 and Wayland support
- D-Bus for system integration
- Linux-specific platform channels

## Distribution

### macOS
```bash
# Create .app bundle
flutter build macos

# Or create DMG with additional tooling
```

### Windows
```bash
# MSIX for Microsoft Store
flutter build windows

# Or traditional .exe with additional tooling
```

### Linux
```bash
flutter build linux
# Produces executable in build/linux/x64/release/bundle/
```

## Resources

- [Flutter Desktop](https://docs.flutter.dev/desktop)
- [Desktop plugin docs](https://flutter.dev/desktop)
- [Window Manager package](https://pub.dev/packages/window_manager)
