import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exceptions/auth_exceptions.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message:
                  'E-mail já utilizado, tente fazer login ou escolha outro email.');
        } else {
          throw AuthException(
              message: 'Você já tem cadastro, tente logar com o Google.');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário.');
      }
    }
  }
}
