import 'package:get_it/get_it.dart';
import 'package:mysterybag/core/services/database_servies.dart';
import 'package:mysterybag/core/services/firebase_auth_services.dart';
import 'package:mysterybag/core/services/firestore_services.dart';
import 'package:mysterybag/features/auth/data/repos/auth_repo_implemtation.dart';
import 'package:mysterybag/features/auth/domains/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<FirebaseAuthServices>(
    () => FirebaseAuthServices(),
  );
  getIt.registerLazySingleton<DatabaseServies>(() => FirestoreServices());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplemtation(
      databaseServies: getIt<DatabaseServies>(),
      firebaseAuthServices: getIt<FirebaseAuthServices>(),
    ),
  );
}
