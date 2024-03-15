import 'entity.dart';
import 'repository_impl.dart';
import 'source_mock.dart';
import 'source_remote.dart';

/// Repository가 상위계층에 데이터 추상성을 제공할수 있도록 base interface를 정의한다.
///   DataSource의 구현체는 모두 Repository의 런타임 인스턴스로 사용할 수 있다.
/// 즉, remote data, local db, mockdb 등 data source를 변경하더라고 
///   doamin, presentation layer의 코드에 영향을 주지 않는다.
abstract interface class DataSource {
  Future<Map> get(int id, int count);

  Future<bool> add(UserEntity rawUser);

  Future<bool> remove(int id);

  factory DataSource.client({required SourceType type}) => switch (type) {
        == SourceType.remote => SourceRemote(),
        _ => SourceMock(),
      };
}
