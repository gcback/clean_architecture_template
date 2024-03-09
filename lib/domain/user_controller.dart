import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user.dart';
import 'user_usecase.dart';
import '../data/repository_impl.dart';

part 'user_controller.g.dart';

// view에서 data가 필요하면 수동으로 가져온다
//   --> usecase의 interface를 호출한다. --> usecase impl이 repository interface를 호출한다.
// view가 domain을 observe한다.

// data가 들어어면
//

@riverpod
class Users extends _$Users implements UserUseCase1 {
  @override
  Future<UserCollection> build() async {
    final repository = ref.read(repositoryImplProvider.notifier);

    final users = await repository.get(1, 2);

    return (total: users.length, users: users);
  }

  @override
  Future<void> get(int id, int count) async {
    final repository = ref.read(repositoryImplProvider.notifier);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final value = state.value!;

      final users = await repository.get(id, count);
      return (
        total: value.total + users.length,
        users: <User>[...value.users, ...users],
      );
    });
  }

  @override
  Future<void> add(User user) async {
    final repository = ref.read(repositoryImplProvider.notifier);

    repository.add(user);
  }

  @override
  Future<void> remove(int id) async {
    final repository = ref.read(repositoryImplProvider.notifier);

    state = await AsyncValue.guard(() async {
      final UserCollection(:users) = state.value!;

      await repository.remove(id);

      final updatedList = [
        for (final user in users)
          if (user.no != id) user
      ];

      return (total: updatedList.length, users: updatedList);
    });
  }

  @override
  Future<void> next() async {
    final repository = ref.read(repositoryImplProvider.notifier);

    state = await AsyncValue.guard(() async {
      final UserCollection(:total, :users) = state.value!;

      final nextUsers = await repository.get(total + 1, 2);
      if (nextUsers case final nextUsers) {
        return (
          total: total + nextUsers.length,
          users: <User>[...users, ...nextUsers],
        );
      }
    });
  }
}
