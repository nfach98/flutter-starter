// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailNotifierHash() => r'76ae628a5c23cd3b23510390f355a5227534142f';

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

abstract class _$DetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Post?> {
  late final int id;

  FutureOr<Post?> build(
    int id,
  );
}

/// See also [DetailNotifier].
@ProviderFor(DetailNotifier)
const detailNotifierProvider = DetailNotifierFamily();

/// See also [DetailNotifier].
class DetailNotifierFamily extends Family<AsyncValue<Post?>> {
  /// See also [DetailNotifier].
  const DetailNotifierFamily();

  /// See also [DetailNotifier].
  DetailNotifierProvider call(
    int id,
  ) {
    return DetailNotifierProvider(
      id,
    );
  }

  @override
  DetailNotifierProvider getProviderOverride(
    covariant DetailNotifierProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailNotifierProvider';
}

/// See also [DetailNotifier].
class DetailNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DetailNotifier, Post?> {
  /// See also [DetailNotifier].
  DetailNotifierProvider(
    int id,
  ) : this._internal(
          () => DetailNotifier()..id = id,
          from: detailNotifierProvider,
          name: r'detailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailNotifierHash,
          dependencies: DetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              DetailNotifierFamily._allTransitiveDependencies,
          id: id,
        );

  DetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<Post?> runNotifierBuild(
    covariant DetailNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(DetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailNotifier, Post?>
      createElement() {
    return _DetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DetailNotifierRef on AutoDisposeAsyncNotifierProviderRef<Post?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _DetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailNotifier, Post?>
    with DetailNotifierRef {
  _DetailNotifierProviderElement(super.provider);

  @override
  int get id => (origin as DetailNotifierProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
