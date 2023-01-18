part of on_audio_edit;

/// [ImageModel] contains the image information.
class ImageModel {
  ImageModel(this._info);

  /// The type dynamic is used for both but, the map is always based in [String, dynamic]
  final Map<dynamic, dynamic> _info;

  /// Return the image in bytes.
  Uint8List get imageBytes => _info["imageBytes"];

  /// Return the image data(path).
  String get imageData => _info["imageData"];

  /// Return a map with all [keys] and [values].
  Map get getMap => _info;

  @override
  String toString() {
    var tmpInfo = _info;
    tmpInfo.update("imageBytes", (value) => "${value.length} (Bytes)");
    return tmpInfo.toString();
  }
}
