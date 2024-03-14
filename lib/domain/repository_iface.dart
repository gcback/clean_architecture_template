import 'user.dart';

///   repository interface의 specification은 domain layer에서 정의한다.
abstract interface class RepositoryIface {
  Future<UserList> get(int id, int count);

  Future<UserList> next();

  Future<bool> add(User user);

  Future<bool> remove(int id);
}
