// ignore_for_file: constant_identifier_names

part of on_audio_edit;

/// Defines the type of image.
enum ArtworkFormat {
  /// Note: [JPEG] images give a better performance when call the method and give a "bad" image quality.
  JPEG,

  /// Note: [PNG] images give a slow performance when call the method and give a "good" image quality.
  PNG,
}
