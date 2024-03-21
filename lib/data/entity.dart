import 'package:dart_mappable/dart_mappable.dart';

import '../domain/profile.dart';

part 'entity.mapper.dart';

@MappableClass()
class ProfileEntity with ProfileEntityMappable {
  final int no;
  final String name;
  final String email;
  final String description;
  final String pic;
  final String updated;

  const ProfileEntity(
      this.no, this.name, this.email, this.description, this.pic, this.updated);

  static const fromMap = ProfileEntityMapper.fromMap;

  /// Mapper of Entity to Model
  ///  - source로부터 받은 raw data(entity)를 model 데이터로 변환
  ///  * presentation layer(view, viewmodel)는 data layer로부터 독립된다.
  Profile get toModel => Profile(
        no,
        name,
        email,
        description,
        pic,
        DateTime.parse(updated),
      );

  factory ProfileEntity.fromModel(Profile profile) => ProfileEntity(
        profile.no,
        profile.name,
        profile.email,
        profile.desc,
        profile.pic,
        profile.updated.toIso8601String(),
      );
}
