import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/auth/message_dialog.dart';
import 'package:weather_app/repository/auth_repository.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextFormField email = TextFormField(
      controller: TextEditingController(),
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
      validator: (String? value) {
        if (value != null && !value.contains('@')) {
          return 'Please enter a valid email address.';
        }
        return null;
      },
    );
    TextFormField password = TextFormField(
      controller: TextEditingController(),
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (String? value) {
        if (value == null) {
          return 'Password can not be null';
        }
        if (value.length < 3 ) {
          return 'Password length should be greater that 3';
        }
        return null;
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 32),
                ),
                email,
                password,
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'register'),
                      child: const Text('Register',
                          style: TextStyle(fontSize: 18)),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await AuthRepository().signIn(
                                email.controller!.text,
                                password.controller!.text);
                          } on AuthException catch (e) {
                            showMessageDialog(context, e.message,
                                e.recoverySuggestion ?? 'Please try again');
                          }
                        }
                      },
                      child:
                          const Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
