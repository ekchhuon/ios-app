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

#### Coordinator Strategy for Template Projects

This template uses **full coordinator pattern consistently** across all features to demonstrate best practices and scalable architecture.

**Why Full Coordinator Pattern?**
- ✅ **Consistency**: All features follow the same pattern, making the codebase predictable and easy to understand
- ✅ **Best Practices**: Demonstrates enterprise-level architecture and proper MVVM + Coordinator implementation
- ✅ **Scalability**: Works for both simple projects (5 screens) and complex projects (20+ screens)
- ✅ **Educational Value**: Teaches developers the "right way" to structure iOS apps
- ✅ **Professional Standard**: Shows well-architected, maintainable code structure

**Template Approach:**
- Every feature has a coordinator (HomeCoordinator, ProfileCoordinator, SettingsCoordinator, etc.)
- All navigation goes through coordinators
- ViewControllers never directly push/present other ViewControllers
- Coordinators handle all navigation logic

**When to Simplify (Optional):**
If your cloned project is very simple (3-5 screens with linear navigation), you can optionally:
- Remove individual feature coordinators for simple screens
- Use direct navigation in ViewControllers for one-time navigation
- Keep AppCoordinator for root flow management

**Note**: The template demonstrates the "right way" - you can simplify based on your project's specific needs, but the template shows best practices for scalable architecture.

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

### Navigation & Architecture
1. **Always use Coordinators for navigation** - Never push/present directly from ViewControllers
   - Template uses full coordinator pattern consistently
   - Each feature has its own coordinator
   - ViewControllers communicate with coordinators via weak references
2. **Keep ViewModels testable** - No UIKit imports in ViewModels
   - ViewModels should only import Foundation and Combine
   - Business logic stays in ViewModels, UI logic in ViewControllers
3. **Use protocols** - Makes testing and swapping implementations easier
   - Service protocols (e.g., `APIServiceProtocol`, `AuthManagerProtocol`)
   - Enables easy mocking for unit tests
4. **Follow naming conventions** - Coordinator, ViewModel, ViewController suffixes
   - `HomeCoordinator`, `HomeViewModel`, `HomeViewController`
   - Consistent naming makes codebase easier to navigate

### Code Organization
5. **Use Base classes** - Extend BaseViewController, BaseViewModel for common functionality
   - `BaseViewController`: Common UI setup, loading indicators, error alerts
   - `BaseViewModel`: Common state management (isLoading, errorMessage)
   - `BaseCoordinator`: Common coordinator lifecycle management
6. **Feature-based organization** - Group related files by feature
   - Each feature has its own folder with Views/, ViewModels/, Models/, Coordinators/
   - Makes features self-contained and easy to find

### Development Practices
7. **Logging** - Use Logger.shared for all logging
   - Consistent logging across the app
   - Easy to enable/disable for production
8. **Error handling** - Use NetworkError enum and handle in ViewModels
   - Centralized error types
   - ViewModels handle errors, ViewControllers display them
9. **Dependency Injection** - Inject dependencies via initializers
   - ViewModels receive services via init parameters
   - Makes code testable and flexible
10. **Memory Management** - Properly manage coordinator lifecycle
    - Coordinators are cleaned up when ViewControllers are popped
    - Use weak references to prevent retain cycles

## Dependencies

- **Moya**: Networking
- **SnapKit**: Auto Layout DSL
- **KeychainSwift**: Keychain access
- **IQKeyboardManagerSwift**: Keyboard management

## Template Usage Examples

### Example 1: Bank App (Simple Project - 5 screens)
```
Developer clones template
→ Sees full coordinator pattern
→ Can keep coordinators or simplify for simple navigation
→ Adds BankService in Services/Bank/
→ Customizes features for banking needs
→ Template provides solid foundation
```

### Example 2: E-commerce App (Complex Project - 20+ screens)
```
Developer clones template
→ Perfect! Already has coordinator pattern
→ Adds ProductCoordinator, CartCoordinator, CheckoutCoordinator
→ All follow same consistent pattern
→ Ready to scale without refactoring
→ Template architecture supports growth
```

### Example 3: Travel App (Medium Project - 10 screens)
```
Developer clones template
→ Coordinator pattern fits perfectly
→ Adds BookingCoordinator, HotelCoordinator, FlightCoordinator
→ Reuses navigation patterns from template
→ Easy to add new features following template structure
```

### Example 4: Education App (Growing Project)
```
Developer clones template
→ Starts with coordinator pattern
→ As app grows from 5 → 15 screens, no refactoring needed
→ Template architecture scales naturally
→ Consistent patterns make team collaboration easier
```

## Next Steps

1. Update API endpoints in `APIEndpoints.swift`
2. Configure environment URLs in `Environment.swift`
3. Add app-specific features in `Features/`
4. Add business services in `Services/`
5. Customize styles in `Design/Theme/`
6. Review coordinator pattern usage in existing features
7. Follow the same pattern when adding new features

