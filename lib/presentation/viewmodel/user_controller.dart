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
    ///
    /// domain layer의 usecase에 의존하는 것이 아니라 
    ///    단순히 usecase interface의 구현체를 가져온다.
    _usecaseInterface = ref.watch(useCaseImplProvider.notifier);

    final users = await usecase.get(1, 5);

    return (total: users.length, users: users);
  }

  ///
  /// 여기에 정의된 method들은 View ux 처리를 위한 view 고유 로직들이 포함된다.
  ///  data 의존적인 로직은 domain의 usecase interface를 사용해야 하며 
  /// data layer의 interface를 직접 사용하지 않는다. 이렇게 하면 domain 계층 뿐만 아니라 presentation, data 계층간의 
  ///   의존성도 줄일수 있다.

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
