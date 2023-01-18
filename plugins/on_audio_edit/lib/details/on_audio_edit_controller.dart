/*
=============
Author: Lucas Josino
Github: https://github.com/LucJosin
Website: https://www.lucasjosino.com/
=============
Plugin/Id: on_audio_edit#3
Homepage: https://github.com/LucJosin/on_audio_edit
Pub: https://pub.dev/packages/on_audio_edit
License: https://github.com/LucJosin/on_audio_edit/blob/main/LICENSE
Copyright: © 2021, Lucas Josino. All rights reserved.
=============
*/

part of on_audio_edit;

///Interface and Main method for use on_audio_edit
class OnAudioEdit {
  //Dart <-> Kotlin communication
  static const String channelId = "com.lucasjosino.on_audio_edit";
  static const MethodChannel _channel = MethodChannel(channelId);

  /// Used to warn about tags that can't be modified.
  void _cannotModifiy(TagType tag) {
    switch (tag) {
      case TagType.BITRATE:
      case TagType.CHANNELS:
      // case TagType.FIRST_ARTWORK:
      case TagType.FORMAT:
      case TagType.TRACK_LENGTH:
      case TagType.SAMPLE_RATE:
      case TagType.ENCODING_TYPE:
        log('Cannot modifiy [$tag]. Removing tag');
        break;
      default:
        break;
    }
  }

  /// Used to return unique song info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find specific audio data.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   AudioModel song = await OnAudioEdit().readAudio(data);
  ///   String songTitle = song.title;
  ///   String songArtist = song.artist ?? <No Artist>;
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will send a warning.
  ///
  /// Use [permissionsStatus] to see permissions status.
  Future<AudioModel> readAudio(String data) async {
    final Map resultReadAudio = await _channel.invokeMethod("readAudio", {
      "data": data,
    });
    return AudioModel(resultReadAudio);
  }

  /// Used to return multiples songs info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [mainThread] if `true` execute code in separate thread.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   List<AudioModel> song = await OnAudioEdit().readAudios(allData);
  ///   ...
  ///   String songInfo = song[0].title;
  ///   String songInfo2 = song[1].title;
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  ///
  /// Use [permissionsStatus] to see permissions status.
  Future<List<AudioModel>> readAudios(
    List<String> data, {
    bool separateThread = false,
  }) async {
    final List<dynamic> resultReadAudio =
        await _channel.invokeMethod("readAudios", {
      "data": data,
      "separateThread": separateThread,
    });
    return resultReadAudio.map((e) => AudioModel(e)).toList();
  }

  /// Used to return unique song tag.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [tag] is use to specify what tag you want.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   String title = await OnAudioEdit().readSingleAudioTag(data, TagsType.TITLE);
  ///   print(title); // Ex: Heavy, California
  ///   ...
  ///   String artist = await OnAudioEdit().readSingleAudioTag(data, TagsType.ARTIST);
  ///   print(artist ?? <No Artist>); // Ex: Jungle
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  ///
  /// Use [permissionsStatus] to see permissions status.
  Future<String> readSingleAudioTag(String data, TagType tag) async {
    final String resultSingleAudioTag =
        await _channel.invokeMethod("readSingleAudioTag", {
      "data": data,
      "tag": tag.index,
    });
    return resultSingleAudioTag;
  }

  /// Used to return specifics tags from song.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [tags] is use to specify what tags you want.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   List<TagsType> tags = [
  ///     TagsType.TITLE,
  ///     TagsType.ARTIST,
  ///   ];
  ///   AudioModel songSpecifics = await OnAudioEdit().readSpecificsAudioTags(data, tags);
  ///   ...
  ///   String songTitle = songSpecifics.title;
  ///   String songArtist = songSpecifics.artist ?? <No Artist>;
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  ///
  /// Use [permissionsStatus] to see permissions status.
  Future<AudioModel> readSpecificsAudioTags(
      String data, List<TagType> tags) async {
    List<int> tagsIndex = [];
    for (var it in tags) {
      tagsIndex.add(it.index);
    }
    final Map<dynamic, dynamic> readSpecificsAudioTags =
        await _channel.invokeMethod("readSpecificsAudioTags", {
      "data": data,
      "tags": tagsIndex,
    });
    return AudioModel(readSpecificsAudioTags);
  }

  /// Used to edit song info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find specific audio data.
  /// * [tags] is used to define what tags and values you want edit.
  /// * [searchInsideFolders] is used for find specific audio data inside the
  /// folders. **(Only required when using Android 10 or above)**
  ///
  /// Usage:
  ///
  /// ```dart
  ///   Map<TagsType, dynamic> tags = {
  ///     TagsType.TITLE: "New Title",
  ///     TagsType.ARTIST: "New Artist"
  ///   };
  ///   bool song = await OnAudioEdit().editAudio(data, tags);
  ///   print(song); //True or False
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * This method return true if audio has edited or false if don't.
  ///
  /// **Warning:**
  /// * This method works normal in Android below 10,
  /// from Android 10 or above user will need to accept access in Folder.
  /// You can see this "Complex Permission" status using [complexPermissionStatus].
  ///
  /// * By default when calling this method will open a new screen to user choose a folder,
  /// but you can anticipate the request using [requestComplexPermission].
  /// The request status and folder permission will be saved as persistent but
  /// if user uninstall the app, this permission will be removed.
  Future<bool> editAudio(
    String data,
    Map<TagType, dynamic> tags, {
    bool? searchInsideFolders,
  }) async {
    Map<int, dynamic> finalTags = {};
    tags.forEach((key, value) {
      _cannotModifiy(key);
      finalTags[key.index] = value;
    });
    final bool resultEditAudio = await _channel.invokeMethod("editAudio", {
      "data": data,
      "tags": finalTags,
      "searchInsideFolders": searchInsideFolders ?? false,
    });
    return resultEditAudio;
  }

  /// Used to edit multiples songs info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [tags] is used to define what tags and values you want edit.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   // Tags
  ///   List Map TagsType, dynamic>> tags = [];
  ///   Map<TagsType, dynamic> getTags = {
  ///     TagsType.TITLE: "New Title",
  ///     TagsType.ARTIST: "New Artist"
  ///   };
  ///   tags.add(getTags);
  ///
  ///   // Songs data
  ///   List String> data;
  ///   data.add(song1);
  ///   data.add(song2);
  ///   data.add(song3);
  ///   bool result = await OnAudioEdit().editAudios(data, tags);
  ///   print(result); //True or False
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * This method return true if audio has edited or false if don't.
  ///
  /// Super Important:
  /// * This method works normal in Android below 10,
  /// from Android 10 or above user will need to accept access in Folder.
  /// You can see this "Complex Permission" status using [complexPermissionStatus].
  /// By default when calling this method will open a new screen to user choose a folder,
  /// but you can anticipate the request using [requestComplexPermission].
  /// The request status and folder permission will be saved as persistent but
  /// if user uninstall the app, this permission will be removed.
  Future<bool> editAudios(
    List<String> data,
    List<Map<TagType, dynamic>> tags,
  ) async {
    List<Map<int, dynamic>> finalList = [];
    for (var it1 in tags) {
      Map<int, dynamic> finalTags = {};
      it1.forEach((key, value) {
        _cannotModifiy(key);
        finalTags[key.index] = value;
      });
      finalList.add(finalTags);
    }
    final bool resultEditAudios = await _channel.invokeMethod("editAudios", {
      "data": data,
      "tags": finalList,
    });
    return resultEditAudios;
  }

  // Future<bool> editSingleAudioTag(String data, TagsType tag) async {
  //   final bool resultSingleAudioTag =
  //       await _channel.invokeMethod("editSingleAudioTag", {
  //     "data": data,
  //     "tag": tag,
  //   });
  //   return resultSingleAudioTag;
  // }

  /// Used to edit audio artwork.
  ///
  /// Parameters:
  ///
  /// * [data] is used to find multiples audios data.
  /// * [openFilePicker] is used to define if folder picker will be open to user choose image.
  /// * [imagePath] is used to define image path, only necessary if [openFilePicker] is false.
  /// * [format] is used to define image type: [PNG] or [JPEG].
  /// * [size] is used to define image quality.
  /// * [description] is used to define artwork description.
  /// * [searchInsideFolders] is used for find specific audio data inside the
  /// folders. **(Only required when using Android 10 or above)**
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * If return true edit works, else edit found a problem.
  /// * If [openFilePicker] is null, will be set to [true].
  /// * If [imagePath] is null, [openFilePicker] need to be true.
  /// * If [format] is null, will be set to [JPEG].
  /// * If [size] is null, will be set to [24].
  /// * If [description] is null, will be set to ["artwork"].
  Future<bool> editArtwork(
    String data, {
    bool? openFilePicker,
    String? imagePath,
    ArtworkFormat? format,
    int? size,
    String? description,
    bool? searchInsideFolders,
  }) async {
    assert(
        openFilePicker == false || imagePath == null,
        "Cannot change artwork image without image.\n"
        "Set [openFilePicker] to true or give [imagePath] a correct path");
    final bool resultEditArt = await _channel.invokeMethod("editArtwork", {
      "data": data,
      "type": format != null ? format.index : ArtworkFormat.JPEG.index,
      "size": size ?? 24,
      "description": description ?? "artwork",
      "openFilePicker": openFilePicker ?? true,
      "imagePath": imagePath,
      "searchInsideFolders": searchInsideFolders ?? false,
    });
    return resultEditArt;
  }

  /// Used to delete audio artwork.
  ///
  /// /// Parameter:
  ///
  /// * [data] is used to find multiples audios data.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 9 or below (later i will add support android 10).
  /// * If return true delete works, else delete found a problem.
  Future<bool> deleteArtwork(String data) async {
    final bool resultDeleteArt =
        await _channel.invokeMethod("deleteArtwork", {"data": data});
    return resultDeleteArt;
  }

  /// Used to delete multiples audios artworks.
  ///
  /// /// Parameter:
  ///
  /// * [data] is used to find multiples audios data.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 9 or below (later i will add support android 10).
  /// * If return true delete works, else delete found a problem.
  Future<bool> deleteArtworks(List<String> data) async {
    final bool resultDeleteArts = await _channel.invokeMethod(
      "deleteArtworks",
      {"data": data},
    );
    return resultDeleteArts;
  }

  /// Used to delete specific audio from device.
  ///
  /// /// Parameter:
  ///
  /// * [data] is used to find multiples audios data.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 9 or below (later i will add support android 10).
  /// * If return true delete works, else delete found a problem.
  Future<bool> deleteAudio(String data) async {
    final bool resultDelete = await _channel.invokeMethod(
      "deleteAudio",
      {"data": data},
    );
    return resultDelete;
  }

  /// Used to check Android permissions status.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * If return true [READ] and [WRITE] permissions is Granted, else [READ] and [WRITE] is Denied.
  Future<bool> permissionsStatus() async {
    final bool resultStatus = await _channel.invokeMethod("permissionsStatus");
    return resultStatus;
  }

  /// Used to check Complex Android permissions status.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 10 or above.
  /// * If return true Complex Permission is Granted, else Complex Permission is Denied.
  Future<bool> complexPermissionStatus() async {
    final bool resultStatusComplex = await _channel.invokeMethod(
      "complexPermissionStatus",
    );
    return resultStatusComplex;
  }

  /// Used to request Complex Android permissions.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 10 or above.
  /// * If return true, Complex Permission was called, else Complex Permission was't called.
  Future<bool> requestComplexPermission() async {
    final bool resultRequestComplex = await _channel.invokeMethod(
      "requestComplexPermission",
    );
    return resultRequestComplex;
  }

  /// Used to reset Complex Android permissions.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 10 or above.
  /// * If return true, Complex Permission was reset, else Complex Permission was't reset.
  Future<bool> resetComplexPermission() async {
    final bool resultReset = await _channel.invokeMethod(
      "resetComplexPermission",
    );
    return resultReset;
  }

  /// Used to open image folder to user select image and return this [ImageModel].
  Future<ImageModel> getImage({ArtworkFormat? format, int? quality}) async {
    final Map resultImage = await _channel.invokeMethod("getImagePath", {
      "format": format ?? ArtworkFormat.JPEG.index,
      "quality": quality ?? 100,
    });
    return ImageModel(resultImage);
  }

  /// Used to return the uri(if exist) from the folder selected from user.
  /// This uri will be avalible after [requestComplexPermission] or [editAudio] when
  /// using Android 10 or above.
  Future<String?> getUri({bool originalPath = false}) async {
    String? resultUri = await _channel.invokeMethod('getUri');
    if (!originalPath) {
      resultUri = resultUri?.replaceAll(
        "content://com.android.externalstorage.documents/tree",
        "",
      );
      resultUri = resultUri?.replaceAll("primary%3A", "");
      resultUri = resultUri?.replaceAll("%3A", "/");
      resultUri = resultUri?.replaceAll("%2F", "/");
    }
    return resultUri != null ? resultUri + "/" : null;
  }

  /// Used to return a converted value from file length.
  double convertLengthToMb(int length, bool roundNum) {
    var num = roundNum == true ? 100 : 10;
    double firstConvert = length / 1000;
    return (firstConvert / 1000 * num).roundToDouble() / num;
  }
}
