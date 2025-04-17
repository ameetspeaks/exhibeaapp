# Exhibae

Exhibae is a Flutter-based mobile application that connects Exhibitors/Organizers, Brands, and Shoppers in a seamless platform for discovering, managing, and participating in exhibitions.

## Features

### For Exhibitors/Organizers
- Create and manage exhibitions
- Handle stall bookings
- Communicate with brands
- View and manage applications
- Download exhibitor lists

### For Brands
- Register and showcase products
- Apply for stalls
- Connect with exhibitions
- Manage applications
- View exhibition details

### For Shoppers
- Discover nearby exhibitions
- Save events
- Receive notifications
- Access exclusive discounts
- View participating brands

### For Admins
- Oversee user management
- Approve exhibitions
- Moderate content
- View analytics

## Technical Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Authentication
  - Cloud Firestore
  - Cloud Storage
  - Cloud Messaging
- **State Management**: Provider
- **Navigation**: Go Router
- **UI Components**: Material Design

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Firebase account
- Android Studio / Xcode (for running on emulators)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/exhibae.git
   cd exhibae
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and add the configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── config/
│   ├── router.dart
│   └── theme.dart
├── models/
│   └── user_model.dart
├── providers/
│   └── auth_provider.dart
├── screens/
│   ├── auth_screen.dart
│   ├── onboarding_screen.dart
│   ├── role_selection_screen.dart
│   └── splash_screen.dart
├── services/
│   └── auth_service.dart
└── main.dart
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the backend services
- Material Design team for the UI components 