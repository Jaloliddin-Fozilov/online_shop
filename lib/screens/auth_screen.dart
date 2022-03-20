import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

enum AuthMode { Register, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;

  final _passwordController = TextEditingController();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  void _submit() {
    if (_formKey.currentState!.validate()) {
      // save form
      _formKey.currentState!.save();
      if (_authMode == AuthMode.Login) {
        // login user
      } else {
        //  register user
        print(_authData['emal']!);
        print(_authData['password']!);
        Provider.of<Auth>(context, listen: false).signup(
          _authData['emal']!,
          _authData['password']!,
        );
      }
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                '../assets/images/logo.png',
                fit: BoxFit.cover,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email manzil',
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Iltimos email manzil kiriting';
                  } else if (!email.contains('@')) {
                    return 'Iltimos, to\'g\'ri email kiriting';
                  }
                },
                onSaved: (email) {
                  _authData['email'] = email!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Parol',
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Parolni kiriting';
                  } else if (password.length < 6) {
                    return 'Parol 5ta symbol ko\'p bo\'lishi kerak';
                  }
                },
                controller: _passwordController,
                onSaved: (password) {
                  _authData['password'] = password!;
                },
                obscureText: true,
              ),
              if (_authMode == AuthMode.Register)
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Parolni tasdiqlang',
                      ),
                      obscureText: true,
                      validator: (confirmedPassword) {
                        if (_passwordController.text != confirmedPassword) {
                          return 'Iltimos, parolingizni to\'g\'ri kiting.';
                        }
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authMode == AuthMode.Login
                      ? 'KIRISH'
                      : 'RO\'YXATDAN O\'TISH',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _authMode == AuthMode.Login
                      ? 'RO\'YXATDAN O\'TISH'
                      : 'KIRISH',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
