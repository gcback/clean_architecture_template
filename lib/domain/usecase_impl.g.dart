// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usecase_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$useCaseImplHash() => r'e15ca738b47723df25e5620dfd7aad2f6a06faaf';

///
////// 비즈니스 로직 구현에 필요한 repository instance를 만든다.
///   repository interface의 specification은 domain layer에서 정의하기 때문에
///   domain layer는 data layer에 대해 독립적이다.
///
///
/// Copied from [UseCaseImpl].
@ProviderFor(UseCaseImpl)
final useCaseImplProvider =
    AutoDisposeNotifierProvider<UseCaseImpl, UseCaseImpl>.internal(
  UseCaseImpl.new,
  name: r'useCaseImplProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$useCaseImplHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UseCaseImpl = AutoDisposeNotifier<UseCaseImpl>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
