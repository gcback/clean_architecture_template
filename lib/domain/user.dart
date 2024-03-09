import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

/// presentation, domain이 관심있는 model을 정의한다.
///   --> domain, data layers 관심사는 data layer의 entity와 mapper에서 정의한다.
@MappableClass()
class User with UserMappable {
  final int no;
  final String name;
  final String email;
  final String desc;
  final String pic;
  final DateTime updated;

  const User(this.no, this.name, this.email, this.desc, this.pic, this.updated);
}

typedef UserList = List<User>;
typedef UserCollection = ({int total, UserList users});
