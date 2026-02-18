// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(playlistDetail)
const playlistDetailProvider = PlaylistDetailFamily._();

final class PlaylistDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlaylistData>,
          PlaylistData,
          FutureOr<PlaylistData>
        >
    with $FutureModifier<PlaylistData>, $FutureProvider<PlaylistData> {
  const PlaylistDetailProvider._({
    required PlaylistDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'playlistDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$playlistDetailHash();

  @override
  String toString() {
    return r'playlistDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PlaylistData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlaylistData> create(Ref ref) {
    final argument = this.argument as int;
    return playlistDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$playlistDetailHash() => r'df5707822af7a5c41c22328e35250a47f798948f';

final class PlaylistDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PlaylistData>, int> {
  const PlaylistDetailFamily._()
    : super(
        retry: null,
        name: r'playlistDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaylistDetailProvider call(int id) =>
      PlaylistDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'playlistDetailProvider';
}
