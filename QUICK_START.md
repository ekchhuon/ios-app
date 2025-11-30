# Quick Start Guide

## Setup

1. **Install Dependencies**
   ```bash
   pod install
   ```

2. **Open Workspace**
   ```bash
   open ios-app.xcworkspace
   ```
   ⚠️ Always use `.xcworkspace`, not `.xcodeproj`

3. **Configure Environment**
   - Update `Application/Config/Environment.swift` with your API URLs
   - Update `Application/Config/AppConfig.swift` with app-specific settings

4. **Update API Endpoints**
   - Add your API endpoints in `Core/Network/APIEndpoints.swift`

## Project Structure Overview

### Application Layer
- **AppCoordinator**: Manages app-level navigation flow
- **Config**: App configuration and environment settings
- **DI**: Dependency injection container

### Core Layer
- **Network**: Moya-based API client
- **Storage**: UserDefaults and Keychain wrappers
- **Base Classes**: Base ViewController, ViewModel, Coordinator
- **Utilities**: Extensions, helpers, logger

### Shared Layer
- **Components**: Reusable UI components
- **Styles**: Colors, fonts, spacing constants
- **Managers**: Auth, Location, Notifications

### Features Layer
Each feature follows MVVM + Coordinator pattern:
- `Views/` - ViewControllers
- `ViewModels/` - Business logic
- `Models/` - Data models
- `*Coordinator.swift` - Navigation logic

### Services Layer
Business logic services organized by domain:
- Bank, School, Travel, Pharmacy, etc.

## Adding a New Feature

1. Create folder in `Features/YourFeature/`
2. Create Coordinator:
   ```swift
   class YourFeatureCoordinator: BaseCoordinator {
       override func start() {
           let viewModel = YourFeatureViewModel()
           let viewController = YourFeatureViewController(viewModel: viewModel)
           navigationController.pushViewController(viewController, animated: true)
       }
   }
   ```
3. Create ViewModel (extends BaseViewModel)
4. Create ViewController (extends BaseViewController)
5. Add navigation in parent coordinator

## Adding a New Service

1. Create folder in `Services/YourService/`
2. Create Service protocol and implementation
3. Create Repository if needed
4. Register in ServiceLocator if required

## Key Features

✅ **MVVM Architecture** - Clean separation of concerns
✅ **Coordinator Pattern** - Centralized navigation
✅ **Dependency Injection** - Easy testing and swapping
✅ **Type-safe Networking** - Moya with protocols
✅ **Secure Storage** - Keychain for sensitive data
✅ **Logging** - Centralized logger
✅ **Error Handling** - NetworkError enum
✅ **Programmatic UI** - No storyboards, SnapKit for layout

## Next Steps

1. Update API endpoints
2. Customize app styles (colors, fonts)
3. Add your features
4. Add your services
5. Configure environment URLs

For detailed architecture documentation, see `ARCHITECTURE.md`

