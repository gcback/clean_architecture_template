import 'user.dart';

abstract class RepositoryIface {
  Future<UserList> get(int id, int count);

  Future<UserList> next();
  
  Future<bool> add(User user);
  
  Future<bool> remove(int id);
}
