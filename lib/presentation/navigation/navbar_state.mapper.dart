// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'navbar_state.dart';

class BottomNavStateMapper extends ClassMapperBase<BottomNavState> {
  BottomNavStateMapper._();

  static BottomNavStateMapper? _instance;
  static BottomNavStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BottomNavStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BottomNavState';

  static bool _$visible(BottomNavState v) => v.visible;
  static const Field<BottomNavState, bool> _f$visible =
      Field('visible', _$visible);
  static int _$currentIdx(BottomNavState v) => v.currentIdx;
  static const Field<BottomNavState, int> _f$currentIdx =
      Field('currentIdx', _$currentIdx);
  static int _$previousIdx(BottomNavState v) => v.previousIdx;
  static const Field<BottomNavState, int> _f$previousIdx =
      Field('previousIdx', _$previousIdx);

  @override
  final MappableFields<BottomNavState> fields = const {
    #visible: _f$visible,
    #currentIdx: _f$currentIdx,
    #previousIdx: _f$previousIdx,
  };

  static BottomNavState _instantiate(DecodingData data) {
    return BottomNavState(
        visible: data.dec(_f$visible),
        currentIdx: data.dec(_f$currentIdx),
        previousIdx: data.dec(_f$previousIdx));
  }

  @override
  final Function instantiate = _instantiate;

  static BottomNavState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BottomNavState>(map);
  }

  static BottomNavState fromJson(String json) {
    return ensureInitialized().decodeJson<BottomNavState>(json);
  }
}

mixin BottomNavStateMappable {
  String toJson() {
    return BottomNavStateMapper.ensureInitialized()
        .encodeJson<BottomNavState>(this as BottomNavState);
  }

  Map<String, dynamic> toMap() {
    return BottomNavStateMapper.ensureInitialized()
        .encodeMap<BottomNavState>(this as BottomNavState);
  }

  BottomNavStateCopyWith<BottomNavState, BottomNavState, BottomNavState>
      get copyWith => _BottomNavStateCopyWithImpl(
          this as BottomNavState, $identity, $identity);
  @override
  String toString() {
    return BottomNavStateMapper.ensureInitialized()
        .stringifyValue(this as BottomNavState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BottomNavStateMapper.ensureInitialized()
                .isValueEqual(this as BottomNavState, other));
  }

  @override
  int get hashCode {
    return BottomNavStateMapper.ensureInitialized()
        .hashValue(this as BottomNavState);
  }
}

extension BottomNavStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BottomNavState, $Out> {
  BottomNavStateCopyWith<$R, BottomNavState, $Out> get $asBottomNavState =>
      $base.as((v, t, t2) => _BottomNavStateCopyWithImpl(v, t, t2));
}

abstract class BottomNavStateCopyWith<$R, $In extends BottomNavState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? visible, int? currentIdx, int? previousIdx});
  BottomNavStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BottomNavStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BottomNavState, $Out>
    implements BottomNavStateCopyWith<$R, BottomNavState, $Out> {
  _BottomNavStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BottomNavState> $mapper =
      BottomNavStateMapper.ensureInitialized();
  @override
  $R call({bool? visible, int? currentIdx, int? previousIdx}) =>
      $apply(FieldCopyWithData({
        if (visible != null) #visible: visible,
        if (currentIdx != null) #currentIdx: currentIdx,
        if (previousIdx != null) #previousIdx: previousIdx
      }));
  @override
  BottomNavState $make(CopyWithData data) => BottomNavState(
      visible: data.get(#visible, or: $value.visible),
      currentIdx: data.get(#currentIdx, or: $value.currentIdx),
      previousIdx: data.get(#previousIdx, or: $value.previousIdx));

  @override
  BottomNavStateCopyWith<$R2, BottomNavState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BottomNavStateCopyWithImpl($value, $cast, t);
}
