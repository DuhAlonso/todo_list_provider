import 'package:firebase_auth/firebase_auth.dart';

abstract class UserServices {
  Future<User?> register(String email, String password);
}
