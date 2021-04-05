import 'package:auth_demo/providers/auth_provider.dart';
import 'package:auth_demo/views/login_screen.dart';
import 'package:auth_demo/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}

class SignInPage extends StatelessWidget {
  //TODO: Google Sign In
  Future<void> _navigateToRegisterWithEmail(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => AuthProvider(),
                  child: RegisterScreen(),
                ),
            fullscreenDialog: true));
  }

  Future<void> _navigateToLoginWithEmail(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => AuthProvider(),
                  child: LoginScreen(),
                ),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Welcome Page'),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 200, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 32.0),
            //button for google
            SizedBox(height: 8),
            ElevatedButton(
              child: Text('Register with email and password'),
              onPressed: () => _navigateToRegisterWithEmail(context),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: TextButton(
                onPressed: () => _navigateToLoginWithEmail(context),
                //sign in with email and password
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(color: Colors.indigo),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
