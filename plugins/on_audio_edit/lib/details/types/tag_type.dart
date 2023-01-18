// ignore_for_file: constant_identifier_names

part of on_audio_edit;

/// All the songs tags type.
enum TagType {
  ///
  ACOUSTID_FINGERPRINT,

  ///
  ACOUSTID_ID,

  ///
  ALBUM,

  ///
  ALBUM_ARTIST,

  ///
  ALBUM_ARTIST_SORT,

  ///
  ALBUM_SORT,

  ///
  AMAZON_ID,

  ///
  ARRANGER,

  ///
  ARTIST,

  ///
  ARTIST_SORT,

  ///
  ARTISTS,

  ///
  BARCODE,

  ///
  BPM,

  ///
  CATALOG_NO,

  ///
  COMMENT,

  ///
  COMPOSER,

  ///
  COMPOSER_SORT,

  ///
  CONDUCTOR,

  ///
  COUNTRY,

  ///
  COVER_ART,

  ///
  CUSTOM1,

  ///
  CUSTOM2,

  ///
  CUSTOM3,

  ///
  CUSTOM4,

  ///
  CUSTOM5,

  ///
  DISC_NO,

  ///
  DISC_SUBTITLE,

  ///
  DISC_TOTAL,

  ///
  DJMIXER,

  ///
  ENCODER,

  ///
  ENGINEER,

  ///
  FBPM,

  ///
  GENRE,

  ///
  GROUPING,

  ///
  ISRC,

  ///
  IS_COMPILATION,

  ///
  KEY,

  ///
  LANGUAGE,

  ///
  LYRICIST,

  ///
  LYRICS,

  ///
  MEDIA,

  ///
  MIXER,

  ///
  MOOD,

  ///
  MUSICBRAINZ_ARTISTID,

  ///
  MUSICBRAINZ_DISC_ID,

  ///
  MUSICBRAINZ_ORIGINAL_RELEASE_ID,

  ///
  MUSICBRAINZ_RELEASEARTISTID,

  ///
  MUSICBRAINZ_RELEASEID,

  ///
  MUSICBRAINZ_RELEASE_COUNTRY,

  ///
  MUSICBRAINZ_RELEASE_GROUP_ID,

  ///
  MUSICBRAINZ_RELEASE_STATUS,

  ///
  MUSICBRAINZ_RELEASE_TRACK_ID,

  ///
  MUSICBRAINZ_RELEASE_TYPE,

  ///
  MUSICBRAINZ_TRACK_ID,

  ///
  MUSICBRAINZ_WORK_ID,

  ///
  MUSICIP_ID,

  ///
  OCCASION,

  ///
  ORIGINAL_ALBUM,

  ///
  ORIGINAL_ARTIST,

  ///
  ORIGINAL_LYRICIST,

  ///
  ORIGINAL_YEAR,

  ///
  QUALITY,

  ///
  PRODUCER,

  ///
  RATING,

  ///
  RECORD_LABEL,

  ///
  REMIXER,

  ///
  SCRIPT,

  ///
  SUBTITLE,

  ///
  TAGS,

  ///
  TEMPO,

  ///
  TITLE,

  ///
  TITLE_SORT,

  ///
  TRACK,

  ///
  TRACK_TOTAL,

  ///
  URL_DISCOGS_ARTIST_SITE,

  ///
  URL_DISCOGS_RELEASE_SITE,

  ///
  URL_LYRICS_SITE,

  ///
  URL_OFFICIAL_ARTIST_SITE,

  ///
  URL_OFFICIAL_RELEASE_SITE,

  ///
  URL_WIKIPEDIA_ARTIST_SITE,

  ///
  URL_WIKIPEDIA_RELEASE_SITE,

  ///
  YEAR,

  // Non editable tags

  /// This tag cannot be modified!
  BITRATE,

  /// This tag cannot be modified!
  CHANNELS,

  /// This tag cannot be modified!
  FIRST_ARTWORK,

  /// This tag cannot be modified!
  FORMAT,

  /// This tag cannot be modified!
  TRACK_LENGTH,

  /// This tag cannot be modified!
  SAMPLE_RATE,

  /// This tag cannot be modified!
  ENCODING_TYPE,
}
