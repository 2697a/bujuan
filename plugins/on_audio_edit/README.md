# on_audio_edit
<!-- https://img.shields.io/badge/Platform-Android%20%7C%20IOS-9cf?&style=flat-square -->
[![Pub.dev](https://img.shields.io/pub/v/on_audio_edit?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_edit)
[![Platform](https://img.shields.io/badge/Platform-Android-9cf?logo=android&style=flat-square)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Language-Flutter%20%7C%20Null--Safety-9cf?logo=flutter&style=flat-square)](https://www.flutter.dev/)
[![Kotlin](https://img.shields.io/badge/Language-Kotlin-9cf?logo=kotlin&style=flat-square)](https://kotlinlang.org/)

`on_audio_edit` is a [Flutter](https://flutter.dev/) Plugin used to edit and read audios/songs 🎶 infos/tags [Mp3, OggVorbis, Wav, etc...]. <br>

This Plugin use [AdrienPoupa:jaudiotagger](https://github.com/AdrienPoupa/jaudiotagger) as dependency to edit audios tags.

## Help:

**Any problem? [Issues](https://github.com/LucJosin/on_audio_edit/issues)** <br>
**Any suggestion? [Pull request](https://github.com/LucJosin/on_audio_edit/pulls)**

### Translations:

NOTE: Feel free to help with readme translations

* [English](README.md)
* [Portuguese](README.pt-BR.md)

### Topics:

<!-- * [Gif Examples](#gif-examples) -->
* [How to Install](#how-to-install)
* [How to use](#how-to-use)
* [TagsType](#tagstype)
* [Examples](#examples)
* [License](#license)

## How to Install:
Add the following code to your `pubspec.yaml`:
```yaml
dependencies:
  on_audio_edit: ^1.5.1
```

#### Request Permission:
You will need add the following code to your `AndroidManifest.xml` <br>
**Note: This Plugin don't have a built-in request permission**
```xml
<manifest> ...

  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

</manifest>
```

#### Legacy External Storage:
If you are using/want to use `Android 10` will need add the following code to your `AndroidManifest.xml` <br>
```xml
<application> ...

  android:requestLegacyExternalStorage="true"

</application>
```

## Some Features:

* Read Audios/Songs tags.
* Edit Audios/Songs tags.
* **Supports Android 10 and above**.

## TODO:

* Add better performance for all plugin.
* Add `[deleteArtwork]` to Android 10 and above.
* Add `[deleteArtworks]` to Android 10 and above.
* Add `[deleteAudio]` to Android 10 and above.
* Fix bugs.

## How to use:

```dart
OnAudioEdit() // The main method to start using the plugin.
```
All types of methods on this plugin:

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

**[Q]** -> Only necessary on Android 10 or above. <br>
**[W]** -> These methods are currently only implemented on Android 9 or below.

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

## Examples:

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

## LICENSE:

* [LICENSE](https://github.com/LucJosin/on_audio_edit/blob/main/LICENSE)

> * [Back to top](#on_audio_edit)

