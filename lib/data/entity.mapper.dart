// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'entity.dart';

class UserEntityMapper extends ClassMapperBase<UserEntity> {
  UserEntityMapper._();

  static UserEntityMapper? _instance;
  static UserEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserEntity';

  static int _$no(UserEntity v) => v.no;
  static const Field<UserEntity, int> _f$no = Field('no', _$no);
  static String _$name(UserEntity v) => v.name;
  static const Field<UserEntity, String> _f$name = Field('name', _$name);
  static String _$email(UserEntity v) => v.email;
  static const Field<UserEntity, String> _f$email = Field('email', _$email);
  static String _$description(UserEntity v) => v.description;
  static const Field<UserEntity, String> _f$description =
      Field('description', _$description);
  static String _$pic(UserEntity v) => v.pic;
  static const Field<UserEntity, String> _f$pic = Field('pic', _$pic);
  static String _$updated(UserEntity v) => v.updated;
  static const Field<UserEntity, String> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<UserEntity> fields = const {
    #no: _f$no,
    #name: _f$name,
    #email: _f$email,
    #description: _f$description,
    #pic: _f$pic,
    #updated: _f$updated,
  };

  static UserEntity _instantiate(DecodingData data) {
    return UserEntity(data.dec(_f$no), data.dec(_f$name), data.dec(_f$email),
        data.dec(_f$description), data.dec(_f$pic), data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static UserEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserEntity>(map);
  }

  static UserEntity fromJson(String json) {
    return ensureInitialized().decodeJson<UserEntity>(json);
  }
}

mixin UserEntityMappable {
  String toJson() {
    return UserEntityMapper.ensureInitialized()
        .encodeJson<UserEntity>(this as UserEntity);
  }

  Map<String, dynamic> toMap() {
    return UserEntityMapper.ensureInitialized()
        .encodeMap<UserEntity>(this as UserEntity);
  }

  UserEntityCopyWith<UserEntity, UserEntity, UserEntity> get copyWith =>
      _UserEntityCopyWithImpl(this as UserEntity, $identity, $identity);
  @override
  String toString() {
    return UserEntityMapper.ensureInitialized()
        .stringifyValue(this as UserEntity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UserEntityMapper.ensureInitialized()
                .isValueEqual(this as UserEntity, other));
  }

  @override
  int get hashCode {
    return UserEntityMapper.ensureInitialized().hashValue(this as UserEntity);
  }
}

extension UserEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserEntity, $Out> {
  UserEntityCopyWith<$R, UserEntity, $Out> get $asUserEntity =>
      $base.as((v, t, t2) => _UserEntityCopyWithImpl(v, t, t2));
}

abstract class UserEntityCopyWith<$R, $In extends UserEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? no,
      String? name,
      String? email,
      String? description,
      String? pic,
      String? updated});
  UserEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserEntity, $Out>
    implements UserEntityCopyWith<$R, UserEntity, $Out> {
  _UserEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserEntity> $mapper =
      UserEntityMapper.ensureInitialized();
  @override
  $R call(
          {int? no,
          String? name,
          String? email,
          String? description,
          String? pic,
          String? updated}) =>
      $apply(FieldCopyWithData({
        if (no != null) #no: no,
        if (name != null) #name: name,
        if (email != null) #email: email,
        if (description != null) #description: description,
        if (pic != null) #pic: pic,
        if (updated != null) #updated: updated
      }));
  @override
  UserEntity $make(CopyWithData data) => UserEntity(
      data.get(#no, or: $value.no),
      data.get(#name, or: $value.name),
      data.get(#email, or: $value.email),
      data.get(#description, or: $value.description),
      data.get(#pic, or: $value.pic),
      data.get(#updated, or: $value.updated));

  @override
  UserEntityCopyWith<$R2, UserEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserEntityCopyWithImpl($value, $cast, t);
}
