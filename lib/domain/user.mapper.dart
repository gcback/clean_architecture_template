// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static int _$no(User v) => v.no;
  static const Field<User, int> _f$no = Field('no', _$no);
  static String _$name(User v) => v.name;
  static const Field<User, String> _f$name = Field('name', _$name);
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email = Field('email', _$email);
  static String _$desc(User v) => v.desc;
  static const Field<User, String> _f$desc = Field('desc', _$desc);
  static String _$pic(User v) => v.pic;
  static const Field<User, String> _f$pic = Field('pic', _$pic);
  static DateTime _$updated(User v) => v.updated;
  static const Field<User, DateTime> _f$updated = Field('updated', _$updated);

  @override
  final MappableFields<User> fields = const {
    #no: _f$no,
    #name: _f$name,
    #email: _f$email,
    #desc: _f$desc,
    #pic: _f$pic,
    #updated: _f$updated,
  };

  static User _instantiate(DecodingData data) {
    return User(data.dec(_f$no), data.dec(_f$name), data.dec(_f$email),
        data.dec(_f$desc), data.dec(_f$pic), data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJson(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJson() {
    return UserMapper.ensureInitialized().encodeJson<User>(this as User);
  }

  Map<String, dynamic> toMap() {
    return UserMapper.ensureInitialized().encodeMap<User>(this as User);
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper.ensureInitialized().stringifyValue(this as User);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UserMapper.ensureInitialized().isValueEqual(this as User, other));
  }

  @override
  int get hashCode {
    return UserMapper.ensureInitialized().hashValue(this as User);
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? no,
      String? name,
      String? email,
      String? desc,
      String? pic,
      DateTime? updated});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  $R call(
          {int? no,
          String? name,
          String? email,
          String? desc,
          String? pic,
          DateTime? updated}) =>
      $apply(FieldCopyWithData({
        if (no != null) #no: no,
        if (name != null) #name: name,
        if (email != null) #email: email,
        if (desc != null) #desc: desc,
        if (pic != null) #pic: pic,
        if (updated != null) #updated: updated
      }));
  @override
  User $make(CopyWithData data) => User(
      data.get(#no, or: $value.no),
      data.get(#name, or: $value.name),
      data.get(#email, or: $value.email),
      data.get(#desc, or: $value.desc),
      data.get(#pic, or: $value.pic),
      data.get(#updated, or: $value.updated));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl($value, $cast, t);
}
