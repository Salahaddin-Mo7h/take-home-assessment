# PulseNow Flutter App

Flutter application for displaying real-time market data with WebSocket updates.

## Features

- Real-time market data display with WebSocket updates
- Search and filter functionality
- Sort by symbol, price, change24h, or changePercent24h
- Dark mode support
- Pull-to-refresh
- Offline caching support
- Comprehensive error handling
- Modern, responsive UI

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Backend server running (see main README)

### Installation

```bash
flutter pub get
flutter run
```

## Test Coverage

The project maintains **70.1% code coverage** with comprehensive unit and integration tests.

### Coverage Breakdown:
- **Core Components**: 100% coverage (enums, errors)
- **Models**: 100% coverage
- **Cache Service**: 92.3% coverage
- **Services**: 68.3% coverage
- **Providers**: 60.7% coverage

Run tests with coverage:
```bash
flutter test --coverage
```

View coverage report:
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

See [COVERAGE.md](./COVERAGE.md) for detailed coverage documentation.

## Project Structure

```
lib/
├── core/
│   ├── cache/          # Caching service
│   ├── enums/          # Enumerations
│   ├── errors/         # Custom exceptions
│   ├── strings/        # App strings (i18n ready)
│   └── theme/          # App themes (light/dark)
├── models/             # Data models
├── providers/          # State management (Provider)
├── screens/            # UI screens
├── services/           # API and WebSocket services
├── utils/              # Helper utilities
└── widgets/            # Reusable widgets
```

## References

### Demo Video
📹 [Watch the app demo video](https://drive.google.com/file/d/18arOgmnQ0BSecWdFolqbOeVhYW8wuL-g/view?usp=sharing)

The demo showcases:
- Real-time WebSocket updates
- Search and sort functionality
- Dark mode toggle
- Pull-to-refresh
- Error handling and loading states
- Market data detail screen

### Test Coverage Report
📊 View the interactive coverage report: [Coverage Report](./coverage/html/index.html)
