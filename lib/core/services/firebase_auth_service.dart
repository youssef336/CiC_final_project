import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysterybag/core/errors/exception.dart';
import 'package:mysterybag/core/services/main/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;
  late User clinet;
  @override
  Future<User> loginUser(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      clinet = credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException(
          message:
              " User with this email doesn't exist, please create an account",
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          message:
              "Incorrect password, please check your password and try again",
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "Please check your internet connection");
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: "Please enter a valid email address");
      } else {
        throw CustomException(
          message: "An error occurred while logging in, please try again later",
        );
      }
    }
    return clinet;
  }

  @override
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw CustomException(message: "Email already in use");
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "Please check your internet connection");
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: "Please enter a valid email address");
      } else {
        throw CustomException(
          message: "An error occurred while signing up, please try again later",
        );
      }
    }
  }
}

bool isUserLoggedIn() {
  return FirebaseAuth.instance.currentUser != null;
}
