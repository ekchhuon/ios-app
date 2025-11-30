# iOS App Architecture

This is a scalable, MVVM-based iOS app template that can be easily cloned and customized for different app types (Bank, School, Travel, Pharmacy, etc.).

## Architecture Overview

The app follows **MVVM (Model-View-ViewModel)** architecture with **Coordinator pattern** for navigation.

## Project Structure

```
ios-app/
│
├── App/                  # App-level files
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── AppCoordinator.swift    # Main navigation coordinator
│
├── Configuration/        # App configuration
│   ├── AppConfig.swift     # App configuration
│   ├── Environment.swift   # Environment settings (dev/staging/prod)
│   ├── Dev/               # Development configs
│   ├── Staging/           # Staging configs
│   └── Production/        # Production configs
│
├── Core/                 # Core functionality
│   ├── Network/
│   │   ├── APIClient.swift      # Moya-based API client
│   │   ├── APIEndpoints.swift   # API endpoint definitions
│   │   └── NetworkError.swift   # Network error handling
│   ├── Storage/
│   │   ├── UserDefaultsStore.swift  # UserDefaults wrapper
│   │   └── KeychainStore.swift      # Keychain wrapper
│   ├── Extensions/           # Swift extensions
│   │   ├── UIView+Extensions.swift
│   │   └── String+Extensions.swift
│   ├── Utilities/
│   │   ├── Helpers/              # Helper functions
│   │   └── Logger.swift          # Logging utility
│   ├── Base/
│   │   ├── BaseViewModel.swift   # Base ViewModel
│   │   ├── BaseViewController.swift  # Base ViewController
│   │   └── BaseCoordinator.swift     # Base Coordinator
│   └── DI/
│       └── ServiceLocator.swift # Dependency Injection
│
├── Design/               # Design system
│   ├── Theme/
│   │   ├── AppColors.swift      # Color definitions
│   │   ├── AppFonts.swift       # Typography
│   │   └── AppSpacing.swift     # Spacing constants
│   └── Components/       # Reusable UI components
│       └── (Custom UI components)
│
├── Features/             # Feature modules
│   ├── Onboarding/
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   ├── Models/
│   │   └── Coordinators/
│   │       └── OnboardingCoordinator.swift
│   ├── Home/
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   ├── Models/
│   │   └── Coordinators/
│   ├── Profile/
│   └── Settings/
│
├── Services/             # Domain-specific business logic
│   ├── Bank/
│   │   ├── BankService.swift
│   │   └── BankRepository.swift
│   ├── School/
│   ├── Travel/
│   └── Pharmacy/
│
├── Shared/               # Shared system managers
│   └── Managers/
│       ├── AuthManager.swift
│       ├── LocationManager.swift
│       └── NotificationManager.swift
│
├── Resources/            # App resources
│   ├── Assets.xcassets
│   ├── Base.lproj/
│   │   └── LaunchScreen.storyboard
│   ├── Fonts/
│   └── Localization/
│
└── Tests/
    ├── UnitTests/
    └── UITests/
```

## Key Components

### 1. Coordinator Pattern
- **AppCoordinator**: Main coordinator that manages app-level navigation
- **Feature Coordinators**: Each feature has its own coordinator (OnboardingCoordinator, HomeCoordinator, etc.)
- Handles all navigation logic, keeping ViewControllers clean

### 2. MVVM Pattern
- **View**: UIViewController (Views/)
- **ViewModel**: Business logic and state management (ViewModels/)
- **Model**: Data models (Models/)
- ViewModels use `@Published` properties for reactive updates

### 3. Network Layer
- Uses **Moya** for type-safe networking
- `APIClient`: Handles all network requests
- `APIEndpoints`: Defines all API endpoints using Moya's TargetType
- `NetworkError`: Centralized error handling

### 4. Storage Layer
- **UserDefaultsStore**: For non-sensitive data
- **KeychainStore**: For sensitive data (tokens, passwords)
- Both implement protocols for easy testing and swapping

### 5. Dependency Injection
- **ServiceLocator**: Simple DI container
- All services registered in `ServiceLocator.registerServices()`
- Easy to mock for testing

## Usage

### Adding a New Feature

1. Create feature folder in `Features/`
2. Create Coordinator, ViewModel, View, and Model
3. Register navigation in parent coordinator

Example:
```swift
// Features/Payment/PaymentCoordinator.swift
class PaymentCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = PaymentViewModel()
        let viewController = PaymentViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
```

### Adding a New Service

1. Create service folder in `Services/`
2. Create Service protocol and implementation
3. Create Repository for data access
4. Register in ServiceLocator if needed

Example:
```swift
// Services/School/SchoolService.swift
protocol SchoolServiceProtocol {
    func getCourses(completion: @escaping (Result<[Course], Error>) -> Void)
}

class SchoolService: SchoolServiceProtocol {
    // Implementation
}
```

### Environment Configuration

Update `Environment.swift` to set different base URLs for dev/staging/production:
```swift
var baseURL: String {
    switch self {
    case .development:
        return "https://api-dev.example.com"
    case .staging:
        return "https://api-staging.example.com"
    case .production:
        return "https://api.example.com"
    }
}
```

## Best Practices

1. **Always use Coordinators for navigation** - Never push/present directly from ViewControllers
2. **Keep ViewModels testable** - No UIKit imports in ViewModels
3. **Use protocols** - Makes testing and swapping implementations easier
4. **Follow naming conventions** - Coordinator, ViewModel, ViewController suffixes
5. **Use Base classes** - Extend BaseViewController, BaseViewModel for common functionality
6. **Logging** - Use Logger.shared for all logging
7. **Error handling** - Use NetworkError enum and handle in ViewModels

## Dependencies

- **Moya**: Networking
- **SnapKit**: Auto Layout DSL
- **KeychainSwift**: Keychain access
- **IQKeyboardManagerSwift**: Keyboard management

## Next Steps

1. Update API endpoints in `APIEndpoints.swift`
2. Configure environment URLs in `Environment.swift`
3. Add app-specific features in `Features/`
4. Add business services in `Services/`
5. Customize styles in `Shared/Styles/`

