import 'dart:convert';

import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/features/auth/data/models/user_model.dart';
import 'package:mysterybag/features/auth/domains/entities/user_entity.dart';

UserEntity getUser() {
  final jsonString = Prefs.getString(KUserData);
  if (jsonString.isEmpty) {
    return UserModel(
      id: 'dev-checkout-preview',
      name: 'Preview',
      email: 'preview@local.test',
    );
  }
  try {
    final decoded = jsonDecode(jsonString);
    if (decoded is Map<String, dynamic>) {
      return UserModel.fromJson(decoded);
    }
  } catch (_) {
    // Invalid stored user (e.g. fresh install while skipping splash)
  }
  return UserModel(
    id: 'dev-checkout-preview',
    name: 'Preview',
    email: 'preview@local.test',
  );
}
