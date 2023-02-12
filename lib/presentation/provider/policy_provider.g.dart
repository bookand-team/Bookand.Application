// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$PolicyStateNotifierHash() =>
    r'0ed94ade369408c291c07091d280ae53e0bb87a6';

/// See also [PolicyStateNotifier].
final policyStateNotifierProvider =
    AutoDisposeNotifierProvider<PolicyStateNotifier, PolicyModelBase>(
  PolicyStateNotifier.new,
  name: r'policyStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$PolicyStateNotifierHash,
);
typedef PolicyStateNotifierRef
    = AutoDisposeNotifierProviderRef<PolicyModelBase>;

abstract class _$PolicyStateNotifier
    extends AutoDisposeNotifier<PolicyModelBase> {
  @override
  PolicyModelBase build();
}
