# When to Use `finish()` in Coordinators

## 🎯 Overview

`finish()` is used to **clean up and remove a coordinator** from the coordinator hierarchy. It's called when a coordinator's work is complete and it should be deallocated.

## 📋 What `finish()` Does

When `finish()` is called, it:
1. ✅ Recursively finishes all child coordinators
2. ✅ Removes all child coordinators from the array
3. ✅ Removes itself from the parent coordinator's child array
4. ✅ Allows the coordinator to be deallocated (memory cleanup)

## 🔍 Current Implementation

```swift
func finish() {
    // 1. Clean up all child coordinators first
    childCoordinators.forEach { $0.finish() }
    childCoordinators.removeAll()
    
    // 2. Remove self from parent coordinator
    parentCoordinator?.removeChildCoordinator(self)
}
```

## ✅ When to Use `finish()`

### 1. **Flow Completion** (Most Common)
When a coordinator's entire flow is complete and you're transitioning to a different flow.

**Example: Onboarding → Home**
```swift
// OnboardingCoordinator.swift
func finishOnboarding() {
    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    
    // Finish onboarding coordinator - we're done with onboarding
    finish() // ✅ Clean up onboarding coordinator
    
    // Transition to home
    if let appCoordinator = parentCoordinator as? AppCoordinator {
        appCoordinator.showHome()
    }
}
```

### 2. **User Logout**
When user logs out and you need to clean up all coordinators.

```swift
// AppCoordinator.swift
func handleLogout() {
    // Finish all child coordinators (Home, Profile, Settings, etc.)
    finish() // ✅ Or use removeAllChildCoordinators()
    
    // Show login/onboarding
    showOnboarding()
}
```

### 3. **Modal/Presented Flow Completion**
When a coordinator manages a modal flow that's being dismissed.

```swift
// PaymentCoordinator.swift (manages payment modal)
func paymentCompleted() {
    // Dismiss the payment flow
    navigationController.dismiss(animated: true) {
        // Clean up coordinator after dismissal
        self.finish() // ✅ Coordinator is done
    }
}
```

### 4. **Deep Link Navigation**
When navigating to a completely different part of the app via deep link.

```swift
// AppCoordinator.swift
func handleDeepLink(to destination: DeepLinkDestination) {
    // Finish current flow
    removeAllChildCoordinators() // ✅ Or finish() if needed
    
    // Start new flow based on deep link
    switch destination {
    case .product(let id):
        showProduct(id: id)
    case .profile:
        showProfile()
    }
}
```

### 5. **Error Recovery**
When a critical error occurs and you need to reset the navigation state.

```swift
// AppCoordinator.swift
func handleCriticalError() {
    // Clean up everything
    finish() // ✅ Reset coordinator hierarchy
    
    // Show error screen or restart app flow
    showErrorScreen()
}
```

## ❌ When NOT to Use `finish()`

### 1. **Simple Navigation Back** (Use `childDidFinish()` instead)
When a ViewController is popped from navigation stack, use `childDidFinish()`.

```swift
// ProfileCoordinator - when ProfileViewController is popped
// DON'T call finish() here
// Instead, use onDismiss callback that calls parentCoordinator?.childDidFinish(self)
```

**Why?** Because the coordinator might be needed again if user navigates back to Profile.

### 2. **AppCoordinator** (Rarely)
AppCoordinator is the root coordinator and typically doesn't finish.

```swift
// AppCoordinator.swift
func finish() {
    // App coordinator doesn't finish - it's the root
    // Only clean up children if needed
    childCoordinators.forEach { $0.finish() }
    childCoordinators.removeAll()
}
```

### 3. **Temporary Navigation**
When navigating to a screen that will come back (like Settings → About).

```swift
// SettingsCoordinator
func showAbout() {
    // Don't finish SettingsCoordinator
    // Just push AboutViewController
    let aboutCoordinator = AboutCoordinator(navigationController: navigationController)
    addChildCoordinator(aboutCoordinator)
    aboutCoordinator.start()
}
```

## 🔄 `finish()` vs `childDidFinish()`

### `finish()` - Coordinator finishes itself
```swift
// Coordinator calls finish() on itself
func completeFlow() {
    finish() // ✅ I'm done, clean me up
}
```

**Use when:**
- Flow is complete
- Transitioning to different flow
- Logging out
- Modal flow dismissed

### `childDidFinish()` - Parent removes child
```swift
// Parent coordinator removes child
func childDidFinish(_ child: Coordinator?) {
    // Remove child from array
    childCoordinators = childCoordinators.filter { $0 !== child }
}
```

**Use when:**
- ViewController is popped (automatic cleanup)
- Child coordinator is done and parent needs to know

## 📊 Real-World Examples

### Example 1: Onboarding Flow
```swift
// User completes onboarding
OnboardingCoordinator.finishOnboarding()
    → finish() // ✅ Onboarding is complete
    → AppCoordinator.showHome() // Start home flow
```

### Example 2: Payment Flow (Modal)
```swift
// User completes payment
PaymentCoordinator.paymentCompleted()
    → navigationController.dismiss()
    → finish() // ✅ Payment flow is done
    → Parent coordinator removes it
```

### Example 3: User Logout
```swift
// User logs out
AppCoordinator.handleLogout()
    → finish() // ✅ Clean up all coordinators
    → showOnboarding() // Start fresh
```

### Example 4: Profile Screen (Simple Navigation)
```swift
// User navigates back from Profile
ProfileViewController.viewWillDisappear()
    → onDismiss?() // ✅ Not finish()
    → parentCoordinator?.childDidFinish(self)
    → HomeCoordinator removes ProfileCoordinator
```

## 🎯 Best Practices

### ✅ DO:
1. **Call `finish()` when flow is complete**
   ```swift
   func completeFlow() {
       finish() // ✅
   }
   ```

2. **Use `finish()` for modal flows**
   ```swift
   func dismissModal() {
       navigationController.dismiss(animated: true) {
           self.finish() // ✅
       }
   }
   ```

3. **Use `finish()` when transitioning flows**
   ```swift
   func transitionToNewFlow() {
       finish() // ✅ Clean up current flow
       parentCoordinator?.startNewFlow()
   }
   ```

### ❌ DON'T:
1. **Don't call `finish()` on simple back navigation**
   ```swift
   // ❌ Wrong
   func backButtonTapped() {
       finish() // ❌ Use childDidFinish instead
   }
   ```

2. **Don't call `finish()` if coordinator might be needed again**
   ```swift
   // ❌ Wrong - Settings might be accessed again
   func showAbout() {
       finish() // ❌ Settings coordinator still needed
   }
   ```

3. **Don't call `finish()` on AppCoordinator**
   ```swift
   // ❌ Wrong - AppCoordinator is root
   appCoordinator.finish() // ❌ App coordinator should stay alive
   ```

## 📝 Summary

| Scenario | Use `finish()`? | Alternative |
|----------|----------------|-------------|
| Flow complete (Onboarding → Home) | ✅ Yes | - |
| Modal flow dismissed | ✅ Yes | - |
| User logout | ✅ Yes | - |
| Deep link navigation | ✅ Yes | `removeAllChildCoordinators()` |
| Simple back navigation | ❌ No | `childDidFinish()` |
| Temporary screen (Settings → About) | ❌ No | Keep coordinator |
| AppCoordinator | ❌ Rarely | Only clean children |

## 💡 Key Takeaway

**`finish()` = "I'm done, clean me up"**

Use it when:
- ✅ A coordinator's entire flow is complete
- ✅ Transitioning to a completely different flow
- ✅ Modal/presented flow is dismissed
- ✅ Need to reset navigation state

Don't use it for:
- ❌ Simple back navigation (use `childDidFinish()`)
- ❌ Temporary navigation (keep coordinator)
- ❌ AppCoordinator (it's the root)

---

**In your current code**: `finish()` is correctly used in `OnboardingCoordinator.finishOnboarding()` when onboarding is complete and transitioning to Home.


