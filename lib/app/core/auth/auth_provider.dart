import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_provider/app/services/user/user_services.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserServices _userServices;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserServices userServices,
  })  : _firebaseAuth = firebaseAuth,
        _userServices = userServices;

  Future<void> logout() {
    return _userServices.logout();
  }

  User? get user => _firebaseAuth.currentUser;

  //Ficar escutando o firebase ao longo da aplicação
  void loadListener() {
    _firebaseAuth.userChanges().listen((event) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
