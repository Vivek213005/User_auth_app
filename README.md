# Flutter AWS Amplify Auth App

A complete Flutter authentication system using AWS Amplify, Cognito, and DynamoDB. This app supports both user and admin login with real-time user listing.


##  Features
- User signup with name, email, and password
- OTP-based email verification using AWS Cognito
- Login with secure session
- Forgot and reset password functionality
- Stores user data in DynamoDB (name + email)
- Auto-add user to DB if logging in for the first time
- User Dashboard with name display
- Admin Dashboard with all registered users


##  Folder Structure
lib/
├── main.dart
├── app.dart
├── amplifyconfiguration.dart
├── models/
│ └── user_model.dart
├── services/
│ ├── auth_service.dart
│ └── user_service.dart
└── views/
├── login_page.dart
├── signup_page.dart
├── confirm_signup_page.dart
├── forgot_password_page.dart
├── reset_password_page.dart
├── user_dashboard.dart
├── admin_login_page.dart
└── admin_dashboard.dart

##  Tech Stack
- Flutter (Frontend)
- AWS Amplify (Backend setup)
- Cognito (User authentication)
- DynamoDB (User data storage)
- AppSync (GraphQL API)


##  Run the Project

flutter pub get
flutter run


## Build APK

flutter build apk --release

APK path:

build/app/outputs/flutter-apk/app-release.apk

## Important Notes
auth_service.dart handles all auth operations

user_service.dart manages DynamoDB user data

Admin email is hardcoded in admin_login_page.dart

Author
Vivek Kumar
📧 vivekk_213005@saitm.org


