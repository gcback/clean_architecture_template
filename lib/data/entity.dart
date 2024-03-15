import 'package:dart_mappable/dart_mappable.dart';

import '../domain/user.dart';

part 'entity.mapper.dart';

@MappableClass()
class UserEntity with UserEntityMappable {
  final int no;
  final String name;
  final String email;
  final String description;
  final String pic;
  final String updated;

  const UserEntity(
      this.no, this.name, this.email, this.description, this.pic, this.updated);

  static const fromMap = UserEntityMapper.fromMap;

  /// Mapper of Entity to Model
  ///  - source로부터 받은 raw data(entity)를 model 데이터로 변환
  ///  * presentation layer(view, viewmodel)는 data layer로부터 독립된다.
  User get toModel => User(
        no,
        name,
        email,
        description,
        pic,
        DateTime.parse(updated),
      );

  factory UserEntity.fromModel(User user) => UserEntity(
        user.no,
        user.name,
        user.email,
        user.desc,
        user.pic,
        user.updated.toIso8601String(),
      );
}
