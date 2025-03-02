// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartListHash() => r'4e003437ca7a71c6c78ce5871b4a478ab9f81a72';

/// See also [CartList].
@ProviderFor(CartList)
final cartListProvider =
    AutoDisposeNotifierProvider<CartList, List<CartItem>>.internal(
  CartList.new,
  name: r'cartListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CartList = AutoDisposeNotifier<List<CartItem>>;
String _$cartMutationHash() => r'8d91a4827ce9a20ec9ba90a86b8c944b42e40eb5';

/// See also [CartMutation].
@ProviderFor(CartMutation)
final cartMutationProvider =
    AutoDisposeAsyncNotifierProvider<CartMutation, void>.internal(
  CartMutation.new,
  name: r'cartMutationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartMutationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CartMutation = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
