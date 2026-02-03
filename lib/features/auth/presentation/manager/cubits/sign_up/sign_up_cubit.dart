// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:mysterybag/features/auth/domain/repo/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;
  SignUpCubit(this.authRepo) : super(SignUpInitial());

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    final result = await authRepo.signUpUser(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(SignUpError(failure.message)),
      (_) => emit(SignUpSuccess()),
    );
  }
}
