import 'package:auth_demo/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login({BuildContext context, AuthProvider authProvider}) {
    try {
      final FormState _formState = _formKey.currentState;
      if (_formState.validate()) {
        authProvider
            .loginWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
                context: context)
            .then((_) => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (context) => AuthProvider(), child: HomePage()))));
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In with Email and Password'),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: 'cocu@cocu.com'),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  ElevatedButton(
                    child: Text('Sign In'),
                    onPressed: () {
                      return login(
                          context: context, authProvider: _authProvider);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
