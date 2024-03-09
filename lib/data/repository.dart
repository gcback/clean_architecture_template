import 'package:mvvm/data/reposity_remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

import '../domain/user.dart';
import 'remote_source.dart';

part 'repository.g.dart';

enum SourceType {
  remote,
  localdb,
  mock,
}

abstract class UserRepository {
  Future<UserList> users(int no);
  Future<User> user(int no);
  Future<bool> add(User user);
}

@riverpod
UserRepositoryImpl usersRepository(UsersRepositoryRef ref) {
  final sourceClient = Source.client(type: SourceType.remote);

  return UserRepositoryImpl(sourceClient);
}
