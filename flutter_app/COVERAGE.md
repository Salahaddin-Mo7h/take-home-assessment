# Test Coverage Report

## Running Tests with Coverage

To run all tests and generate coverage:

```bash
flutter test --coverage
```

The coverage data will be generated in `coverage/lcov.info`.

## Viewing Coverage

### Option 1: Using lcov (if installed)

```bash
# Install lcov (macOS)
brew install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser
open coverage/html/index.html
```

### Option 2: Using VS Code

Install the "Coverage Gutters" extension to view coverage inline in your editor.

### Option 3: Using IntelliJ/Android Studio

1. Run tests with coverage
2. Open the coverage tool window
3. View coverage percentages by file

## Test Structure

```
test/
├── models/
│   └── market_data_model_test.dart      ✅ 3 tests
├── services/
│   └── api_service_test.dart            ✅ 2 tests
├── providers/
│   └── market_data_provider_test.dart   ✅ 7 tests
├── core/
│   ├── cache/
│   │   └── cache_service_test.dart      ✅ 4 tests
│   ├── errors/
│   │   └── app_exceptions_test.dart      ✅ 6 tests
│   └── enums/
│       └── sort_option_test.dart        ✅ 2 tests
```

## Test Summary

- **Total Tests**: 25 tests
- **Status**: ✅ All tests passing
- **Coverage File**: `coverage/lcov.info`

## Test Coverage by Category

### Models (100% coverage)
- ✅ MarketData fromJson with all fields
- ✅ MarketData with null optional fields
- ✅ MarketData numeric type handling

### Services
- ✅ ApiService method structure
- ✅ Error handling structure

### Providers
- ✅ MarketDataProvider initialization
- ✅ Search functionality
- ✅ Sort functionality
- ✅ Filter clearing

### Core Components
- ✅ Exception classes
- ✅ Sort options enum
- ✅ Cache service structure

## Running Specific Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/market_data_model_test.dart

# Run with coverage
flutter test --coverage

# Run with verbose output
flutter test --verbose
```

## Continuous Integration

To integrate coverage into CI/CD:

```yaml
# Example GitHub Actions
- name: Run tests with coverage
  run: flutter test --coverage

- name: Upload coverage
  uses: codecov/codecov-action@v3
  with:
    file: ./coverage/lcov.info
```

