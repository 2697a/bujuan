## [1.5.1] - [02.10.2022]
### Fixes
- **[Fixed]** error when reading a flac file with others files.. - Thanks [@SimoneBressan](https://github.com/SimoneBressan)

### Documentation
- Updated `README` documentation.

## [1.5.0] - [01.21.2022]
### Features
- **[Added]** `separateThread` parameter to `[readAudios]`. Now you can change the `thread` when reading the audios. - Thanks [@SimoneBressan](https://github.com/SimoneBressan)

### Changes
- **[Updated]** all Github links.

## [1.4.0+1] - [10.26.2021]
### Fixes
- **[Fixed]** wrong value returning from `[getUri]`.

### Documentation
- Updated `README` documentation.

## [1.4.0] - [10.26.2021]
### Features
- **[Added]** `original` parameter to `[getUri]`. Now you can get a `original` or `modified` path. - [#10](https://github.com/LucasPJS/on_audio_edit/issues/10)

### Fixes
- **[Fixed]** error when trying to read a `Flac` file. - [#11](https://github.com/LucasPJS/on_audio_edit/issues/11)
- **[Fixed]** error when trying to read a file without `artwork`. - [#12](https://github.com/LucasPJS/on_audio_edit/issues/12)

### Documentation
- Updated `README` documentation.

## [1.3.0] - [10.23.2021]
### Features
- **[Added]** `[getUri]` used to retrive the user selected folder path. - [#10](https://github.com/LucasPJS/on_audio_edit/issues/10)

### Fixes
- **[Fixed]** wrong value returning from String parameters when using any `read` method that require `[AudioModel]`. - [#9](https://github.com/LucasPJS/on_audio_edit/issues/9)

### Documentation
- Updated `README` documentation.

## [1.2.0] - [10.22.2021]
### Features
- **[Added]** option to search inside all folders when using `[editAudio]` on Android 10 or above. - [#5](https://github.com/LucasPJS/on_audio_edit/issues/5)
- **[Added]** `ALL` possible tag type.
- **[Added]** `ALL` possible getter to `[AudioModel]`.
- **[Created]** `[ImageModel]`.

### Fixes
- **[Fixed]** no ALBUM tag in TagType. - [#2](https://github.com/LucasPJS/on_audio_edit/issues/2)
- **[Fixed]** bug with permission methods. - [#4](https://github.com/LucasPJS/on_audio_edit/issues/4)

### Documentation
- Updated `README` documentation.

### Changes
#### Dart
- Changed `[readAudio]`, `[readAllAudio]` and `[readSpecificsAudioTags]` return type from `Map` to `AudioModel`.

### ⚠ Important Changes
#### Dart
- Now `[getImage]` a `[ImageModel]`. - [#1](https://github.com/LucasPJS/on_audio_edit/issues/1)
- Now `[readAudio]`, `[readAllAudio ]` and  `[readSpecificsAudioTags]` return type from `Map` to `AudioModel`.

#### @Deprecated
- `[readAllAudio]`.
    - Use `[readAudio]` instead.
- `[getImagePath]`.
    - Use `[getImage]` instead.
- `[id]` from `[AudioModel]`.

## [1.1.0] - [10.20.2021]
### Features
#### Dart
- **[Added]** `getMap` to `AudioModel`.
- **[Added]** a [`DART ANALYZER`](https://github.com/axel-op/dart-package-analyzer/) to `PULL_REQUEST` and `PUSH`.

### Documentation
- Updated `README` documentation.
- Updated dependences.
- Updated `OnAudioEdit` and `OnAudioEditExample` documentation to support new `[Flutter 2.5]`.
- Created `DEPRECATED` file/history.

### Changes
#### Dart
- Changed from `[AudiosTagModel]` to `[AudioModel]`.
- Removed `[IOS]` from `[pubspec]`.

### ⚠ Important Changes
#### Dart
- Deprecated `[AudiosTagModel]` from `[AudioModel]`.

## [1.0.2] - [04.20.2021]
### Features
#### Dart/Kotlin
- Added `[deleteArtwork]`, `[deleteArtworks]` and `[deleteAudio]` **[Currently only on Android 9 or below.]**.
- Added `[BITRATE]`, `[FORMAT]`, `[SAMPLE_RATE]`, `[CHANNELS]`, `[COVER_ART]`, `[TYPE]`, `[FIRST_ARTWORK]` to `[TagType]` and `[AudiosTagModel]`.

### Fixes
#### Kotlin
- Some fixes

### Changes
#### Dart/Kotlin
- Changed `[TagsType]` to `[TagType]`.
- Removed `[ID]` from `[TagType]`.

### Documentation
- Updated `README` documentation.

## [1.0.0] - [04.18.2021]
### Release

- `[on_audio_edit]` release.

## [0.2.0] - [04.16.2021]
### Features
#### Dart/Kotlin
- Added `[editArtwork]` and `[editAllAudio]`.
- Added `[resetComplexPermission]`.
- Added `[getImagePath]`.
- Added `[LENGTH]` to `[TagsType]`.

### Fixes
#### Kotlin
- Some fixes

### Documentation
- Updated `README` documentation.

## [0.1.5] - [04.13.2021]
### Features
#### Dart/Kotlin
- Added `[editAudio]`, `[editAudios]`, `[readSingleAudioTag]` and `[readSpecificsAudioTags]`.
- Added `[editAudio]` and `[editAudios]`.
- Added `[permissionsStatus]`, `[complexPermissionStatus]` and `[requestComplexPermission]`.
- Added `[TagsType]`.

#### Extra
- Now supports `[Android 10]` and above.

### Documentation
- Updated `README` documentation.
- Updated `pubspec.yaml`.
- Created `README` translation section.
- Created `README` translation for `pt-BR` [Portuguese].

## [0.0.1] - [04.12.2021]
### Features
#### Dart/Kotlin
- Created the base for the plugin.

<!-- 
## [Version] - [Date]
### Features
- TODO

### Fixes
- TODO

### Documentation
- TODO

### Changes
- TODO

### ⚠ Important Changes
#### @**Deprecated**
- TODO
 -->

<!-- 
 https://github.com/LucasPJS/on_audio_edit/issues/
 - **[Added]** (Text)- [#Issue](Link)
 - **[Fixed]** (Text)- [#Issue](Link)
 - **[Changed]** (Text)- [#Issue](Link)
-->