import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/exceptions.dart';
import '../../domain/user.dart';
import '../../domain/usecase_impl.dart';

part 'user_controller.g.dart';

@riverpod
class Users extends _$Users {
  late UseCaseImpl? _usecaseInterface;
  UseCaseImpl get usecase =>
      _usecaseInterface ??
      (throw PresentationLayerException('Usecase not ready!'));

  @override
  Future<UserCollection> build() async {
    _usecaseInterface = ref.watch(useCaseImplProvider.notifier);

    final users = await usecase.get(1, 5);

    return (total: users.length, users: users);
  }

  Future<void> get(int id, int count) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final value = state.value!;

      final users = await usecase.get(id, count);
      return (
        total: value.total + users.length,
        users: <User>[...value.users, ...users],
      );
    });
  }

  Future<void> add(User user) async {
    usecase.add(user);
  }

  Future<void> remove(int id) async {
    state = await AsyncValue.guard(() async {
      final UserCollection(:users) = state.value!;

      await usecase.remove(id);

      final updatedList = [
        for (final user in users)
          if (user.no != id) user
      ];

      return (total: updatedList.length, users: updatedList);
    });
  }

  Future<void> next() async {
    state = await AsyncValue.guard(() async {
      final UserCollection(:total, :users) = state.value!;

      final nextUsers = await usecase.get(total + 1, 10);
      if (nextUsers case final nextUsers) {
        return (
          total: total + nextUsers.length,
          users: <User>[...users, ...nextUsers],
        );
      }
    });
  }
}
