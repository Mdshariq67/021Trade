# 021 Trade — Watchlist (Flutter BLoC Assignment)

A production-quality Flutter application demonstrating a reorderable stock watchlist using the **BLoC architecture pattern**.

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point, DI setup
├── bloc/
│   ├── watchlist_bloc.dart      # BLoC logic + part directives
│   ├── watchlist_event.dart     # All watchlist events (part of)
│   └── watchlist_state.dart     # All watchlist states (part of)
├── data/
│   └── stock_repository.dart   # Data layer: sample stocks
├── models/
│   └── stock.dart               # Type-safe Stock model (Equatable)
├── screens/
│   └── watchlist_screen.dart   # Main screen with BlocBuilder
├── theme/
│   └── app_theme.dart          # Centralized theme & typography
└── widgets/
    ├── stock_tile.dart          # Reusable stock list tile
    ├── watchlist_header.dart    # Header with title & actions
    └── empty_watchlist.dart    # Empty state widget

test/
└── watchlist_bloc_test.dart    # Unit tests for BLoC & model
```

---

## 🏗️ Architecture: BLoC Pattern

### Events
| Event | Description |
|-------|-------------|
| `WatchlistLoaded` | Triggers initial data fetch |
| `WatchlistStockReordered` | Drag-and-drop reorder from `ReorderableListView` |
| `WatchlistStocksSwapped` | Explicit swap of two stocks by index |
| `WatchlistStockRemoved` | Removes a stock by symbol |
| `WatchlistReset` | Resets to original order |

### States
| State | Description |
|-------|-------------|
| `WatchlistInitial` | Before any data load |
| `WatchlistLoading` | Data is being fetched |
| `WatchlistReady` | Stocks ready; includes optional swap highlight indices |
| `WatchlistError` | Error occurred with message |

### Data Flow
```
UI Event → WatchlistBloc → Emits WatchlistState → BlocBuilder re-renders UI
```

---

## ✨ Features

- **Drag & Drop Reordering** via Flutter's `ReorderableListView`
- **Swipe to Remove** with `Dismissible` + confirmation dialog
- **Reset Order** back to original sample data
- **Animated drag proxy** with scale animation on drag
- **Dark trading UI** with gain/loss color coding
- **Type-safe** model with `Equatable`
- **Full BLoC** with Events, States, and `Emitter`-based handlers
- **RepositoryProvider** for proper DI

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ≥ 3.10.0
- Dart SDK ≥ 3.0.0

### Run the app
```bash
flutter pub get
flutter run
```

### Run tests
```bash
flutter test
```

---

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | BLoC state management |
| `equatable` | Value equality for models and states |
| `google_fonts` | Typography (Space Grotesk, JetBrains Mono, Inter) |
| `bloc_test` | BLoC unit test utilities |
| `mocktail` | Mock generation for tests |

---

## 🎨 Design Decisions

- **Dark theme**: Trading apps are used in low-light environments; dark UI reduces eye strain
- **JetBrains Mono** for prices and symbols: monospace ensures numerical alignment
- **Color coding**: Green (#00D09C) for gains, Red (#FF4D6A) for losses — standard trading convention
- **Drag indicator**: Visible only during drag for clean default appearance
- **Dismissible with confirmation**: Prevents accidental removal

---

## 🧪 Test Coverage

- BLoC initial state
- Load event → Loading → Ready transition
- Reorder logic correctness
- Swap logic correctness
- Remove by symbol
- Reset to original order
- Edge case: swap with same index (no-op)
- Stock model: `changeDirection`, `formattedPrice`, `formattedChange`, `copyWith`, equality
