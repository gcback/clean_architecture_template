import 'entity.dart';
import 'repository_impl.dart';
import 'source_mock.dart';
import 'source_remote.dart';

abstract interface class DataSource {
  Future<Map> get(int id, int count);

  Future<bool> add(UserEntity rawUser);

  Future<bool> remove(int id);

  factory DataSource.client({required SourceType type}) => switch (type) {
        == SourceType.remote => SourceRemote(),
        _ => SourceMock(),
      };
}
