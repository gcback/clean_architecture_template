import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/exceptions.dart';
import '../domain/user.dart';
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
    Provider((ref) => DataSource.client(type: SourceType.localdb));

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
  Future<UserList> get(int id, int count) async {
    try {
      final userMaps = await source.get(id, count);

      if (userMaps case {'items': var list}) {
        final users = [
          for (var item in list) UserEntity.fromMap(item).toModel,
        ];

        return users;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserList> next() {
    throw UnimplementedError();
  }

  @override
  Future<bool> add(User user) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(int id) async {
    return _source!.remove(id);
  }
}
