import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/exceptions.dart';
import '../domain/profile.dart';
import '../domain/repository_iface.dart';

import 'entity.dart';
import 'source_iface.dart';

part 'repository_impl.g.dart';

enum SourceType {
  remote,
  localdb,
  mock,
}

final sourceProvider =
    Provider((ref) => DataSource.client(type: SourceType.remote));

/// RepositoryImpl는 DataSource에 대한 인스턴스를 런타임에 결정할 수 있기 때문에 외부에
///   추상성을 제공한다. 그리고 실제 data 처리를 수행하는 data source에대한 gateway 역할이다.
///
@riverpod
class RepositoryImpl extends _$RepositoryImpl implements RepositoryIface {
  late DataSource? _source;
  DataSource get source =>
      _source ?? (throw DataLayerException('Source not ready!'));

  @override
  RepositoryImpl build() {
    _source = ref.watch(sourceProvider);

    return RepositoryImpl();
  }

  @override
  Future<ProfileList> get(int id, int count) async {
    try {
      final userMaps = await source.get(id, count);

      if (userMaps case {'items': var list}) {
        final users = [
          for (var item in list) ProfileEntity.fromMap(item).toModel,
        ];

        return users;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileList> next() {
    throw UnimplementedError();
  }

  @override
  Future<bool> add(Profile user) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(int id) async {
    return _source!.remove(id);
  }
}
