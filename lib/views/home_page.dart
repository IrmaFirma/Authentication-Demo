import 'package:auth_demo/providers/auth_provider.dart';
import 'package:auth_demo/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  void logout(BuildContext context, AuthProvider authProvider) async {
    await authProvider.logout().then((_) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => WelcomePageBuilder())));
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => logout(context, _authProvider),
          )
        ],
      ),
    );
  }
}
