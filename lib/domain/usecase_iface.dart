import 'dart:async';

import 'profile.dart';

/// domain 내부의 biz logics들과 presentation layer는 usecase에서 정의한 interfaces를 이용한다.
abstract interface class UseCase1 {
  Future<ProfileList> get(int id, int count); // => throw UnimplementedError();
  Future<ProfileList> next(); // throw UnimplementedError();
  Future<void> add(Profile profile); // throw UnimplementedError();
  Future<void> remove(int id); // throw UnimplementedError();
}
