# PulseNow Flutter Developer Assessment

This repository contains the take-home assessment for the Flutter Developer position at PulseNow.

## 📸 Screenshots & Demo

### Test Coverage Report

The project achieves **70.1% code coverage** with comprehensive unit and integration tests across all layers:

![Test Coverage Report](https://drive.google.com/uc?export=view&id=1BdlqnO86Q5wGnDL64AcDU7eiSc77HLqO)

**Coverage Breakdown:**
- **Core Components**: 100% coverage (enums, errors)
- **Models**: 100% coverage
- **Cache Service**: 92.3% coverage
- **Services**: 68.3% coverage
- **Providers**: 60.7% coverage

> 📊 View the full interactive coverage report: [Open Coverage Report](flutter_app/coverage/html/index.html)

### Demo Video

📹 [Watch the demo video](https://drive.google.com/file/d/18arOgmnQ0BSecWdFolqbOeVhYW8wuL-g/view?usp=sharing) to see the app in action with:
- Real-time WebSocket updates
- Search and sort functionality
- Dark mode support
- Pull-to-refresh
- Error handling and loading states

## Project Structure

```
.
├── backend/              # Node.js backend API with mock data
│   ├── controllers/      # API route controllers
│   ├── data/            # Mock data generators
│   ├── middlewares/     # Express middlewares
│   └── server.js        # Main server file
│
├── flutter_app/         # Flutter application (to be completed)
│   └── lib/
│       ├── models/      # Data models
│       ├── services/    # API and WebSocket services
│       ├── providers/   # State management
│       └── screens/     # UI screens
│
└── ASSESSMENT.md        # Detailed assessment instructions
```

## Quick Start

### 1. Start the Backend

```bash
cd backend
npm install
npm start
```

The backend will run on `http://localhost:3000`

### 2. Start the Flutter App

```bash
cd flutter_app
flutter pub get
flutter run
```

## Assessment Overview

This is a focused assessment that tests your ability to:

- Integrate Flutter apps with REST APIs
- Implement state management with Provider
- Create UI components for displaying data
- Handle loading and error states
- Write clean, maintainable code

See `ASSESSMENT.md` for detailed requirements and evaluation criteria.

## Backend API

The backend provides a simple **Market Data API** endpoint:
- `GET /api/market-data` - Returns list of crypto symbols with prices and 24h changes

See `backend/README.md` for API documentation.

## Questions?

Contact the hiring team if you have any questions.

Good luck! 🚀
