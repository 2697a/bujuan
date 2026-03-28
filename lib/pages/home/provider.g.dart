// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(newAlbum)
const newAlbumProvider = NewAlbumProvider._();

final class NewAlbumProvider
    extends
        $FunctionalProvider<AsyncValue<HomeData>, HomeData, FutureOr<HomeData>>
    with $FutureModifier<HomeData>, $FutureProvider<HomeData> {
  const NewAlbumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newAlbumProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newAlbumHash();

  @$internal
  @override
  $FutureProviderElement<HomeData> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<HomeData> create(Ref ref) {
    return newAlbum(ref);
  }
}

String _$newAlbumHash() => r'06e26019e615f485df18970be7b57f1e0eeb4094';

@ProviderFor(recommendSongs)
const recommendSongsProvider = RecommendSongsProvider._();

final class RecommendSongsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MediaItem>>,
          List<MediaItem>,
          FutureOr<List<MediaItem>>
        >
    with $FutureModifier<List<MediaItem>>, $FutureProvider<List<MediaItem>> {
  const RecommendSongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recommendSongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recommendSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<MediaItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MediaItem>> create(Ref ref) {
    return recommendSongs(ref);
  }
}

String _$recommendSongsHash() => r'a095ca7deb5c0a1c1e9c5b205557d9366e6bffda';
