import 'profile.dart';

/// repository interface의 specification은 domain layer에서 정의한다.
///   따라서 이 interface를 구현하는 data(repository) layer는 domain에 종속된다.
abstract interface class RepositoryIface {
  Future<ProfileList> get(int id, int count);

  Future<ProfileList> next();

  Future<bool> add(Profile user);

  Future<bool> remove(int id);
}
