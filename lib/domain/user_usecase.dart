import 'dart:async';

import 'user.dart';

/// usecases
///   presentation layer는 usecase에서 정의한 interfaces를 이용한다.
abstract class UseCase1 {
  Future<void> get(int id, int count); // => throw UnimplementedError();
  Future<void> next(); // throw UnimplementedError();
  Future<void> add(User user); // throw UnimplementedError();
  Future<void> remove(int id); // throw UnimplementedError();
}
