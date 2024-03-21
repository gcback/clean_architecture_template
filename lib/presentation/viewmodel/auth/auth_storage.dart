abstract class AuthPersistance {
  Future set(String key, String value);
  String? get(String key);
  Future remove(String key);
}
