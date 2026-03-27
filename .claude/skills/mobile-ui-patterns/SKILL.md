---
name: mobile-ui-patterns
description: "Reference guide for Flutter widget patterns across mobile, web, and desktop. Covers responsive layouts, platform-specific widgets, and common patterns."
argument-hint: "[no arguments - reference skill]"
user-invocable: true
allowed-tools: Read, Glob, Grep
---

# Mobile UI Patterns

Reference guide for Flutter widget patterns across iOS, Android, Web, and Desktop.

---

## Core Widget Categories

### Navigation
| Pattern | Use Case | Key Widgets |
|---------|----------|-------------|
| Bottom Navigation | Primary navigation (3-5 items) | `BottomNavigationBar`, `NavigationBar` |
| Top Navigation | Settings, search, user profile | `AppBar`, `SliverAppBar` |
| Tab Navigation | Within a feature section | `TabBar`, `TabBarView` |
| Drawer | Less frequent destinations | `Drawer`, `NavigationDrawer` |
| Rail | Desktop/tablet primary nav | `NavigationRail` |

### Layout
| Pattern | Use Case | Key Widgets |
|---------|----------|-------------|
| List Detail | Master-detail on larger screens | `ListView` + detail pane |
| Card Grid | Browseable content | `GridView`, `Card` |
| Stack | Overlapping content | `Stack`, `IndexedStack` |
| Scrollable | Long content | `SingleChildScrollView`, `CustomScrollView` |

### Input
| Pattern | Use Case | Key Widgets |
|---------|----------|-------------|
| Forms | Data entry | `Form`, `TextFormField`, `DropdownButtonFormField` |
| Buttons | Actions | `ElevatedButton`, `FilledButton`, `TextButton`, `IconButton` |
| Toggles | Binary choices | `Switch`, `Checkbox`, `Radio`, `SegmentedButton` |
| Sliders | Range selection | `Slider`, `RangeSlider` |

### Feedback
| Pattern | Use Case | Key Widgets |
|---------|----------|-------------|
| Snackbars | Brief messages | `SnackBar` |
| Dialogs | Confirmations | `AlertDialog`, `Dialog` |
| Bottom Sheets | Contextual actions | `BottomSheet`, `ModalBottomSheet` |
| Loading | Async states | `CircularProgressIndicator`, `LinearProgressIndicator` |

---

## Platform-Specific Patterns

### iOS (Cupertino)
- Use `CupertinoApp` for iOS-native look
- `CupertinoNavigationBar`, `CupertinoTabBar`
- `CupertinoTextField`, `CupertinoButton`
- `CupertinoPageScaffold` for page structure
- Handle safe areas: `MediaQuery.of(context).padding`

### Android (Material)
- Use `MaterialApp` with `useMaterial3: true`
- `Scaffold` with `AppBar`
- Material 3 components: `FilledButton`, `NavigationBar`
- Handle system UI: `SystemChrome.setSystemUIOverlayStyle`

### Web
- Responsive breakpoints: Mobile (<600), Tablet (600-900), Desktop (>900)
- `LayoutBuilder` for adaptive layouts
- `MouseRegion` for hover states
- PWA meta tags in `index.html`
- Proper `Semantics` for screen readers

### Desktop (Linux/Windows/macOS)
- `WindowManager` for window sizing
- Keyboard shortcuts: `Shortcuts` + `Actions` widgets
- Menu bars: `MenuBar`, `Submenu`
- Drag and drop: `Draggable`, `DragTarget`

---

## Responsive Layout Patterns

### Breakpoint System
```dart
enum ScreenSize { mobile, tablet, desktop }

ScreenSize getScreenSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return ScreenSize.mobile;
  if (width < 900) return ScreenSize.tablet;
  return ScreenSize.desktop;
}
```

### Adaptive Scaffold Pattern
```dart
Widget build(BuildContext context) {
  switch (getScreenSize(context)) {
    case ScreenSize.mobile:
      return mobileLayout;
    case ScreenSize.tablet:
      return tabletLayout;
    case ScreenSize.desktop:
      return desktopLayout;
  }
}
```

### List-Detail Pattern (Desktop)
```dart
Row(
  children: [
    SizedBox(width: 300, child: listView),
    const VerticalDivider(width: 1),
    Expanded(child: detailView),
  ],
)
```

---

## State Management Patterns

### Provider Pattern
```dart
ChangeNotifierProvider(
  create: (_) => MyNotifier(),
  child: const MyWidget(),
)
```

### Riverpod Pattern
```dart
final myProvider = ChangeNotifierProvider((ref) => MyNotifier());
```

### BLoC Pattern
```dart
BlocProvider(
  create: (_) => MyBloc(),
  child: const MyWidget(),
)
```

---

## Common Mistakes to Avoid

1. **Don't use `ListView.builder` for small fixed lists** — regular `Column` is faster
2. **Don't use `MediaQuery.of(context).size` for layout logic** — use `LayoutBuilder`
3. **Don't forget `const` constructors** — significant performance impact
4. **Don't nest `Scaffold`s** — use `showDialog`, `showBottomSheet`, or routes
5. **Don't hardcode colors** — use `Theme.of(context).colorScheme`
6. **Don't hardcode text styles** — use `Theme.of(context).textTheme`
