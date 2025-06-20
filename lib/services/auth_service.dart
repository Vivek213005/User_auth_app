import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'user_service.dart';

class AuthService {
  
  Future<bool> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userAttributes = {
        CognitoUserAttributeKey.email: email,
        CognitoUserAttributeKey.name: name,
      };

      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );

      return result.isSignUpComplete == false;
    } catch (e) {
      safePrint(' SignUp Error: $e');
      rethrow;
    }
  }

  
  Future<bool> confirmUserSignUp({
    required String email,
    required String otpCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: otpCode,
      );
      return result.isSignUpComplete;
    } catch (e) {
      safePrint(' ConfirmSignUp Error: $e');
      rethrow;
    }
  }

   
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      if (result.isSignedIn) {
        safePrint(" Login Success for $email");

         
        final users = await UserService().getAllUsers();
        final exists = users.any((u) => u['email'] == email);

        if (!exists) {
          safePrint(" User not found in DynamoDB, adding now...");

          
          final attributes = await Amplify.Auth.fetchUserAttributes();

          final nameAttr = attributes.firstWhere(
            (attr) => attr.userAttributeKey == CognitoUserAttributeKey.name,
            orElse: () => const AuthUserAttribute(
              userAttributeKey: CognitoUserAttributeKey.name,
              value: "User",
            ),
          );

          final name = nameAttr.value;

          await UserService().saveUserToDB(name: name, email: email);
          safePrint(" Saved to DynamoDB: $name <$email>");
        } else {
          safePrint(" User already exists in DynamoDB.");
        }

        return true;
      } else {
        safePrint(" Login incomplete");
        return false;
      }
    } catch (e) {
      safePrint(' Login Error: $e');
      rethrow;
    }
  }

   
  Future<void> sendForgotPasswordCode(String email) async {
    try {
      await Amplify.Auth.resetPassword(username: email);
    } catch (e) {
      safePrint(' Forgot Password Error: $e');
      rethrow;
    }
  }
 

  Future<bool> resetPassword({
    required String email,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      return result.isPasswordReset;
    } catch (e) {
      safePrint(' Reset Password Error: $e');
      rethrow;
    }
  }
 

  Future<void> signOutUser() async {
    try {
      await Amplify.Auth.signOut();
      safePrint("👋 User signed out successfully.");
    } catch (e) {
      safePrint(' SignOut Error: $e');
      rethrow;
    }
  }
  
 Future<String?> getCurrentUserEmail() async {
  try {
    final attributes = await Amplify.Auth.fetchUserAttributes();

    final emailAttr = attributes.firstWhere(
      (attr) => attr.userAttributeKey == CognitoUserAttributeKey.email,
    );

    safePrint(" Correct Email: ${emailAttr.value}");  

    return emailAttr.value;
  } catch (e) {
    safePrint(' GetCurrentUserEmail Error: $e');
    return null;
  }
}


}
