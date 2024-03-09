import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/user.dart';
import '../domain/repository_iface.dart';

import 'entity.dart';
import 'source_iface.dart';
import 'source_remote.dart';

part 'repository_impl.g.dart';

enum SourceType {
  remote,
  localdb,
  mock,
}

@riverpod
class RepositoryImpl extends _$RepositoryImpl implements RepositoryIface {
  late SourceRemote client;

  @override
  RepositoryImpl build() => RepositoryImpl();

  @override
  Future<UserList> get(int id, int count) async {
    final source = ref.watch(sourceProvider);

    try {
      final userMaps = await source.get(id, count);

      if (userMaps case {'items': var list}) {
        final users = [
          for (var item in list) UserEntity.fromMap(item).toModel,
        ];

        return users;
      }
    } catch (e) {
      rethrow;
    }

    return <User>[];
  }

  @override
  Future<bool> add(User user) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(int id) async {
    return ref.watch(sourceProvider).remove(id);
  }

  @override
  Future<UserList> next() {
    throw UnimplementedError();
  }
}
