import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysterybag/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> loginUser(String email, String password);
  Future<Either<Failure, void>> signUpUser({
    required String name,
    required String email,
    required String password,
  });
}
