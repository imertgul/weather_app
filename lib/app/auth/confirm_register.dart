import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/auth/message_dialog.dart';
import 'package:weather_app/repository/auth_repository.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ConfirmRegisterPage extends StatelessWidget {
  final String username;
  const ConfirmRegisterPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextFormField confirmationCode = TextFormField(
      controller: TextEditingController(),
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Confirmation Code',
      ),
      validator: (String? value) {
        if (value == null) {
          return 'Password can not be null';
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
                Text(
                  'Confirm your account for: $username',
                  style: const TextStyle(fontSize: 24),
                ),
                confirmationCode,
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        var res = await AuthRepository().confirmRegister(
                            username, confirmationCode.controller!.text);
                        if (res) {
                          Navigator.pop(context, true);
                        }
                      } on AuthException catch (e) {
                        showMessageDialog(context, e.message,
                            e.recoverySuggestion ?? 'Please try again');
                      }
                    }
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
