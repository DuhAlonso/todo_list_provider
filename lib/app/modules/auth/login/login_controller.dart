import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/services/user/user_services.dart';

class LoginController extends DefaultChangeNotifier {
  final UserServices _userServices;
  String? infoMessage;

  LoginController({required UserServices userServices})
      : _userServices = userServices;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userServices.login(email, password);
      if (user != null) {
        success();
      } else {
        setError('E=mail e/ou senha incorreto(s).');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userServices.forgotPassword(email);
      infoMessage = 'Acesse o seu e-mail e veja como recuperar a senha';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar a senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userServices.googleLogin();
      if (user != null) {
        success();
      } else {
        _userServices.googleLogout();
        setError('Erro ao logar com o Google');
      }
    } on AuthException catch (e) {
      _userServices.googleLogout();

      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
