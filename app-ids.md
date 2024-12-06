## Difference between bundle ID vs Package ID vs App ID
| **Feature**         | **Bundle ID** (iOS/macOS)                             | **Package ID** (Android)                            | **App ID** (Apple Developer)                      |
|---------------------|-------------------------------------------------------|----------------------------------------------------|---------------------------------------------------|
| **Platform**        | Apple (iOS, macOS, etc.)                              | Android                                            | Apple Developer (for provisioning profiles)      |
| **Role**            | Uniquely identifies an app in the Apple ecosystem     | Uniquely identifies an app in the Android ecosystem | Used for app provisioning, certificates, and services (like Push Notifications) |
| **Required for**    | App Store submission, app services (Push, iCloud)     | Google Play Store submission, app services         | Tying the app to the Developer Program for certificates and services |
| **Format**          | Reverse domain name, e.g., `com.example.myapp`        | Reverse domain name, e.g., `com.example.myapp`     | Explicit: `com.example.myapp`, Wildcard: `com.example.*` |
| **Used By**         | iOS/macOS systems and App Store                       | Android systems and Google Play Store              | Apple Developer tools for app provisioning and management |
| **Example**         | `com.example.myapp`                                   | `com.example.myapp`                                | **Explicit**: `com.example.myapp`, **Wildcard**: `com.example.*` |
