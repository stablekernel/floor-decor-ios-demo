# Floor & Decor iOS Demo App

## Splash Screen Video

- On app launch, a branded animated splash screen is shown with Floor & Decor branding.
- The splash screen features the Floor & Decor logo with animated entrance and tagline.
- Uses Floor & Decor's signature red gradient background.
- Auto-dismisses after 3 seconds with smooth transition to the main app.
- The splash screen is implemented in `SplashScreenView.swift` using SwiftUI animations.

## Requirements
- No external video files required - uses native SwiftUI animations.
- Smooth transitions and proper app lifecycle handling.

# Floor & Decor iOS App

A comprehensive iOS application for Floor & Decor, featuring product browsing, AR preview, store locator, loyalty program, and more.

## 🏗️ Project Overview

This iOS app replicates the core functionality of [Floor & Decor's website](https://www.flooranddecor.com/) with additional mobile-specific features like AR preview and location-based services.

## ✨ Features

### Core Modules

#### 🔐 Authentication & User Management
- **Sign up/in** with email, social login (Apple, Google)
- **Persona selection** (Pro/DIY) during onboarding
- **Profile management** with preferences and settings
- **Secure authentication** with password reset functionality

#### 🛍️ Product Catalog & Search
- **Category browsing** with visual category cards
- **Advanced search** with filters and sorting
- **Product detail pages** with images, specifications, and reviews
- **Real-time inventory** checking
- **Wishlist functionality**

#### 🛒 Cart & Checkout
- **Add/remove items** with quantity management
- **Price calculation** with tax and shipping
- **Payment integration** (Apple Pay, Google Pay, credit cards)
- **Order confirmation** and tracking
- **Pickup reservation** at local stores

#### 📍 Store Locator & Availability
- **Map integration** with Apple Maps
- **Real-time inventory** per store location
- **Store hours** and contact information
- **Directions** and navigation
- **Store services** (design, installation, pro services)

#### 🎯 Loyalty Program
- **Digital loyalty card** with tier system
- **Points tracking** and earning
- **Rewards catalog** with redemption
- **Tier benefits** (Bronze, Silver, Gold, Platinum)

#### 🔮 Augmented Reality (AR)
- **"See in My Room"** feature for flooring
- **Camera access** with surface detection
- **Product overlay** with realistic rendering
- **Lighting simulation** for different conditions
- **Measurement tools** for accurate coverage

#### 👷 Pro Center
- **Bulk order tools** for contractors
- **Business account management**
- **Pro-exclusive deals** and pricing
- **Project management** tools
- **Installation services** booking

#### 🛠️ Project Tools & Resources
- **Calculators** (square footage, cost estimation)
- **How-to guides** and video tutorials
- **Inspiration galleries** and design ideas
- **Installation guides** and tips

#### 🆘 Support & Help Center
- **Live chat** integration
- **FAQ system** with search
- **Contact forms** and support tickets
- **Order tracking** and status updates

### Cross-Cutting Concerns

#### ♿ Accessibility
- **WCAG compliance** for all UI components
- **VoiceOver support** with proper labels
- **Dynamic Type** support for text scaling
- **High contrast** mode support

#### 🔔 Push Notifications
- **Promotional notifications** for deals
- **Order updates** and tracking
- **Store availability** alerts
- **Loyalty program** notifications

#### 📊 Analytics
- **User behavior** tracking
- **Conversion tracking** for purchases
- **Feature usage** analytics
- **Performance monitoring**

#### 🔒 Security
- **Secure storage** for sensitive data
- **API authentication** with tokens
- **Biometric authentication** support
- **Data encryption** for user information

## 🏛️ Architecture

### Data Models
- **Product**: Complete product information with specifications
- **User**: User profile with preferences and loyalty data
- **Cart/Order**: Shopping cart and order management
- **Store**: Store locations with services and inventory
- **Loyalty**: Points, tiers, and rewards system

### View Structure
```
MainTabView
├── HomeView (Featured products, deals, quick actions)
├── CatalogView (Product browsing, search, filters)
├── ARView (Augmented reality preview)
├── StoreLocatorView (Store finder with map)
└── ProfileView (User account, orders, loyalty)
```

### Key Components
- **Authentication Flow**: Multi-step signup with persona selection
- **Product Grid**: Responsive product display with filtering
- **AR Integration**: Camera-based product visualization
- **Store Locator**: Map-based store finder with real-time data
- **Loyalty System**: Points tracking and rewards redemption

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0 or later
- iOS 16.0 or later
- Swift 5.7 or later

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/floor-decor-ios.git
   cd floor-decor-ios
   ```

2. **Open in Xcode**
   ```bash
   open FloorDecorDemo.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

### Configuration

#### API Integration
The app is designed to integrate with Floor & Decor's API endpoints. Update the following in your environment:

```swift
// API Configuration
struct APIConfig {
    static let baseURL = "https://api.flooranddecor.com"
    static let apiKey = "YOUR_API_KEY"
}
```

#### Maps Integration
For store locator functionality, configure Apple Maps:

```swift
// In Info.plist
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show nearby stores</string>
```

#### AR Configuration
For AR features, ensure camera permissions are properly configured:

```swift
// In Info.plist
<key>NSCameraUsageDescription</key>
<string>Camera access is needed for AR product preview</string>
```

## 🧪 Testing

### Unit Tests
Run unit tests with:
```bash
xcodebuild test -scheme FloorDecorDemo -destination 'platform=iOS Simulator,name=iPhone 14'
```

### UI Tests
Run UI tests with:
```bash
xcodebuild test -scheme FloorDecorDemo -destination 'platform=iOS Simulator,name=iPhone 14' -only-testing:FloorDecorDemoUITests
```
- UI test `testLogoTapPresentsSplashScreen` verifies that tapping the logo presents the splash screen.

## 📱 Screenshots

### Main Features
- **Home Screen**: Featured products, deals, and quick actions
- **Catalog**: Product browsing with search and filters
- **AR Preview**: Camera-based product visualization
- **Store Locator**: Map-based store finder
- **Profile**: User account management and loyalty

### Authentication Flow
- **Login**: Email/password and social login options
- **Signup**: Multi-step registration with persona selection
- **Onboarding**: User preference setup and terms acceptance

## 🔧 Development

### Code Style
- Follow Swift style guidelines
- Use SwiftUI for all UI components
- Implement MVVM architecture pattern
- Use Combine for reactive programming

### File Structure
```
FloorDecorDemo/
├── Models/           # Data models
├── Views/           # SwiftUI views
│   ├── Authentication/
│   ├── Components/
│   └── ...
├── Services/        # API and business logic
├── Utilities/       # Helper functions
└── Resources/       # Assets and configuration
```

### Adding New Features

1. **Create Data Models** in `Models/` directory
2. **Add Views** in appropriate `Views/` subdirectory
3. **Implement Services** for API calls
4. **Add Unit Tests** for new functionality
5. **Update Documentation** in README

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Floor & Decor** for inspiration and product information
- **Apple** for SwiftUI and AR frameworks
- **SwiftUI Community** for best practices and examples

## 📞 Support

For support and questions:
- Create an issue in this repository
- Contact the development team
- Check the documentation in the `/docs` folder

---

**Note**: This is a demo application showcasing the potential features for a Floor & Decor iOS app. It uses mock data and simulated API calls. For production use, integrate with actual Floor & Decor APIs and services. 

## Custom Tab Bar Theme
- The bottom navigation bar (tab bar) matches the Floor & Decor website:
  - White background
  - Bold, uppercase black text for unselected items
  - Floor & Decor red (#C8102E) for selected item text and icon
  - Modern sans-serif font, bold, size 12
- See `MainTabView.swift` and `FloorDecorDemoApp.swift` for implementation details. 

## Launch Performance & Error Resolution
- The app includes optimized launch performance to prevent "CA Event" measurement errors
- Splash screen video loads asynchronously with proper loading states
- Fallback handling if video fails to load (auto-dismisses after 2 seconds)
- Smooth transitions between splash screen and main app
- Proper app lifecycle handling to ensure first frame presentation metrics work correctly 