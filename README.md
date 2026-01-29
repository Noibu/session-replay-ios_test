# Table of Contents

## 1. Installation
1.1 Adding the SDK via Swift Package Manager  
1.2 Package.swift Integration (Manual)  
1.3 Updating the SDK  
1.4 Removing the SDK  

## 2. Initialization
2.1 Basic Initialization  
2.2 Initialization in a SwiftUI App  
2.3 Checking Initialization Status  

## 3. Session Replay & User Interactions
3.1 How Session Replay Works  
3.2 Required Root View Wrapper  
3.3 Automatically Captured Data  
3.4 Tracking Screens  
3.5 Tracking User Actions
3.6 Custom Attributes 
3.7 Naming Best Practices  
3.8 Performance Considerations  
3.9 Analyzing Sessions in Noibu 


- [1. Installation](#1-installation)  
- [2. Initialization](#2-initialization)  
- [3. Session Replay & User Interactions](#3-session-replay--user-interactions)

## 1. Installation

This section explains how to add, update, and remove the Noibu iOS SDK using **Swift Package Manager (SPM)**.

### 1.1 Adding the SDK via Swift Package Manager (Xcode UI)

1. Open your project in **Xcode**.

2. In the menu bar, go to **File → Add Package Dependencies…** (or **File → Add Packages…** in newer Xcode versions).
3. In the search field, paste the Noibu SDK URL: `https://github.com/Noibu/session-replay-ios.git`
4. Click **Add**. Xcode will resolve the package and show available versions.
5. Under **Dependency Rule**, choose one of:
   - **Up to Next Major Version** (recommended)
   - **Exact Version** (if you need strict reproducibility)
6. Select the **latest stable version** of the SDK.
7. In **Add to Project**, select your app target (e.g. `MyApp`).
8. Click **Add Package**.

### 1.2 Package.swift Integration (Manual SPM Setup)

If your project uses a `Package.swift` file (for example in modular architectures or when managing dependencies manually), you can integrate the Noibu SDK directly by adding it to the package manifest.

Add the Noibu SDK to the `dependencies` section:

```swift
dependencies: [
    .package(
        url: "https://github.com/Noibu/session-replay-ios.git",
        from: "0.5.0"
    )
]
```

Then reference the Noibu product inside your target:

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(name: "NoibuSessionReplay", package: "session-replay-ios")
    ]
)
```

After modifying your Package.swift, update your packages:

```bash
swift package update
swift package resolve
```

Once resolved, you can import the SDK in your code:

```swift
import NoibuSessionReplay
```

### 1.3 Updating the SDK

Keeping the Noibu SDK up to date ensures you receive the latest improvements, bug fixes, and performance optimizations. You can update the SDK either through Xcode's built-in dependency manager or manually when using a `Package.swift` file.

#### Updating via Xcode

1. Open your project in **Xcode**.
2. Select your project from the **Project Navigator** (left sidebar).
3. Go to the **Package Dependencies** tab.
4. Locate **NoibuSessionReplay** in the dependency list.
5. Update the version

The update will automatically propagate to all targets that include the Noibu SDK.

#### Updating via Package.swift

To update the NoibuSessionReplay SDK when using a `Package.swift` file, modify the version requirement in your package dependencies.

To allow updates to any newer compatible version:

```swift
.package(
    url: "https://github.com/Noibu/session-replay-ios.git",
    from: "0.5.0"
)
```

To pin the SDK to a specific version:

```swift
.package(
    url: "https://github.com/Noibu/session-replay-ios.git",
    exact: "0.5.0"
)
```

After updating the version requirement, run the following commands to fetch the latest version:

```bash
swift package update
swift package resolve
```

### 1.4 Removing the SDK

If you need to remove the NoibuSessionReplay SDK from your project, follow the steps below depending on whether you are using Xcode’s Package Dependencies interface or a manual `Package.swift` setup.

#### Removing the SDK via Xcode (SPM UI)

1. Open your project in **Xcode**.
2. Select your project in the **Project Navigator**.
3. Open the **Package Dependencies** tab.
4. Locate **NoibuSessionReplay** in the list.
5. Right-click the package and select **Remove**, or click the **–** (minus) button.
6. Xcode will detach the package and remove it from your targets.

After removal:

- Delete any `import NoibuSessionReplay` statements.
- Remove any usage of the SDK from your code.
- Perform a clean build via **Product → Clean Build Folder**.

#### Removing the SDK via Package.swift (Manual)

If you added the SDK manually in `Package.swift`, remove the dependency entry:

```swift
// Remove this line from dependencies:
.package(
    url: "https://github.com/Noibu/session-replay-ios.git",
    from: "0.5.0"
)
```

Then remove the product from your target:

```swift
// Remove this from target dependencies:
.product(name: "NoibuSessionReplay", package: "session-replay-ios")
```

Update your packages:
```bash
swift package update
```

Finally, delete any import statements and references to the SDK in your source code.

---

## 2. Initialization

The Noibu iOS SDK exposes a minimal and simple public API.  
Initialization must occur as early as possible in your app’s lifecycle to ensure full session capture and error monitoring.

The public API consists of:
- `Noibu.shared.initialize()` — Starts the SDK
- `Noibu.shared.isInitialized` — Returns whether the SDK is currently active
- `Noibu.shared.addCustomAttribute(name: String, value: String)` - Add a custom attribute


### 2.1 Basic Initialization

To start the SDK, call:
```swift
import NoibuSessionReplay

Noibu.shared.initialize()
```

This automatically:
- Initializes the Datadog Core engine
- Enables RUM (Real User Monitoring)
- Enables Session Replay
- Configures sampling, privacy, and SwiftUI predicates
- Grants tracking consent by default

The SDK handles all internal setup for you.
No configuration parameters are required at this time.

### 2.2 Initialization in a SwiftUI App

For SwiftUI applications, the recommended integration point is inside the `init()` of your `@main App`:

```swift
import SwiftUI
import NoibuSessionReplay

@main
struct MyApp: App {

    init() {
        Noibu.shared.initialize()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

This ensures the SDK is activated before your first view appears, allowing full session replay coverage from the moment the app launches.

### 2.3 Checking Initialization Status

You can check whether the SDK is currently active by reading:

```swift
if Noibu.shared.isInitialized {
    print("Noibu SDK is running")
}
```

---

## 3. Session Replay & User Interactions

The Noibu iOS SDK automatically enables Session Replay when `Noibu.shared.initialize()` is called.  
However, to correctly capture SwiftUI navigation, view transitions, and interaction flows, the app must also wrap its root view with `.noibuSessionReplayWrapper()`.

Session Replay runs on top of a native replay engine fully integrated and managed internally by the Noibu SDK.

### 3.1 How Session Replay Works

Once the SDK is initialized and the root view is wrapped:

- SwiftUI screen transitions are recorded  
- User interactions (taps, gestures, scrolls) are captured  
- Navigation events (NavigationLink / NavigationStack) are tracked  
- Snapshot diffs are collected to reconstruct UI changes  
- Sensitive inputs are masked automatically  

No additional configuration is required.

### 3.2 Required Root View Wrapper

To capture navigation and screen transitions correctly, wrap your root view:
```swift
.noibuSessionReplayWrapper()
```

**Example:**
```swift
@main
struct MyApp: App {
    init() {
        Noibu.shared.initialize()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .noibuSessionReplayWrapper()
        }
    }
}
```

### 3.3 Automatically Captured Data

Once the SDK is initialized and the root view is wrapped, the following data is captured automatically without any additional instrumentation:

- **Screen transitions** (SwiftUI view changes)
- **User interactions**
  - Button taps
  - Touch interactions
  - Gestures
  - Scroll gestures
  - Slider changes
- **Navigation triggers**
- **View appearance and disappearance events**
- **Layout and UI updates**
- **Navigation flow events**
- **UI rendering and lifecycle events**
- **Replay snapshot diffs** used to reconstruct the visual timeline
- **Error events originating from the UI layer**

Everything listed above is captured automatically. Developers do not need to add identifiers, tags, or annotations for these events.

### 3.4 Tracking Screens

In addition to automatic screen tracking, developers may explicitly label important screens using:
```swift
.trackView(name: "ScreenName")
```

This is useful for:
- Distinguishing key parts of the app (Home, ProductPage, Checkout)
- Improving readability in the replay timeline
- Segmenting complex UI flows

**Example:**
```swift
var body: some View {
    VStack {
        Text("Hello World")
    }
    .trackView(name: "Main ContentView")
}
```

This will give the replay viewer a clear, human-readable screen name that appears in the session timeline.

### 3.5 Tracking User Actions

Although many interactions are captured automatically, developers can explicitly annotate meaningful user actions using the `.trackTapAction(name:)` view modifier.
```swift
.trackTapAction(name: "ActionName")
```

This is helpful for:
- Understanding user intent
- Marking key points in complex flows
- Debugging UI behavior
- Providing clarity in the replay timeline
- Highlighting meaningful interactions such as:
  - Primary call-to-action buttons
  - Navigation triggers
  - Feature toggles
  - Sliders or configuration changes

Custom actions appear as clearly labeled events in the replay timeline.

**Example:**
```swift
Button(action: {
    withAnimation { showContent.toggle() }
}) {
    Text(showContent ? "Hide content" : "Show content")
}
.trackTapAction(name: "Toggle content button")
```

### 3.6 Custom Attributes
Custom Attributes allow you to attach business and application context to a user session.
They are useful for enriching session replays with information that is not automatically captured by the SDK.

Common use cases include:
- Feature flags
- Application or UI state
- Configuration modes (debug, staging, A/B variants)
- High-level user intent
- Environment or build metadata

Custom Attributes are associated with the current session and can be used to add context, filter sessions, and improve debugging in the Noibu dashboard.

#### 3.6.1 Adding a Custom Attribute
Custom Attributes can be added at any point after the SDK has been initialized using the following API:
```swift
Noibu.shared.addCustomAttribute(name: String, value: String)
```
Example
```swift
Noibu.shared.addCustomAttribute(
    name: "screen.name",
    value: "ContentView"
)
```
If the SDK is not initialized or the attribute fails validation, the attribute will be ignored.

#### 3.6.2 Recommended Usage Patterns

Custom Attributes should be added at meaningful points in the app lifecycle where they provide useful session context.

#### When a screen appears ####
Attach high-level metadata describing the screen or its variant:
```swift
.onAppear {
    Noibu.shared.addCustomAttribute(
        name: "screen.variant",
        value: "main"
    )
}
```
#### When application state changes ####
Track persistent UI or configuration state changes:
```swift
Toggle(isOn: $isSwitchOn) {
    Text("Debug mode")
}
.onChange(of: isSwitchOn) { value in
    Noibu.shared.addCustomAttribute(
        name: "debug.enabled",
        value: value ? "true" : "false"
    )
}
```
#### Before a meaningful user action ####
Attach context immediately before an important interaction or network request:
```swift
Button(action: {
    Noibu.shared.addCustomAttribute(
        name: "ui.toggle_content",
        value: showContent ? "hide" : "show"
    )

    withAnimation { showContent.toggle() }
}) {
    Text("Toggle content")
}
.trackTapAction(name: "Toggle content button")
```

#### 3.6.3 Limits & Validation

The Noibu iOS SDK enforces the following validation rules for Custom Attributes:
- A maximum of 10 custom attributes per session
- Attribute names and values must be strings
- Attribute names must be 1–50 characters long
- Attribute values must be 1–50 characters long
- Duplicate attribute names are not allowed within the same session

If any of these rules are violated, the attribute will be ignored and will not be associated with the session.

### 3.7 Naming Best Practices

When naming screens and actions, follow these guidelines to keep replays easy to understand:

- Use clear, descriptive names (e.g. "Add to Cart", "Toggle content button")
- Focus on user intent, not implementation details
- Keep names consistent across similar interactions
- Avoid including personal or sensitive data in action names

Good naming improves collaboration between developers, QA, and product teams when reviewing session replays.

### 3.8 Performance Considerations

The Noibu iOS SDK is optimized to ensure minimal impact on app performance while recording session replay data. Key optimizations include:

- **Delta-based snapshots** instead of full-frame captures (only visual differences are recorded, reducing CPU and memory usage)
- **Event batching**, grouping UI interactions efficiently
- **Background uploads**, syncing replay data when the device is idle
- **Optimized sampling logic**, with replay sampling handled internally
- **Low memory footprint** thanks to native replay engine optimizations

These behaviors ensure that session replay has negligible overhead on modern devices and remains fully transparent to end users.

### 3.9 Analyzing Sessions in Noibu

All captured and custom-tracked screens and actions are displayed in the Noibu session replay timeline.

Within the Noibu dashboard, teams can:

- Identify the sequence of user interactions leading to an issue
- Correlate actions with UI changes and navigation events
- Pinpoint where users get stuck or abandon flows
- Reproduce bugs by following the exact interaction path
- Filter and analyze specific user journeys

By combining automatic interaction capture with explicit screen and action tagging, Noibu provides a clear and actionable view of real user behavior.
