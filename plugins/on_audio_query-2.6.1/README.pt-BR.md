# on_audio_query
[![Pub.dev](https://img.shields.io/pub/v/on_audio_query?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_query)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20IOS%20%7C%20Web-9cf?&style=flat-square)]()
[![Languages](https://img.shields.io/badge/Language-Dart%20%7C%20Kotlin%20%7C%20Swift-9cf?&style=flat-square)]()

`on_audio_query` é um [Flutter](https://flutter.dev/) Plugin usado para adquirir informações de áudios/músicas 🎶 [título, artista, album, etc..] do celular. <br>

## Ajuda:

**Algum problema? [Issues](https://github.com/LucJosin/on_audio_query/issues)** <br>
**Alguma sugestão? [Pull request](https://github.com/LucJosin/on_audio_query/pulls)**

### Extensões:

* [on_audio_edit](https://github.com/LucJosin/on_audio_edit) - Usado para editar audio metadata.
* [on_audio_room](https://github.com/LucJosin/on_audio_room) - Usado para guardar audio [Favoritos, Mais tocados, etc..].

### Traduções:

NOTE: Fique à vontade para ajudar nas traduções

* [Inglês](README.md)
* [Português](README.pt-BR.md)

## Tópicos:

* [Como instalar](#como-instalar)
* [Plataformas](#platformas)
* [Como usar](#como-usar)
* [Exemplos](#exemplos)
* [Exemplos em Gif](#exemplos-em-gif)
* [Licença](#licença)

## Platformas:

<!-- ✔️ | ❌ -->
|  Methods  |   Android   |   IOS   |   Web   |
|-------|:----------:|:----------:|:----------:|
| `querySongs` | `✔️` | `✔️` | `✔️` | <br>
| `queryAlbums` | `✔️` | `✔️` | `✔️` | <br>
| `queryArtists` | `✔️` | `✔️` | `✔️` | <br>
| `queryPlaylists` | `✔️` | `✔️` | `❌` | <br>
| `queryGenres` | `✔️` | `✔️` | `✔️` | <br>
| `queryAudiosFrom` | `✔️` | `✔️` | `✔️` | <br>
| `queryWithFilters` | `✔️` | `✔️` | `✔️` | <br>
| `queryArtwork` | `✔️` | `✔️` | `✔️` | <br>
| `createPlaylist` | `✔️` | `✔️` | `❌` | <br>
| `removePlaylist` | `✔️` | `❌` | `❌` | <br>
| `addToPlaylist` | `✔️` | `✔️` | `❌` | <br>
| `removeFromPlaylist` | `✔️` | `❌` | `❌` | <br>
| `renamePlaylist` | `✔️` | `❌` | `❌` | <br>
| `moveItemTo` | `✔️` | `❌` | `❌` | <br>
| `permissionsRequest` | `✔️` | `✔️` | `❌` | <br>
| `permissionsStatus` | `✔️` | `✔️` | `❌` | <br>
| `queryDeviceInfo` | `✔️` | `✔️` | `✔️` | <br>
| `scanMedia` | `✔️` | `❌` | `❌` | <br>

✔️ -> Tem suporte <br>
❌ -> Não tem suporte <br>

**[Veja todos os suportes](https://github.com/LucJosin/on_audio_query/blob/main/on_audio_query/PLATFORMS.md)**

## Como instalar:
Adicione o seguinte codigo para seu `pubspec.yaml`:
```yaml
dependencies:
  on_audio_query: ^2.6.0
```

#### Solicitar Permissões:
#### Android:
Para usar esse plugin adicione o seguinte código no seu `AndroidManifest.xml`
```xml
<manifest> ...

  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

</manifest>
```

#### IOS:
Para usar esse plugin adicione o seguinte código no seu `Info.plist`
```plist
	<key>NSAppleMusicUsageDescription</key>
	<string>..Adicione um motivo..</string>
```

#### Web:
Já que os navegadores **não** oferecem acesso direto ao `file system` dos usuários, esse plugin irá usar a pasta `assets` para "pegar" os audios. Então, dependerá totalmente do `desenvolvedor`.

```yaml
  # Você não precisa adicionar todos os audios, apenas defina a pasta.
  assets:
    - assets/
    # Se seus arquivos estão em outra pasta dentro de `assets`:
    - assets/audios/
    # - assets/audios/animals/
    # - assets/audios/animals/cat/
    # ...
```

## Algumas qualidades:

* Opcional e Interna solicitação de permissão para `LER` e `ESCREVER`.
* Pega todos os áudios.
* Pega todos os albums e áudios específicos dos albums.
* Pega todos os artistas e áudios específicos dos artistas.
* Pega todas as playlists e áudios específicos das playlists.
* Pega todos os gêneros e áudios específicos dos gêneros.
* Pega todos os métodos de query com `keys` específicas [Search/Busca].
* Pega todos as pastas e áudios específicos das pastas.
* Criar/Deletar/Renomear playlists.
* Adicionar/Remover/Mover específicos áudios para playlists.
* Específicos tipos de classificação para todos os métodos.

## Para fazer:

* Adicionar uma melhor performace para todo o plugin.
* Adicionar suporte para Windows/MacOs/Linux.
* Opção para remover músicas.
* Arrumar erros.

## Como usar:

```dart
OnAudioQuery() // O comando principal para usar o plugin.
```
Todos os tipos de métodos nesse plugin:

### Query methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`querySongs`](#querysongs) | `(SortType, OrderType, UriType, RequestPermission)` | `List<SongModel>` | <br>
| [`queryAlbums`](#queryalbums) | `(SortType, OrderType, UriType, RequestPermission)` | `List<AlbumModel>` | <br>
| [`queryArtists`](#queryartists) | `(SortType, OrderType, UriType, RequestPermission)` | `List<ArtistModel>` | <br>
| [`queryPlaylists`](#queryplaylists) | `(SortType, OrderType, UriType, RequestPermission)` | `List<PlaylistModel>` | <br>
| [`queryGenres`](#querygenres) | `(SortType, OrderType, UriType, RequestPermission)` | `List<GenreModel>` | <br>
| [`queryAudiosFrom`](#queryaudiosfrom) | `(Type, Where, RequestPermission)` | `List<SongModel>` | <br>
| [`queryWithFilters`](#queryWithFilters) | `(ArgsVal, WithFiltersType, Args, RequestPermission)` | `List<dynamic>` | <br>
| [`queryArtwork`](#queryArtwork) | `(Id, Type, Format, Size, RequestPermission)` | `Uint8List?` | <br>

### Playlist methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`createPlaylist`]() | `(PlaylistName, RequestPermission)` | `bool` | <br>
| [`removePlaylist`]() | `(PlaylistId, RequestPermission)` | `bool` | <br>
| [`addToPlaylist`]() | **[BG]**`(PlaylistId, AudioId, RequestPermission)` | `bool` | <br>
| [`removeFromPlaylist`]() | `(PlaylistId, AudioId, RequestPermission)` | `bool` | <br>
| [`renamePlaylist`]() | `(PlaylistId, NewName, RequestPermission)` | `bool` | <br>
| [`moveItemTo`]() | **[NT]**`(PlaylistId, From, To, RequestPermission)` | `bool` | <br>

### Permissions/Device methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`permissionsRequest`]() | `(retryRequest)` | `bool` | <br>
| [`permissionsStatus`]() |  | `bool` | <br>
| [`queryDeviceInfo`]() |  | `DeviceModel` | <br>

### Others methods
|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`scanMedia`](#scanmedia) | `(Path)` | `bool` | <br>

### Artwork Widget

```dart
  Widget someOtherName() async {
    return QueryArtworkWidget(
      id: SongId, 
      type: ArtworkType.AUDIO,
    );
  }
```

**Veja mais: <a href="https://pub.dev/documentation/on_audio_query/latest/on_audio_query/QueryArtworkWidget-class.html" target="_blank">QueryArtworkWidget</a>**

### Abreviações

**[NT]** -> Precisa de testes <br>
**[BG]** -> Bug no Android 10/Q

## Exemplos:

#### OnAudioQuery
```dart
  final OnAudioQuery _audioQuery = OnAudioQuery();
```

#### querySongs
```dart
  someName() async {
    // DEFAULT: 
    // SongSortType.TITLE, 
    // OrderType.ASC_OR_SMALLER,
    // UriType.EXTERNAL, 
    List<SongModel> something = await _audioQuery.querySongs();
  }
```

#### queryAlbums
```dart
  someName() async {
    // DEFAULT: 
    // AlbumSortType.ALBUM, 
    // OrderType.ASC_OR_SMALLER 
    List<AlbumModel> something = await _audioQuery.queryAlbums();
  }
```

#### queryArtists
```dart
  someName() async {
    // DEFAULT: 
    // ArtistSortType.ARTIST, 
    // OrderType.ASC_OR_SMALLER 
    List<ArtistModel> something = await _audioQuery.queryArtists();
  }
```

#### queryPlaylists
```dart
  someName() async {
    // DEFAULT: 
    // PlaylistSortType.NAME, 
    // OrderType.ASC_OR_SMALLER 
    List<PlaylistModel> something = await _audioQuery.queryPlaylists();
  }
```

#### queryGenres
```dart
  someName() async {
    // DEFAULT: 
    // GenreSortType.NAME, 
    // OrderType.ASC_OR_SMALLER 
    List<GenreModel> something = await _audioQuery.queryGenres();
  }
```

#### scanMedia
Você irá usar esse método quando atualizar uma media do armazenamento. Esse método irá atualizar o 'estado' da mídia e
o Android `MediaStore` irá saber esse 'estado'.
```dart
  someName() async {
    OnAudioQuery _audioQuery = OnAudioQuery();
    File file = File('path');
    try {
      if (file.existsSync()) {
        file.deleteSync();
        _audioQuery.scanMedia(file.path); // Atualiza o 'caminho' da mídia
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
```

#### queryArtwork
```dart
  someName() async {
    // DEFAULT: ArtworkFormat.JPEG, 200 and false
    Uint8List something = await _audioQuery.queryArtwork(
        SongId, 
        ArtworkType.AUDIO, 
        ...,
    );
  }
```

Ou você pode usar um Widget básico e customizável.
**Veja o exemplo [QueryArtworkWidget](#artwork-widget)**

#### queryAudiosFrom
Você pode usar esse método para 'pegar' as músicas de qualquer seção(Album, Artista, Playlist or Gênero). 
```dart
  someName() async {
    List<SongModel> something = await _audioQuery.queryAudiosFrom(
        AudiosFromType.ALBUM_ID, 
        albumId,
        // Você pode também definir um tipo de classificação.
        sortType: SongSortType.TITLE, // Default
        orderType: OrderType.ASC_OR_SMALLER, // Default
      );
  }
```

#### queryWithFilters
```dart
  someName() async {
    // Aqui nós iremos pesquisar por uma [música](WithFiltersType.AUDIOS) usando o seu 
    // [artista](AudiosArgs.ARTIST)
    List<dynamic> something = await _audioQuery.queryWithFilters(
        // O [texto] para pesquisar
        "Sam Smith", 
        // O tipo de pesquisa que você quer.
        // Todos os tipos:
        //   * WithFiltersType.AUDIOS
        //   * WithFiltersType.ALBUMS
        //   * WithFiltersType.PLAYLISTS
        //   * WithFiltersType.ARTISTS
        //   * WithFiltersType.GENRES
        WithFiltersType.AUDIOS,
        // Este método possui [args] como parâmetro. Com este valor você pode criar
        // uma pesquisa mais 'avançada'.
        args: AudiosArgs.ARTIST,
    );

    // Outro exemplo:

    // Aqui nós iremos pesquisar por uma [música](WithFiltersType.AUDIOS) usando o seu
    // [album](AudiosArgs.ALBUM)
    List<dynamic> something = await _audioQuery.queryWithFilters(
        // O [texto] para pesquisar
        "In the Lonely Hour", 
        // O tipo de pesquisa que você quer.
        // Todos os tipos:
        //   * WithFiltersType.AUDIOS
        //   * WithFiltersType.ALBUMS
        //   * WithFiltersType.PLAYLISTS
        //   * WithFiltersType.ARTISTS
        //   * WithFiltersType.GENRES
        WithFiltersType.AUDIOS,
        // Este método possui [args] como parâmetro. Com este valor você pode criar
        // uma pesquisa mais 'avançada'.
        args: AudiosArgs.ALBUM,
    );

    // Depois de adquirir o resultado do [queryWithFilters], converta para uma lista usando:
    List<TypeModel> convertedList = something.toTypeModel();

    // Exemplo:
    List<SongModel> convertedSongs = something.toSongModel(); 
  }
```

ArgsTypes: [AudiosArgs](https://pub.dev/documentation/on_audio_query_platform_interface/latest/on_audio_query_helper/AudiosArgs-class.html), [AlbumsArgs](https://pub.dev/documentation/on_audio_query_platform_interface/latest/on_audio_query_helper/AlbumsArgs-class.html), [PlaylistsArgs](https://pub.dev/documentation/on_audio_query_platform_interface/latest/on_audio_query_helper/PlaylistsArgs-class.html), [ArtistsArgs](https://pub.dev/documentation/on_audio_query_platform_interface/latest/on_audio_query_helper/ArtistsArgs-class.html) and [GenresArgs](https://pub.dev/documentation/on_audio_query_platform_interface/latest/on_audio_query_helper/GenresArgs-class.html)

## Exemplos em Gif:
| <img src="https://user-images.githubusercontent.com/76869974/112378123-522c1a00-8cc5-11eb-880d-ba67706c415d.gif"/> | <img src="https://user-images.githubusercontent.com/76869974/112378181-62dc9000-8cc5-11eb-8cb3-c8db71372fa9.gif"/> | <img src="https://user-images.githubusercontent.com/76869974/112378214-6e2fbb80-8cc5-11eb-996a-d61bb8a620ca.gif"/> | <img src="https://user-images.githubusercontent.com/76869974/112378250-7687f680-8cc5-11eb-94a1-ea91868d119c.gif"/> |
|:---:|:---:|:---:|:---:|
| <img src="https://user-images.githubusercontent.com/76869974/129763885-c0cb3871-39af-45fa-aebf-ebf4113effa2.gif"/> | <img src="https://user-images.githubusercontent.com/76869974/129763519-497cab72-6a95-42fd-8237-3f83e954ea50.gif"/> | <img src="https://user-images.githubusercontent.com/76869974/129763577-9037d16f-f940-4bcb-ba37-879a0eecf2ac.gif"/> | <img src="https://user-images.githubusercontent.com/76869974/129763551-726512a9-bc10-4c75-a167-8928f0c0c212.gif"/> |
| Músicas | Albums | Playlists | Artistas |

## LICENÇA:

* [LICENSE](https://github.com/LucJosin/on_audio_query/blob/main/on_audio_query/LICENSE)

> * [Voltar ao Topo](#on_audio_query)
