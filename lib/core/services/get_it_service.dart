import 'package:get_it/get_it.dart';
import 'package:mysterybag/core/services/firebase_auth_service.dart';
import 'package:mysterybag/core/services/main/auth_service.dart';
import 'package:mysterybag/features/auth/data/repo/auth_repo_impl.dart';
import 'package:mysterybag/features/auth/domain/repo/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthService>()),
  );
}
