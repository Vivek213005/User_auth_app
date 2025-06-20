Flutter AWS Amplify Auth App
A complete Flutter authentication system using AWS Amplify, Cognito, and DynamoDB. This app supports both user and admin login with real-time user listing.

✅ Features
User signup with name, email, and password

OTP-based email verification using AWS Cognito

Login with secure session

Forgot and reset password functionality

Stores user data in DynamoDB (name + email)

Auto-add user to DB if logging in for the first time

User Dashboard with name display

Admin Dashboard with all registered users

📁 Folder Structure
css
Copy
Edit
lib/
├── main.dart
├── app.dart
├── amplifyconfiguration.dart
├── models/
│   └── user_model.dart
├── services/
│   ├── auth_service.dart
│   └── user_service.dart
└── views/
    ├── login_page.dart
    ├── signup_page.dart
    ├── confirm_signup_page.dart
    ├── forgot_password_page.dart
    ├── reset_password_page.dart
    ├── user_dashboard.dart
    ├── admin_login_page.dart
    └── admin_dashboard.dart
🛠️ Tech Stack
Flutter (Frontend)

AWS Amplify (Backend setup)

Cognito (User authentication)

DynamoDB (User data storage)

AppSync (GraphQL API)

🚀 Run the Project
Clone the repo

Run flutter pub get

Make sure Amplify is configured

Run app with flutter run

📦 Build APK
bash
Copy
Edit
flutter build apk --release
APK will be generated at:

swift
Copy
Edit
build/app/outputs/flutter-apk/app-release.apk
📌 Important Notes
auth_service.dart handles all signup, login, logout operations.

user_service.dart saves and fetches users from DynamoDB.

After login, if user is not found in DB, they are auto-added.

Admin email is hardcoded in admin_login_page.dart.

📄 Deployment Tip
Push this code to GitHub

Add .gitignore to ignore build, .dart_tool, etc.

Use GitHub releases to upload APK

👤 Author
Vivek Kumar
📧 vivekk_213005@saitm.org

