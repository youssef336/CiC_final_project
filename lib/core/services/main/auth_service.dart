import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User> loginUser(String email, String password);
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  });
}
