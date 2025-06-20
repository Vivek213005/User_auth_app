import 'package:flutter/material.dart';

import 'views/login_type_page.dart';
import 'views/signup_page.dart';
import 'views/confirm_signup_page.dart';
import 'views/login_page.dart';
import 'views/forgot_password_page.dart';
import 'views/reset_password_page.dart';

import 'views/user_dashboard.dart';
import 'views/admin_login_page.dart';
import 'views/admin_dashboard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Roboto', 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginTypePage(),
        '/signup': (context) => const SignupPage(),
        '/confirm-signup': (context) => const ConfirmSignupPage(),
        '/login': (context) => const LoginPage(),
        '/user-dashboard': (context) => const UserDashboard(),
        '/admin-login': (context) => const AdminLoginPage(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/forgot-password': (context) => const ForgotPasswordPage(),  
       '/reset-password': (context) => const ResetPasswordPage(),  
      },
    );
  }
}
