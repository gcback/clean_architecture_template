import 'entity.dart';
import 'source_iface.dart';

class SourceMock implements DataSource {
  SourceMock._();
  static final _instance = SourceMock._();

  factory SourceMock() => _instance;
  static get instance => _instance;

  ////

  @override
  Future<Map> get(int no, int count) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> add(ProfileEntity rawUser) {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(int id) {
    throw UnimplementedError();
  }
}
