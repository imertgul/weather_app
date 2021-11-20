import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:weather_app/amplifyconfiguration.dart';

class AuthRepository {
  //To make it singleton
  static final _instance = AuthRepository._();
  factory AuthRepository() => _instance;

  late AmplifyClass amplify;

  AuthRepository._() {
    _configureAmplify();
  }

  static const Map<String, String> _userAttributes = {
    'email': 'email@domain.com',
    'phone_number': '+15559101234',
  };

  void _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    await amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      StateError(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      SignUpResult res = await amplify.Auth.signUp(
          username: username,
          password: password,
          options: const CognitoSignUpOptions(userAttributes: _userAttributes));
      return res.isSignUpComplete;
    } on AuthException catch (e) {
      StateError(e.message);
    }
    return false;
  }

  Future<bool> confirmRegister(String email, String code) async {
    try {
      SignUpResult res = await amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: code,
      );
      return res.isSignUpComplete;
    } on AuthException catch (e) {
      StateError(e.message);
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      return res.isSignedIn;
    } on AuthException catch (e) {
      StateError(e.message);
    }
    return false;
  }
}
