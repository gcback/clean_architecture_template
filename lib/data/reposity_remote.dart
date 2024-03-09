import '../common/exceptions.dart';

import '../domain/user.dart';
import 'entity.dart';
import 'remote_source.dart';
import 'repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Source source;

  UserRepositoryImpl(this.source);

  @override
  Future<User> user(int no) async {
    try {
      final response = await source.fetch(no, perPage: 0);
      if (response case {'items': [var item]}) {
        return UserEntity.fromMap(item).toModel;
      }
    } catch (e) {
      throw DataLayerException(e.toString());
    }

    throw DataLayerException('No User to display');
  }

  @override
  Future<UserList> users(int no) async {
    try {

      final response = await source.fetch(no, perPage: 5);
      if (response case {'items': var list}) {
        return [
          for (var item in list) UserEntity.fromMap(item).toModel,
        ];
      }
    } catch (e) {
      throw DataLayerException(e.toString());
    }

    throw DataLayerException('No User to display');
  }

  @override
  Future<bool> add(User user) async {
    final rawUser = UserEntity.fromModel(user);

    return await source.add(rawUser);
  }
}
