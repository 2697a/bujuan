part of on_audio_edit;

/// [AudioModel] contains all Song Tag/Information.
class AudioModel {
  AudioModel(this._info);

  /// The type dynamic is used for both but, the map is always based in [String, dynamic]
  final Map<dynamic, dynamic> _info;

  /// Return song [acoustIdFingerPrint]
  String? get acoustIdFingerPrint => _info["ACOUSTID_FINGERPRINT"];

  /// Return song [acoistIdID]
  int? get acoistIdID => _info["ACOUSTID_ID"];

  /// Return song [album]
  String? get album => _info["ALBUM"];

  /// Return song [albumArtist]
  String? get albumArtist => _info["ALBUM_ARTIST"];

  /// Return song [albumArtistSort]
  String? get albumArtistSort => _info["ALBUM_ARTIST_SORT"];

  /// Return song [albumSort]
  String? get albumSort => _info["ALBUM_SORT"];

  /// Return song [amazonId]
  String? get amazonId => _info["AMAZON_ID"];

  /// Return song [arranger]
  String? get arranger => _info["ARRANGER"];

  /// Return song [artist]
  String? get artist => _info["ARTIST"];

  /// Return song [artistSort]
  String? get artistSort => _info["ARTIST_SORT"];

  /// Return song [artists]
  String? get artists => _info["ARTISTS"];

  /// Return song [artists]
  String? get barcode => _info["BARCODE"];

  /// Return song [beatsPerMinutes]
  int? get beatsPerMinutes => _info["BEATS_PER_MINUTE"];

  /// Return song [caralogNo]
  int? get caralogNo => _info["CATALOG_NO"];

  /// Return song [comment]
  int? get comment => _info["COMMENT"];

  /// Return song [composer]
  String? get composer => _info["COMPOSER"];

  /// Return song [composerSort]
  String? get composerSort => _info["COMPOSER_SORT"];

  /// Return song [conductor]
  String? get conductor => _info["CONDUCTOR"];

  /// Return song [country]
  String? get country => _info["COUNTRY"];

  /// Return song [country]
  String? get coverArt => _info["COVER_ART"];

  /// Return song [discNo]
  String? get discNo => _info["DISC_NO"];

  /// Return song [discSubtitle]
  String? get discSubtitle => _info["DISC_SUBTITLE"];

  /// Return song [discTotal]
  String? get discTotal => _info["DISC_TOTAL"];

  /// Return song [djMixer]
  String? get djMixer => _info["DJMIXER"];

  /// Return song [encoder]
  String? get encoder => _info["ENCODER"];

  /// Return song [engineer]
  String? get engineer => _info["ENGINEER"];

  /// Return song [fbmp]
  String? get fbmp => _info["FBPM"];

  /// Return song [genre]
  String? get genre => _info["GENRE"];

  /// Return song [grouping]
  String? get grouping => _info["GROUPING"];

  /// Return song [isrc]
  String? get isrc => _info["ISRC"];

  /// Return song [isCompilation]
  String? get isCompilation => _info["IS_COMPILATION"];

  /// Return song [key]
  int? get key => _info["KEY"];

  /// Return song [language]
  String? get language => _info["LANGUAGE"];

  /// Return song [lyricist]
  String? get lyricist => _info["LYRICIST"];

  /// Return song [lyrics]
  String? get lyrics => _info["LYRICS"];

  /// Return song [media]
  String? get media => _info["MEDIA"];

  /// Return song [mixer]
  String? get mixer => _info["MIXER"];

  /// Return song [mood]
  String? get mood => _info["MOOD"];

  /// Return song [musicBrainzArtistId]
  int? get musicBrainzArtistId => _info["MUSICBRAINZ_ARTISTID"];

  /// Return song [musicBrainzDiscId]
  int? get musicBrainzDiscId => _info["MUSICBRAINZ_DISC_ID"];

  /// Return song [musicBrainzOriginalReleaseId]
  int? get musicBrainzOriginalReleaseId =>
      _info["MUSICBRAINZ_ORIGINAL_RELEASE_ID"];

  /// Return song [musicBrainzReleaseArtistId]
  int? get musicBrainzReleaseArtistId => _info["MUSICBRAINZ_RELEASEARTISTID"];

  /// Return song [musicBrainzReleaseId]
  int? get musicBrainzReleaseId => _info["MUSICBRAINZ_RELEASEID"];

  /// Return song [musicBrainzReleaseCountry]
  String? get musicBrainzReleaseCountry => _info["MUSICBRAINZ_RELEASE_COUNTRY"];

  /// Return song [musicBrainzReleaseGroupId]
  int? get musicBrainzReleaseGroupId => _info["MUSICBRAINZ_RELEASE_GROUP_ID"];

  /// Return song [musicBrainzReleaseStatus]
  String? get musicBrainzReleaseStatus => _info["MUSICBRAINZ_RELEASE_STATUS"];

  /// Return song [musicBrainzReleaseTrackId]
  int? get musicBrainzReleaseTrackId => _info["MUSICBRAINZ_RELEASE_TRACK_ID"];

  /// Return song [musicBrainzReleaseType]
  String? get musicBrainzReleaseType => _info["MUSICBRAINZ_RELEASE_TYPE"];

  /// Return song [musicBrainzTrackId]
  int? get musicBrainzTrackId => _info["MUSICBRAINZ_TRACK_ID"];

  /// Return song [musicBrainzWorkId]
  int? get musicBrainzWorkId => _info["MUSICBRAINZ_WORK_ID"];

  /// Return song [musiCIPID]
  int? get musiCIPID => _info["MUSICIP_ID"];

  /// Return song [occasion]
  int? get occasion => _info["OCCASION"];

  /// Return song [originalAlbum]
  String? get originalAlbum => _info["ORIGINAL_ALBUM"];

  /// Return song [originalAlbum]
  String? get originalArtist => _info["ORIGINAL_ARTIST"];

  /// Return song [originalLyricist]
  String? get originalLyricist => _info["ORIGINAL_LYRICIST"];

  /// Return song [originalYear]
  int? get originalYear => _info["ORIGINAL_YEAR"];

  /// Return song [quality]
  int? get quality => _info["QUALITY"];

  /// Return song [producer]
  String? get producer => _info["PRODUCER"];

  /// Return song [rating]
  int? get rating => _info["RATING"];

  /// Return song [recordLabel]
  String? get recordLabel => _info["RECORD_LABEL"];

  /// Return song [remixer]
  String? get remixer => _info["REMIXER"];

  /// Return song [remixer]
  String? get script => _info["SCRIPT"];

  /// Return song [subTitle]
  String? get subTitle => _info["SUBTITLE"];

  /// Return song [tags]
  String? get tags => _info["TAGS"];

  /// Return song [tempo]
  int? get tempo => _info["TEMPO"];

  /// Return song [title]
  String get title => _info["TITLE"];

  /// Return song [titleSort]
  String? get titleSort => _info["TITLE_SORT"];

  /// Return song [track]
  int? get track => _info["TRACK"];

  /// Return song [trackTotal]
  int? get trackTotal => _info["TRACK_TOTAL"];

  /// Return song [urlDiscOGSArtistSite]
  String? get urlDiscOGSArtistSite => _info["URL_DISCOGS_ARTIST_SITE"];

  /// Return song [urlDiscOGSReleaseSite]
  String? get urlDiscOGSReleaseSite => _info["URL_DISCOGS_RELEASE_SITE"];

  /// Return song [urlLyricsSite]
  String? get urlLyricsSite => _info["URL_LYRICS_SITE"];

  /// Return song [urlOfficialArtistSite]
  String? get urlOfficialArtistSite => _info["URL_OFFICIAL_ARTIST_SITE"];

  /// Return song [urlOfficialReleaseSite]
  String? get urlOfficialReleaseSite => _info["URL_OFFICIAL_RELEASE_SITE"];

  /// Return song [urlWikipediaArtistSite]
  String? get urlWikipediaArtistSite => _info["URL_WIKIPEDIA_ARTIST_SITE"];

  /// Return song [urlWikipediaReleaseSite]
  String? get urlWikipediaReleaseSite => _info["URL_WIKIPEDIA_RELEASE_SITE"];

  /// Return song [year]
  String? get year => _info["YEAR"];

  //

  /// Return song [bitrate]
  int? get bitrate => _info["BITRATE"];

  /// Return song [channels]
  String? get channels => _info["CHANNELS"];

  /// Return song [country]
  Uint8List? get firstArtwork => _info["FIRST_ARTWORK"];

  /// Return song [format]
  String? get format => _info["FORMAT"];

  /// Return song [length]
  int? get length => _info["LENGTH"];

  /// Return song [format]
  int? get sampleRate => _info["SAMPLE_RATE"];

  /// Return song [length]
  String? get type => _info["TYPE"];

  /// Return a map with all [keys] and [values] from specific song.
  Map get getMap => _info;

  @override
  String toString() {
    var tmpInfo = _info;
    if (tmpInfo["FIRST_ARTWORK"] != null) {
      tmpInfo.update("FIRST_ARTWORK", (value) => "${value.length} (Bytes)");
    }
    return tmpInfo.toString();
  }
}
