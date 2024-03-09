import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user.dart';
import '../data/repository.dart';
import 'user_usecase.dart';

part 'user_controller.g.dart';

// view에서 data가 필요하면 수동으로 가져온다
//   --> usecase의 interface를 호출한다. --> usecase impl이 repository interface를 호출한다.
// view가 domain을 observe한다.

// data가 들어어면
//

// abstract class RepositoryIface {
//   void user() {}
//   void addUser() {}
//   void remove() {}
//   void update() {}
// }

// @riverpod
// class Repository extends _$Repository implements RepositoryIface {
//   @override
//   void build() {}
// }

@riverpod
class Users extends _$Users implements UserUseCase1 {
  @override
  Future<UserCollection> build() async {
    final repository = ref.watch(usersRepositoryProvider);

    final users = await repository.users(0);
    if (users case final users) {
      return (
        total: users.length,
        users: users,
      );
    }
  }

  @override
  Future<void> nextUsers() async {
    final repository = ref.watch(usersRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final value = state.value!;

      final users = await repository.users(value.total);
      if (users case final users) {
        return (
          total: value.total + users.length,
          users: <User>[...value.users, ...users],
        );
      }
    });
  }

  @override
  Future<bool> add(User user) async {
    final repository = ref.watch(usersRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final value = state.value!;

      final result = await repository.add(user);

      if (!result) return value;

      return (
        total: value.total + 1,
        users: <User>[...value.users, user],
      );
    });

    return true;
  }

  /// business logics, interface는 UserUseCase를 따른다.
  ///
  @override
  Future exception() async {
    try {
      state = AsyncValue.error(Exception('테스트 오류'), StackTrace.current);
      // state = const AsyncValue.data((total: 0, users: []));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(int id) async {
    final UserCollection(:users) = state.value!;

    final updatedList = [
      for (final user in users)
        if (user.no != id) user
    ];

    print('remove: count=${updatedList.length}');

    state = AsyncValue.data((total: updatedList.length, users: updatedList));
  }
}
