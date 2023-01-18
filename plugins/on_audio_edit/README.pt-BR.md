# on_audio_edit
<!-- https://img.shields.io/badge/Platform-Android%20%7C%20IOS-9cf?&style=flat-square -->
[![Pub.dev](https://img.shields.io/pub/v/on_audio_edit?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_edit)
[![Platform](https://img.shields.io/badge/Platform-Android-9cf?logo=android&style=flat-square)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Language-Flutter%20%7C%20Null--Safety-9cf?logo=flutter&style=flat-square)](https://www.flutter.dev/)
[![Kotlin](https://img.shields.io/badge/Language-Kotlin-9cf?logo=kotlin&style=flat-square)](https://kotlinlang.org/)

`on_audio_edit` é um [Flutter](https://flutter.dev/) Plugin usado para editar e ler audios/songs 🎶 informações/tags [Mp3, OggVorbis, Wav, etc...]. <br>

Esse Plugin usa [AdrienPoupa:jaudiotagger](https://github.com/AdrienPoupa/jaudiotagger) como dependência para editar audios tags.

## Ajuda:

**Algum problema? [Issues](https://github.com/LucJosin/on_audio_edit/issues)** <br>
**Alguma sugestão? [Pull request](https://github.com/LucJosin/on_audio_edit/pulls)**

### Traduções :

NOTE: Fique à vontade para ajudar nas traduções

* [Inglês](README.md)
* [Português](README.pt-BR.md)

## Tópicos:

<!-- * [Gif Examples](#gif-examples) -->
* [Como instalar](#como-instalar)
* [Como usar](#como-usar)
* [TagsType](#tagstype)
* [Exemplos](#exemplos)
* [Licença](#licença)

## Como instalar:
Adicione o seguinte codigo para seu `pubspec.yaml`:
```yaml
dependencies:
  on_audio_edit: ^1.5.1
```

#### Solicitar Permissões:
Se você quer usar a solicitação de permissões interna, irá precisar adicionar os seguintes codigos para seu `AndroidManifest.xml` <br>
**Note: Esse Plugin não tem um sistema de permissão interno.**
```xml
<manifest> ...

  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

</manifest>
```

#### Legacy External Storage:
Se você está usando/quer usar `Android 10` irá precisar adicionar os seguintes codigos para seu `AndroidManifest.xml` <br>
```xml
<application> ...

  android:requestLegacyExternalStorage="true"

</application>
```

## Algumas qualidades:

* Ler Audios/Songs tags.
* Editar Audios/Songs tags.
* **Suporta o Android 10 e superior.**.

## Para fazer:

* Adicionar uma melhor performace para todo o plugin.
* Adicionar `[deleteArtwork]` para Android 10 e superior.
* Adicionar `[deleteArtworks]` para Android 10 e superior.
* Adicionar `[deleteAudio]` para Android 10 e superior.
* Arrumar erros.

## Como usar:

```dart
OnAudioEdit() // O comando principal para usar o plugin.
```
Todos os tipos de métodos nesse plugin:

### Read methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`readAudio`](#readaudio) | `(String)` | `AudioModel` | <br>
| [`readAudios`](#readaudios) | `(List<String>)` | `List<AudioModel>` | <br>
| [`readSingleAudioTag`](#readsingleaudiotag) | `(String, TagsType)` | `String` | <br>
| [`readSpecificsAudioTags`](#readspecificsaudiotags) | `(String, List<TagsType>)` | `AudioModel` | <br>

### Edit methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`editAudio`](#editaudio) | `(String, Map<TagsType, dynamic>)` | `bool` | <br>
| [`editAudios`](#editaudios) | `(List<String>, List<Map<TagsType, dynamic>>)` | `bool` | <br>
| [`editArtwork`](#editartwork) | `(String, bool, String, ArtworkFormat, int, String)` | `bool` | <br>

### Delete methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`deleteArtwork`]() | **[W]**`(String)` | `bool` | <br>
| [`deleteArtworks`]() | **[W]**`(List<String>)` | `bool` | <br>
| [`deleteAudio`]() | **[W]**`(String)` | `bool` | <br>

### Permission/Image methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`getImage`]() | `ArtworkFormat, Quality` | `ImageModel` | <br>
| [`permissionsStatus`]() |  | `bool` | <br>
| [`resetComplexPermission`]() | **[Q]** | `bool` | <br>
| [`requestComplexPermission`]() | **[Q]** | `bool` | <br>
| [`requestComplexPermission`]() | **[Q]** | `bool` | <br>

**[Q]** -> Apenas necessário no Android 10 ou superior.
**[W]** -> Esses métodos estão atualmente apenas implementados no Android 9 ou inferior.

## TagsType:

|  Types  |  Types  |  Types  |  Types  |  Types  |
|--------------|--------------|--------------|--------------|--------------|  
| `ALBUM_ARTIST` | `ORIGINAL_ARTIST` | `ORIGINAL_ALBUM` | `TRACK` | `FORMAT` | <br>
| `ARTIST` | `ORIGINAL_LYRICIST` | `LYRICS` | `TITLE` | `SAMPLE_RATE` | <br>
| `ARTISTS` | `ORIGINAL_YEAR` | `LANGUAGE` | `TEMPO` | `CHANNELS` | <br>
| `BEATS_PER_MINUTE` | `PRODUCER` | `KEY` | `TAGS` | `COVER_ART` | <br>
| `COMPOSER` | `QUALITY` | `ISRC` | `SUBTITLE` | `TYPE` | <br>
| `COUNTRY` | `RATING` | `FIRST_ARTWORK` | `LENGTH` | [`More`](https://github.com/LucJosin/on_audio_edit/blob/main/lib/details/types/tag_type.dart) | <br>
| `GENRE` | `RECORD_LABEL` | `YEAR` | `BITRATE` | <br>

## Exemplos:

#### OnAudioEdit
```dart
  final OnAudioEdit _audioEdit = OnAudioEdit();
```

#### readAudio
```dart
  // data: "/storage/1E65-6GH3/SomeMusic.mp3" or "/storage/someFolder/SomeMusic.mp3"
  AudioModel song = await _audioEdit.readAudio(data);
  String songTitle = song.title;
  String songArtist = song.artist ?? '<No Artist>';
```

#### readAudios
```dart
  List<String> allData = [data0, data1, data2];
  List<AudioModel> song = await _audioEdit.readAudios(allData);
  ...
  String songTitle1 = song[0].title;
  String songTitle2 = song[1].title;
  String songTitle3 = song[2].title;
```

#### readSingleAudioTag
```dart
  String title = await _audioEdit.readSingleAudioTag(data, TagsType.TITLE);
  print(title); // Ex: Heavy, California
  ...
  String artist = await _audioEdit.readSingleAudioTag(data, TagsType.ARTIST);
  print(artist); // Ex: Jungle
```

#### readSpecificsAudioTags
```dart
  List<TagsType> tags = [
    TagsType.TITLE,
    TagsType.ARTIST
  ];
  AudioModel songSpecifics = await _audioEdit.readSpecificsAudioTags(data, tags);
  ...
  String songTitle = songSpecifics.title;
  String songArtist = songSpecifics ?? '<No Artist>';
```

#### editAudio
```dart
  Map<TagsType, dynamic> tags = {
    TagsType.TITLE: "New Title",
    TagsType.ARTIST: "New Artist"
  };
  bool song = await _audioEdit.editAudio(data, tags);
  print(song); //True or False
```

#### editAudios
⚠ **Note: This method isn't implemented on Android 10 or above. Instead use: [editAudio](#editaudio)**
```dart
  // Tags
  List<<Map<TagsType, dynamic>> tags = [];
  Map<TagsType, dynamic> getTags = {
    TagsType.TITLE: "New Title",
    TagsType.ARTIST: "New Artist"
  };
  tags.add(getTags);

  // Songs data
  List<String> data;
  data.add(song1);
  data.add(song2);
  data.add(song3);
  bool result = await _audioEdit.editAudios(data, tags);
  print(result); //True or False
```

#### editArtwork
⚠ **Note: If openFilePicker is false, imagePath can't be null.**
```dart
  // Parameters: openFilePicker, imagePath, format, size, description
  // DEFAULT: true, null, ArtworkFormat.JPEG, 24, "artwork"
  bool song = await _audioEdit.editArtwork(data);
  print(song); //True or False
```

## LICENÇA:

* [LICENÇA  ](https://github.com/LucJosin/on_audio_edit/blob/main/LICENSE)

> * [Voltar ao Topo](#on_audio_edit)

