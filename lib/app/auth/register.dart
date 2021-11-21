import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/auth/confirm_register.dart';
import 'package:weather_app/app/auth/message_dialog.dart';
import 'package:weather_app/repository/auth_repository.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
    TextFormField password1 = TextFormField(
      controller: TextEditingController(),
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (String? value) {
        if (value == null) {
          return 'Password can not be null';
        }
        if (value.length < 3) {
          return 'Password length should be greater that 3';
        }
        return null;
      },
    );
    TextFormField password2 = TextFormField(
      controller: TextEditingController(),
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password again',
      ),
      validator: (String? value) {
        if (password1.controller!.text != value) {
          return 'Passwords do not match!';
        }
        if (value == null) {
          return 'Password can not be null';
        }
        if (value.length < 3) {
          return 'Password length should be greater that 3';
        }
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(),
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
                  'Register',
                  style: TextStyle(fontSize: 32),
                ),
                email,
                password1,
                password2,
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        var result = await AuthRepository().register(
                          email: email.controller!.text,
                          password: password1.controller!.text,
                        );
                        if (result) {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmRegisterPage(
                                username: email.controller!.text,
                              ),
                            ),
                          );
                          if (res) {
                            Navigator.pop(context);
                          }
                        }
                      } on AuthException catch (e) {
                        showMessageDialog(context, e.message,
                            e.recoverySuggestion ?? 'Please try again');
                      }
                    }
                  },
                  child: const Text('Register', style: TextStyle(fontSize: 18)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
