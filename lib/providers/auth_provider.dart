import 'package:auth_demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    auth = FirebaseAuth.instance;
  }

  FirebaseAuth auth;

  //getting the model object
  UserModel _userModel = UserModel();

  UserModel get userModel => _userModel;

  //register user with email and password method
  Future<void> registerWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
      _userModel = UserModel.fromDocument(userCredential);
      print(email);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //login user with email and password method
  Future<void> loginWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
      _userModel = UserModel.fromDocument(userCredential);
      print(email);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //logout current user
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
