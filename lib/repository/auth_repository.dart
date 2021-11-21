import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:weather_app/amplifyconfiguration.dart';

abstract class AuthState {} //Auth states

class AuthRequired extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthRepository {
  //To make it singleton
  static final _instance = AuthRepository._();
  factory AuthRepository() => _instance;

  //Auth state stream
  final StreamController<AuthState> _authStateController = StreamController();

  AuthRepository._() {
    _authStateController.add(AuthRequired());
  }

  Stream<AuthState> get authState => _authStateController.stream;

  Future<void> configureAmplify() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([authPlugin]);

    try {
      await Amplify.configure(amplifyconfig);
      Amplify.Auth.fetchAuthSession().then((session) {
        if (session.isSignedIn) {
          _authStateController.add(AuthSuccess());
        }
      });
      Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
        switch (hubEvent.eventName) {
          case "SIGNED_IN":
            {
              _authStateController.add(AuthSuccess());
            }
            break;
          case "SIGNED_OUT":
            {
              _authStateController.add(AuthRequired());
            }
            break;
          case "SESSION_EXPIRED":
            {
              _authStateController.add(AuthRequired());
            }
            break;
          default:
            _authStateController.add(AuthRequired());
        }
      });
    } on AmplifyAlreadyConfiguredException {
      StateError(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  Future<bool> register(
      {required String email, required String password}) async {
    Map<String, String> _userAttributes = {
      'email': email,
    };
    SignUpResult res = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: _userAttributes));
    return res.isSignUpComplete;
  }

  Future<bool> confirmRegister(String email, String code) async {
    SignUpResult res = await Amplify.Auth.confirmSignUp(
      username: email,
      confirmationCode: code,
    );
    return res.isSignUpComplete;
  }

  Future<bool> signIn(String email, String password) async {
    SignInResult res = await Amplify.Auth.signIn(
      username: email,
      password: password,
    );
    return res.isSignedIn;
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
