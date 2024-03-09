import 'user.dart';

/// usecases
///   presentation layer는 usecase에서 정의한 interfaces를 이용한다.
interface class UserUseCase1 {
  Future<void> nextUsers() async {
    throw UnimplementedError();
  }

  Future<bool> add(User user) async {
    throw UnimplementedError();
  }

  Future<void> remove(int id) async {
    throw UnimplementedError();
  }
}

interface class UserUseCase2 {
  Future exception() async {
    throw UnimplementedError();
  }
}
