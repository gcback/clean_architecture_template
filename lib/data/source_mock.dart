import 'entity.dart';
import 'source_iface.dart';

class SourceMock implements DataSource {
  @override
  Future<Map> get(int no, int count) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> add(UserEntity rawUser) {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(int id) {
    throw UnimplementedError();
  }
}
