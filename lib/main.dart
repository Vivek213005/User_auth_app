 import 'package:flutter/material.dart';
import 'app.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart'; 
import 'amplifyconfiguration.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(), 
    ]);

    
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    safePrint("Amplify already configured");
  } catch (e) {
    safePrint("Amplify configure error: $e");
  }

  runApp(const MyApp());
}
