import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_storage.dart';

part 'auth_storage_shared_preference.g.dart';

@riverpod
class SharedPreferencePersistance extends _$SharedPreferencePersistance
    implements AuthPersistance {
  late SharedPreferences persistance;

  @override
  Future<AuthPersistance> build() async {
    persistance = await SharedPreferences.getInstance();

    return SharedPreferencePersistance();
  }

  @override
  Future remove(String key) {
    return persistance.remove(key);
  }

  @override
  Future set(String key, String value) {
    return persistance.setString(key, value);
  }

  @override
  String? get(String key) {
    return persistance.getString(key);
  }
}
