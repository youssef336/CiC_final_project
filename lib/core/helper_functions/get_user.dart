import 'dart:convert';

import 'package:mysterybag/constant.dart';
import 'package:mysterybag/core/services/shared_preferences_singletone.dart';
import 'package:mysterybag/features/auth/data/models/user_model.dart';
import 'package:mysterybag/features/auth/domains/entities/user_entity.dart';

UserEntity getUser() {
  // This function returns a UserEntity object with default values.
  var jsonString = Prefs.getString(KUserData);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}
