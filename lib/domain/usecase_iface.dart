import 'dart:async';

import 'user.dart';

/// usecases
///   presentation layer는 usecase에서 정의한 interfaces를 이용한다.
abstract interface class UseCase1 {
  Future<UserList> get(int id, int count); // => throw UnimplementedError();
  Future<UserList> next(); // throw UnimplementedError();
  Future<void> add(User user); // throw UnimplementedError();
  Future<void> remove(int id); // throw UnimplementedError();
}
